PROGRAM TEMPERATURMATNING;

USES P60HPIB,CRT;

{$I tiodecl.ex}

type   (* type declarations follow *)
    strtype = string[255];
   
var
    isc 	  :longint;
    cmd 	  :strtype;
    len,i 	  :integer;
    response	  :integer;
    ADRESS,TEMPKONTR:LONGINT;
    TEMPDATA:REAL;


procedure error_handle(error : integer; routine: strtype);

var retval : INTEGER ;
begin
    if error <> NOERR then begin

	(* we have an error, so let's abort all activity on the HPIB bus
	 *)
	retval := IOABORT(isc) ;

	writeln('Error in call to ', routine, error:3, errstr(error));
	halt(1);
    end;
end;

PROCEDURE INITTEMP;

BEGIN
  ISC:=7;
  ADRESS:=24;
  TEMPKONTR:=ISC*100+24;

END;



PROCEDURE GETTEMPDATA(VAR TEMPDATA:REAL);

BEGIN     {*  T<CR> CR indicates that we have rs232 communication *}

  CMD:='T';           {*'T' SŽTTER TEMPGIVARE 1 AKTIV, 't' F™R TEMP 2*}
  error_handle(IOOUTPUTS(TEMPKONTR, cmd,1), 'IOOUTPUT #1'); {*TEMPKONTR ŽR *}
  error_handle(IOENTER(TEMPKONTR, TEMPDATA), 'IOENTER #1'); {*ADRESSEN TILL TEMP. REGULAT.*}
                                                            {*TEMPDATA ŽR MŽTVŽRDET.*}

END;

BEGIN

  INITTEMP;
  FOR i:=1 TO 10 DO
  BEGIN
    GETTEMPDATA(TEMPDATA);
    WRITELN(TEMPDATA);
    DELAY(1000);
  END;
END.



