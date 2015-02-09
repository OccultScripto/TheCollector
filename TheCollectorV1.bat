@setlocal enableextensions enabledelayedexpansion
@echo off

echo Powered by Ionut Indre >> resultGathering.txt
echo Credentials Colected >> resultGathering.txt
echo ----------------------------------------------------------------------- >> resultGathering.txt

:: Collect all the SSID saved on computer and dump then to a txt file.
netsh wlan show profiles | findstr : >> collector.txt

for /F "tokens=5*" %%i in (collector.txt) do (
    echo ----SSID                   : %%i %%j >> resultGathering.txt
	
	:: Select the password for the current SSID and write it to the result file.
	netsh wlan show profiles name=%%i %%j key=clear | findstr "Key Content" >> resultGathering.txt
	echo ----------------------------------------------------------------------- >> resultGathering.txt 
)

del collector.txt

:: The issue is that does not collect the credentials where SSID contains space.