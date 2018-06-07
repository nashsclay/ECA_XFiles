REM Editing this file may destroy your wallet or coins! Do NOT do it!
echo off
setlocal
:MENU
cls
SET LASTUPDATE= June 3, 2018
SET ELECTRAFILE=electra-desktop-setup-1.0.8.exe
SET ELECTRAOLD=electra-desktop-setup-1.0.6.exe
ECHO.
ECHO ...............................................
ECHO ECA User Support Fix-o-Lot v1.0
ECHO Windows 7, 8, 8.1, 10 ONLY!!
ECHO PRESS 1, 2, 3, 5, 6, 7, 8 to select your task, or 9 to EXIT.
ECHO ...............................................
ECHO.
ECHO 1 - Replace peers.dat
ECHO 2 - Backup Wallet
ECHO 3 - [DO STEP 2 FIRST!] Assertion Error or Blockchain reinstall also JAVA Error
ECHO 4 - Mnemonic Phrase Not Working Fix.....New Wallet
ECHO 5 - Upgrade from QT wallet
ECHO 6 - Quit Wallets
ECHO 7 - Rescan Wallet
ECHO 8 - Blockchain Update Fast Sync
ECHO 9 - EXIT
ECHO.

SET /P M=Type 1, 2, 3, 4, 5, 6, 7, or 8 then press ENTER: 
IF %M%==1 GOTO PEERS
IF %M%==2 GOTO WALLET
IF %M%==3 GOTO BLOCKREMOVAL
IF %M%==4 GOTO MNENOMIC
IF %M%==5 GOTO UPGRADE
IF %M%==6 GOTO EXPERTQUIT
IF %M%==7 GOTO RESCANME
IF %M%==8 GOTO BLOCKCHAINUPDATEFAST
IF %M%==9 GOTO EXIT

:PEERS
echo.
echo -=ECA User Spport Fix-o-Lot=-
echo.
echo Last Updated:%LASTUPDATE%
echo.
echo Wallets need to be closed. Follow the prompt to close it automatically.
pause
taskkill /F /IM  "Electra Desktop.exe" /T >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T >nul 2>&1
echo.
echo Checking for Electra folder...
IF EXIST "%APPDATA%"\Electra\ (
echo Copying files to "%APPDATA%"\Electra
copy peers.dat "%APPDATA%"\Electra\ /y
echo.
echo peers.dat successfully updated!
echo.
echo Restart your wallet and make sure you start getting connections
echo.
pause
GOTO MENU
) ELSE (
echo No Electra folder detected.
echo peers.dat update failed!
echo Exiting...
pause
GOTO MENU
)

:WALLET
echo.
echo -=ECA User Spport Fix-o-Lot=-
for /f %%x in ('wmic path win32_localtime get /format:list ^| findstr "="') do set %%x
set today=%Year%-%Month%-%Day%
echo.
echo Last Updated:%LASTUPDATE%
echo.
echo Checking for Electra folder...
IF EXIST "%APPDATA%"\Electra\ (
mkdir "%SYSTEMDRIVE%"\ElectraWalletBackup\
echo Copying wallet.dat to "%USERPROFILE%"\Documents\ElectraWalletBackup
copy "%APPDATA%"\Electra\wallet.dat "%SYSTEMDRIVE%"\ElectraWalletBackup\ /y
copy "%APPDATA%"\Electra\wallet.dat "%SYSTEMDRIVE%"\ElectraWalletBackup\%today%wallet.dat /y
echo.
echo wallet.dat successfully backedup!
echo.
echo Press any key to open up the backedup folder...
pause
explorer "%SYSTEMDRIVE%"\ElectraWalletBackup\
echo.
pause
GOTO MENU
) ELSE (
echo No Electra folder detected.
echo wallet.dat backup failed!
echo Exiting...
pause
GOTO MENU
)

:BLOCKREMOVAL
echo.
echo -=ECA User Spport Fix-o-Lot=-
echo.
echo Last Updated:%LASTUPDATE%
echo.
echo Protecting files wallet.dat, peers.dat, and Electra.conf...
echo.
attrib +r "%APPDATA%"\Electra\wallet.dat
attrib +r "%APPDATA%"\Electra\Electra.conf
attrib +r "%APPDATA%"\Electra\peers.dat
echo Now deleting Electra wallet files except protected files...
echo.
del /S /Q "%APPDATA%"\Electra\*.*
rmdir /Q "%APPDATA%"\Electra\database
rmdir /Q "%APPDATA%"\Electra\txleveldb
echo.
echo Files Deleted
echo.
attrib -r "%APPDATA%"\Electra\wallet.dat
attrib -r "%APPDATA%"\Electra\Electra.conf
attrib -r "%APPDATA%"\Electra\peers.dat
echo Unlocking files wallet.dat, peers.dat and Electra.conf to be used for wallet...
echo.
echo Files Unlocked
echo.
echo When you are finished, please run the wallet and the files will automatically install.
echo.
echo *******NOTE***** Your coins will NOT appear until it is fully synced!
echo.
echo Highly recommend go back to the menu and run the peers.dat if had sync problems
echo.
pause
GOTO MENU 

:MNENOMIC
echo.
echo -=ECA User Spport Fix-o-Lot=-
echo.
echo Last Updated:%LASTUPDATE%
echo.
SET /P I=Your wallet needs to be backedup first, is your wallet backed up [y/n]: 
if NOT "%I%"=="y" (
echo.
echo Returning to menu...
pause
GOTO MENU
)
echo.
echo You MUST have your mnenomic phrase and passphrase before you start this! No Exception!
echo.
SET /P K=Type [y/n] press ENTER: 
if NOT "%K%"=="y" (
echo.
echo Returning to menu...
pause
GOTO MENU
)
echo.
echo Press anykey to automatically close the wallet.
pause
taskkill /F /IM  "Electra Desktop.exe" /T  >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T  >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T  >nul 2>&1
cls
echo.
echo Deleting files for fix...
rmdir /S /Q "%APPDATA%\Electra Desktop"
echo.
echo Files deleted...
echo. 
echo ****STOP and READ****
echo.
echo Next, a older wallet version will be installed for recovery purposes. First, fill out the passphrase for your QT or New Wallet.
echo.
echo If you are recoving a wallet, click Recover a Wallet Via Mnemonic. DO NOT PUT ANYTHING in the extension spot unless told to by User Support!
echo.
echo You will need to complete this step and continue till you get to the white main screen in the wallet.
echo.
echo Once you see this white main screen in the wallet, come back to this command prompt and follow the directions.
echo.
echo Do NOT close the wallet!!!!
echo.
echo **********************
echo.
pause
start %ELECTRAOLD%
:MYLOOP
echo.
SET W=NULL
SET /P W=Type the word "done" with no quotes when you see the main white screen on the wallet and press Enter: 
if NOT "%W%"=="done" GOTO MYLOOP
echo.
echo Press anykey to automatically close the wallet.
pause
taskkill /F /IM  "Electra Desktop.exe" /T >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T >nul 2>&1
cls
echo.
echo Upgrading to newest wallet...
echo.
echo Fill out your passphrase when asked.
echo.
echo Pressing any key will start the installer.
echo.
pause
start %ELECTRAFILE%
echo.
echo It is recommended to run the peers.dat file if you are having syncing issues.
pause
echo.
echo Return to menu...
pause
GOTO MENU

:UPGRADE
echo.
echo -=ECA User Spport Fix-o-Lot=-
echo.
echo Last Updated:%LASTUPDATE%
echo.
echo Press anykey to automatically close the wallet.
pause
taskkill /F /IM  "Electra Desktop.exe" /T >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T >nul 2>&1
echo.
echo Ready to launch the new install...
echo Follow the install and this script will return to the main menu
pause
start "" %ELECTRAFILE%
GOTO MENU

:EXPERTQUIT
echo.
echo -=ECA User Spport Fix-o-Lot=-
echo.
echo Last Updated:%LASTUPDATE%
echo.
echo Press anykey to automatically close the wallet.
pause
taskkill /F /IM  "Electra Desktop.exe" /T >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T >nul 2>&1
echo.
echo Wallets closed. Return to menu...
echo.
pause
GOTO MENU

:RESCANME
echo.
echo -=ECA User Spport Fix-o-Lot=-
echo.
echo Last Updated:%LASTUPDATE%
echo.
echo Press anykey to automatically close the wallet.
pause
taskkill /F /IM  "Electra Desktop.exe" /T >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T >nul 2>&1
echo.
echo Wallets closed.
:RESCANMELOOP
echo.
SET B=NULL
SET /P B=Type letter q for QT or old wallet rescan. Type letter n for new wallet rescan. Press Enter: 
if "%B%"=="q" (
echo.
echo Rescanning QT_Old wallet...
echo.
echo When wallet launches you can close this box.
"%SYSTEMDRIVE%\Program Files (x86)\Electracoin\Electracoin wallet\Electra-qt.exe" -rescan
) else if "%B%"=="n" (
echo Rescanning New wallet...
echo.
echo When wallet launches you can close this box.
"%APPDATA%\..\Local\Programs\electra-desktop\Electra Desktop.exe" -rescan
) else (
echo.
echo Not a valid response, try again...
echo.
pause
GOTO RESCANMELOOP
)
echo.
echo Script done, press any key to return to the menu...
echo.
pause
GOTO MENU

:BLOCKCHAINUPDATEFAST
echo.
echo -=ECA User Spport Fix-o-Lot=-
echo.
echo Last Updated:%LASTUPDATE%
echo.
echo Checking for Electra folder...
IF EXIST "%APPDATA%"\Electra\ (
echo Copying files to "%APPDATA%"\Electra
copy peers.dat "%APPDATA%"\Electra\ /y
echo.
copy blk0001.dat "%APPDATA%"\Electra\ /y
echo.
xcopy /s txleveldb "%APPDATA%"\Electra\txleveldb /E /y
echo.
xcopy /s database "%APPDATA%"\Electra\database\ /E /y
echo.
echo Wallet successfully updated!
echo.
echo Restart your wallet and make sure you start getting connections
echo.
pause
GOTO MENU
) ELSE (
echo No Electra folder detected.
echo Going back to menu...
pause
GOTO MENU
)

:EXIT
exit
