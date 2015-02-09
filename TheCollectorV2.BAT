@setlocal enableextensions enabledelayedexpansion
@echo off

echo Powered by Ionut Indre >> resultGathering.txt
echo Credentials Colected >> resultGathering.txt
echo ----------------------------------------------------------------------- >> resultGathering.txt

:: Collect all the SSID saved on computer and dump then to a txt file.
netsh wlan show profiles * | findstr /l :"SSID name" >> collector.txt

for /F "tokens=4*" %%i in (collector.txt) do (
     echo ----SSID                   : %%i %%j >> resultGathering.txt

	:: Select the password for the current SSID and write it to the result file.
	netsh wlan show profiles name=%%i %%j key=clear | findstr "Key Content" >> resultGathering.txt

	echo ----------------------------------------------------------------------- >> resultGathering.txt 
)

del collector.txt
echo "Legend: Key Index: 1   ==> OPEN WLAN" >> resultGathering.txt
:: Firstly wanted to compute the result with regex in order to eliminate unused information.


:: Regex for selecting only the SSID ID 
::set ssid=%SSIDLine:~1,-1%


::set /P password=<password.txt
:: Regex for selecting only the password from the entire gathered line.
::set passOutput=%password:~27%
::echo PASSWORD:%passOutput% >> resultGathering.txt
::del password.txt
