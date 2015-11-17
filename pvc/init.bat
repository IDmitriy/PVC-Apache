@echo off
setlocal enableDelayedExpansion

REM Prepares configs from *.dist files

set "conflocal=conf\local\"

for %%F in (%conflocal%*.dist) do (
  set "name=%%F"
  copy "%~dp0!name!" "%~dp0!name:.dist=!" /-Y
)

REM Creates required folders

mkdir logs

REM Prepares main config for immidiate usage

set serverroot=%~dp0
set serverroot=%serverroot:\=/%
call :txtrepl PVC_INIT_SERVER_ROOT %serverroot% %~dp0%conflocal%httpd.conf %~dp0%conflocal%httpd.conf
pause
exit

:txtrepl
rem param - find, repl, from, to
set FINDTXT=%1
set REPLTXT=%2
if EXIST %3 (
    set FILEFROM=%3
) else (
    echo error. Not found file %3
    pause
    exit
)
set FILEOUT=%4
set COUNT=0
for /F "tokens=*" %%n in (!FILEFROM!) do (
    set /A COUNT=!COUNT!+1
    set LINE=%%n
    set TMPR=!LINE:%FINDTXT%=%REPLTXT%!
    if !COUNT! == 1 (
        Echo !TMPR!>!FILEOUT!
    ) else (
        Echo !TMPR!>>!FILEOUT!
    )
)
exit /b
rem end of proc