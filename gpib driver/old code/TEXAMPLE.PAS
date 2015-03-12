PROGRAM hpib;

{ This program is a modified version of the Op Amp program described
  in the HP-IB Command Library for MS-DOS manual.           }

{$ifdef VER50}
    uses p50hpib;
{$endif}

{$ifdef VER55}
    uses p55hpib;
{$endif}

{$ifdef VER60}
    uses p60hpib;
{$endif}

{$ifdef VER70}
    uses p70hpib;
{$endif}


{$I tiodecl.ex}

TYPE
  str10          = string[10];

VAR
  isc            : LONGINT;        { interface select code }
  source         : LONGINT;        { address of source     }
  dvm            : LONGINT;        { address of voltmeter  }

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

PROCEDURE Error_handler (error: integer; routine: str10);

     { Checks for error return from I/O Library call }

BEGIN
  IF error <> noerr THEN BEGIN
     writeln;
     writeln ('Error in call to ', routine);
     writeln (error:6, Errstr (error));
     writeln;
     write ('Press <RETURN> to continue program: ');
     readln;
   END; { if }
END;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

PROCEDURE Getaddr;

BEGIN
  write ('Enter interface select code (usually 7) <RET> ');
  readln (isc);
  REPEAT
     write ('Enter bus address of source: ');
     readln (source);
     IF (source > 29) or (source < 0) THEN
        writeln ('     Bus address must be between 0 and 29');
  UNTIL (source >= 0) AND (source <= 29);
  REPEAT
     write ('Enter bus address of voltmeter: ');
     readln (dvm);
     IF (dvm > 29) OR (dvm < 0) THEN
        writeln('      Bus address must be between 0 and 29')
     ELSE
        IF dvm = source THEN BEGIN
           writeln ('     Source and voltmeter may not have the same address');
           dvm := -1;
        END; { if }
   UNTIL (dvm >= 0) AND (dvm <= 29);
   source := isc * 100 + source;
   dvm := isc * 100 + dvm;
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

PROCEDURE Initialize;

     { Performs bus initialization.  Establishes a timeout value in the
       event there is an error in a device, sends a universal device
       clear placing all devices in a known state and sets REN so devices
       will go to remote mode when addressed to listen.                   }

VAR
  return_status: integer;

BEGIN
  return_status := IORESET (isc);
  Error_handler (return_status, 'IORESET   ');
  return_status := IOTIMEOUT (isc, 5.0);    
  Error_handler (return_status, 'IOTIMEOUT ');
  return_status := IOCLEAR (isc);
  Error_handler (return_status, 'IOCLEAR   ');
  return_status := IOREMOTE (isc);
  Error_handler (return_status, 'IOREMOTE  ');
END;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

PROCEDURE Source_setup;

     { Set up the function generator.  Select rear panel signal output,
       sine wave function with start frequency of 1 kHz, stop frequence
       of 10 kHz and marker frequency of 1 kHz, sets amplitude to 2 Vrms
       and selects a sweep time of 5 seconds.                             }

VAR
  commands         : string[38];
  return_status    : integer;       
    
BEGIN
  commands := 'RF2 FU1 ST1KH SP10KH MF1KH AM2VR TI5SE';
  return_status := IOOUTPUTS (source, commands, 38);
  Error_handler (return_status, 'IOOUTPUTS ');
END;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

PROCEDURE Dvm_setup;

     { Sets up voltmeter.  Performs a software reset, sets the service
       request mask, selects AC volts function, 10 volt range, turns
       filtering and auto-zero off, selects the 4-digit display, 
       prepares to take and store 20 readings upon trigger.               }

 
VAR
  commands       : string[38];
  return_status  : integer;

BEGIN
  commands := 'H SM004 F2 R4 FL0 Z0 4STG 20STN RS1 T4';
  return_status := IOOUTPUTS (dvm, commands, 38);
  Error_handler (return_status, 'IOOUTPUTS ');
END;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

PROCEDURE Trigger;

     { Trigger both devices.  Demonstrates two ways a device might be
       triggered.                                                         }

VAR
  commands       : string[2];
  return_status  : integer;

BEGIN
  return_status := IOTRIGGER (dvm);
  Error_handler (return_status, 'IOTRIGGER ');
  commands := 'SS';
  return_status := IOOUTPUTS (source, commands, 2);
  Error_handler (return_status, 'IOOUTPUTS ');
END;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

PROCEDURE Wait_for_SRQ;

     { Wait for voltmeter to request service indicating it is done.  
       Serial poll the voltmeter to be sure it was the device that
       requested service.                                                 }

CONST
  srqline = 1;

VAR
  return_status  : integer;
  response       : integer;
  done           : boolean;

BEGIN
  done := false;
  REPEAT
    REPEAT
      return_status := IOSTATUS (isc, srqline, response);
      Error_handler (return_status, 'IOSTATUS  ');
    UNTIL response <> 0;
    return_status := IOSPOLL (dvm, response);
    Error_handler (return_status, 'IOSPOLL   ');
    done := (response = 68);
  UNTIL done;
END; 

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

PROCEDURE Readout;

VAR
  commands       : string[14];
  i              : integer;
  length         : integer;
  numvalues      : integer;
  readings       : array[1..20] of real;
  return_status  : integer;

BEGIN
  numvalues := 20;
  length := 14;
  commands := 'SO1 -20STR RER';
  return_status := IOOUTPUTS (dvm, commands, length);
  Error_handler (return_status, 'IOOUTPUTS ');

  return_status := IOEOI (isc, 0);     { must be disabled to allow more than
                                         one value to be read into array  }
  Error_handler (return_status, 'IOEOI     ');
  return_status := IOENTERA (dvm, readings, numvalues);
  Error_handler (return_status, 'IOENTERA  ');
  writeln ('The readings are: ');
  FOR i := 1 TO numvalues DO
      writeln (readings[i]:10:5);
END;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

BEGIN { main }
  Getaddr;
  Initialize;
  Source_setup;
  Dvm_setup;
  Trigger;
  Wait_for_SRQ;
  Readout;
END. { main }
