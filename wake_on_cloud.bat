@REM --------------------------------------------------------------
@REM Name: wake_on_cloud
@REM Author: Jerome H.
@REM Contact: contact (at) wire67.com 
@REM Version: 2016-03-07
@REM --------------------------------------------------------------

@REM 1=debug or 0=release
@SET DEBUG=0

@if %DEBUG% NEQ 1 echo off

REM the command file location in the synchronized cloud directory
SET varfile="X:\Dropbox\keep_acer_on.txt"
REM the feedback file location in the synchronized cloud directory
SET outfile="X:\Dropbox\acer_feedback.txt"
REM the login file location containing the last login timestamp
SET loginfile="C:\login.txt"
REM the file update delay, needs to be long enought to let the command file be updated from cloud 
SET /a DELAY=240
REM how many hours after the last login is it autorised to sleep 
SET /a hoursbeforesleep=4

:START

if %DEBUG% EQU 1 (
REM uncomment to speed up the delay
REM SET /a DELAY=5
)

echo.
echo %date% %time%
echo.
echo awake %date% %time%>%outfile%

echo.
echo Start Dropbox if not yet running:
CALL launch_dropbox.bat
echo Started.
echo.

echo wait %DELAY% sec for command file update...
ping 127.0.0.1 -n %DELAY%+1 > NUL
echo check %varfile% ...

set /p keep_on=<%varfile%

echo info keep_on=%keep_on% 

if '%keep_on%' EQU 'false' ( goto CHECKLOGIN )
if '%keep_on%' EQU '0' ( goto CHECKLOGIN )
REM ELSE keep on
goto FIN
 
:CHECKLOGIN
set /p logincontent=<%loginfile%
for /f "tokens=1" %%G IN ("%logincontent%") DO SET /a logintime=%%G 

echo info login logintime=%logintime% 
REM setup a timestamp
set /a timestamp=(%date:~6,4% * 12)
if %date:~3,1% EQU 0 (set /a timestamp=%timestamp% + %date:~4,1%) else (set /a timestamp=%timestamp% + %date:~3,2%)
set /a timestamp=(%timestamp% * 31)
if %date:~0,1% EQU 0 (set /a timestamp=%timestamp% + %date:~1,1%) else (set /a timestamp=%timestamp% + %date:~0,2%)
set /a timestamp=(%timestamp% * 24)
set /a timestamp=(%timestamp% + %time:~0,2%) * 60
set /a timestamp=(%timestamp% + %time:~3,2%) * 60
set /a passttimestamp=(%timestamp% - %hoursbeforesleep%*60*60)

echo info login timestamp=%timestamp% 
echo info login passttimestamp=%passttimestamp% 

if %logintime% LSS %passttimestamp% ( goto SLEEP )
REM ELSE
echo session-open>%outfile%
goto FIN

:SLEEP
echo sleeping %date% %time%>%outfile%
echo simple standby
powercfg -hibernate off
echo quiet standby ...
if %DEBUG% NEQ 1 (
	echo in %DELAY% sec...
	ping 127.0.0.1 -n %DELAY%+1 > NUL
	rem Rundll32.exe Powrprof.dll,SetSuspendState Sleep
	wizmo.exe quiet standby
	echo end of sleep command
	echo wait %DELAY% sec...
	ping 127.0.0.1 -n %DELAY%+1 > NUL
)

REM after wake-up, check again
GOTO START

:FIN
echo End Of Script