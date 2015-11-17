@echo off
setlocal enableDelayedExpansion
set servicename=%~p0
set servicename=%servicename:\=_%
set servicename=%servicename:~1,-1%
@echo on
%~dp0/../bin/httpd.exe -k install -n %servicename%
pause