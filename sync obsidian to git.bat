@echo off
setlocal
title Sync Somnium to GitHub
cd /d "%~dp0"
if errorlevel 1 goto failed

set "GIT=git"
if exist "%ProgramFiles%\Git\cmd\git.exe" set "GIT=%ProgramFiles%\Git\cmd\git.exe"
"%GIT%" --version >nul 2>&1
if errorlevel 1 (
  echo Git could not be found. Install Git for Windows and try again.
  goto failed
)

rem Only v5 triggers this repository's GitHub Pages deployment.
rem Compare the ref directly: findstr /x can reject Git's LF-only output.
set "CURRENT_BRANCH="
for /f "delims=" %%B in ('""%GIT%" branch --show-current" 2^>nul') do set "CURRENT_BRANCH=%%B"
if not "%CURRENT_BRANCH%"=="v5" (
  echo This checkout is not on branch v5.
  echo Switch to v5 before syncing. No changes were made.
  goto failed
)

echo Staging all changes in Somnium...
rem Git ignore rules still exclude Obsidian settings, private files, and build output.
"%GIT%" add --all
if errorlevel 1 goto failed

"%GIT%" diff --cached --quiet
if errorlevel 2 goto failed
if errorlevel 1 (
  "%GIT%" commit -m "Sync Obsidian notes and site changes"
  if errorlevel 1 goto failed
) else (
  echo No new changes to commit.
)

echo Pushing to GitHub...
"%GIT%" push origin v5
if errorlevel 1 goto failed

echo.
echo Sync complete. Any new commits trigger the GitHub Pages rebuild.
echo Deployment progress: https://github.com/skysliime/Somnium/actions
echo Website: https://skysliime.github.io/Somnium/
echo The live site updates after deployment finishes.
pause
exit /b 0

:failed
echo.
echo Sync failed. Review the error above. Your local files are preserved.
echo If GitHub has newer commits, reconcile them before retrying.
pause
exit /b 1
