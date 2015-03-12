echo off
REM	Batch file for Compilation and Linking of a Borland Turbo Pascal
REM        program that uses the HP-IB Command Library for MS-DOS.
REM
REM     Copyright (c) Hewlett-Packard Co. 1985, 1986,1989
REM
if not exist %1.pas goto badfile 
if not "%2" == "" goto usage
echo.
echo  TPC %1
echo.
tpc %1
goto end

:badfile
echo.
echo          File "%1.PAS" does not exist
echo.
goto usage

:usage
echo.
echo          usage:  TPASCL {filename}
echo.
echo                  Where {filename} is a Turbo Pascal program stored
echo                  in ASCII format.  Do no include the .PAS extension.
echo.
echo                  Example:   To compile and link the program
echo                             PASPROG.PAS, type:
echo.
echo                                   TPASCL PASPROG
echo.
echo                             from the MS-DOS command line.
echo                             No other parameters are permitted.
echo.
goto end

:end
