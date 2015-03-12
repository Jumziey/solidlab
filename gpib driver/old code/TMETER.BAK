{
 This example uses the HP 34401A Multimeter as the primary device.
 We will also use the HP 3325A Function Generator as a source for
 the multimeter.

 This example sets up the meter to take 128 readings, reads the data
 into an array, then plots the data on the screen.  In effect, it
 turns the multimeter into a simple oscilloscope.  This program is
 also checking other devices that are on the bus to see if they need
 service.  The SRQ line along with parallel and serial polling is
 used to make these checks.  The program will continue until the user
 presses a key on the PC keyboard.
}

program main(input, output);

{$ifdef VER50}
    uses Graph, Crt, p50hpib;
{$endif}

{$ifdef VER55}
    uses Graph, Crt, p55hpib;
{$endif}

{$ifdef VER60}
    uses Graph, Crt, p60hpib;
{$endif}

{$ifdef VER70}
    uses Graph, Crt, p70hpib;
{$endif}

{$I tiodecl.ex}

const
    NUM_READINGS = 128 ;

type   (* type declarations follow *)
    strtype = string[255];
    arrtype = array [1..NUM_READINGS] of real;
 
var
    isc 	  :longint;
    dvm 	  :longint;
    source	  :longint;
    device_addr_1 :longint;
    device_addr_2 :longint;
    cmd 	  :strtype;
    len 	  :integer;
    response	  :integer;
    readings	  :arrtype;

procedure cleanup; forward;

procedure error_handle(error : integer; routine: strtype);
var retval : INTEGER ;
begin
    if error <> NOERR then begin

	(* we have an error, so let's abort all activity on the HPIB bus
	 *)
	retval := IOABORT(isc) ;

	cleanup;
	writeln('Error in call to ', routine, error:3, errstr(error));
	halt(1);
    end;
end;

procedure cleanup;
var retval : INTEGER ;
begin

    (* clear the dvm so we can send the commands to reset it
     *)
    retval := IOCLEAR(dvm) ;

    (* reset the dvm
     *)
    cmd := ':DISP:STATE ON; *RST' ;
    len := length(cmd);
    retval := IOOUTPUTS(dvm, cmd, len) ;

    (* unconfigure the parallel poll
     *)
    retval := IOPPOLLU(isc) ;

    (* restore video mode
     *)
    CloseGraph;
end;

procedure get_data;
var
    i	    : integer;
    ymin,
    ymax    : real;
    xaxis,
    yaxis   : integer;
    temp    : real;
    textout : string;
begin

    (*	Ask the DVM to send us the data
     *)

    str (NUM_READINGS:0, cmd) ;
    cmd := ':SAMPLE:COUNT ' + cmd + '; :READ?' ;
    len := length(cmd);
    error_handle(IOOUTPUTS(dvm, cmd, len), 'IOOUTPUTS #2');

    (*	Read the data
     *)

    len := NUM_READINGS ;
    error_handle(IOENTERA(dvm, readings, len), 'IOENTERA #1');


    (*	graph the data
     *)

    (* clear screen, and draw a border around the screen
     *)
    ClearDevice;
    MoveTo(0,0);
    LineTo(GetMaxX,0);
    LineTo(GetMaxX,GetMaxY);
    LineTo(0,GetMaxY);
    LineTo(0,0);

    (* find the minimum and maximum values in the data
     *)
    ymin := readings[1];
    ymax := readings[1];

    for i:=1 to len do begin
	if (readings[i] < ymin) then ymin := readings[i];
	if (readings[i] > ymax) then ymax := readings[i];
    end;

    (* print some labels
     *)
    str(ymax:0, textout);
    textout := 'MAX = ' + textout;
    OutTextXY(2, 2, textout);

    str(ymin:0, textout);
    textout := 'MIN = ' + textout;
    OutTextXY(2, GetMaxY-TextHeight(textout), textout);

    (* scale the min and max values to give extra space on top & bottom
     * of screen
     *)
    if ymin > 0 then
	ymin := ymin *	0.6
    else
	ymin := ymin * 1.4;

    if ymax > 0 then
	ymax := ymax * 1.4
    else
	ymax := ymax * 0.6;

    (* plot the data
     *)
    temp := readings[1];
    temp := ((temp-ymin) * GetMaxY) / (ymax-ymin);
    yaxis := round(GetMaxY-temp);
    MoveTo(0, yaxis);
    for i := 2 to len do begin
	temp := i;
	temp := temp * GetMaxX;
	temp := temp / (len - 1);
	xaxis := round(temp);

	temp := readings[i];
	temp := ((temp-ymin) * GetMaxY) / (ymax-ymin);
	yaxis := round(GetMaxY-temp);

	LineTo(xaxis, yaxis);
    end;
end;

procedure poll_device (dev_addr: longint) ;
var
    response : integer;
begin

    (* do a serial poll of the device configured to use parallel
     *	poll line 0
     *)
    error_handle(IOSPOLL(dev_addr, response), 'IOSPOLL #3');

    (* should check RESPONSE here to see if any action needs to be taken.
     * the values that RESPONSE can take are device dependent.
     *)
end;


procedure check_srq;
var
    response : integer;
begin
    (* conduct a parallel poll
     * note that the source doesn't respond to parallel poll's,
     *	so we need to poll that device separately.
     *)
    error_handle(IOPPOLL(isc, response), 'IOPPOLL #1');
    if ((response and 1) <> 0) then
	poll_device (device_addr_1);

    if ((response and 2) <> 0) then
	poll_device (device_addr_2);

    (* check all devices that were configured to respond to
     *	parallel poll
     *)

    (* check any other devices on the bus here that weren't
     *	configured to respond to parallel poll by performing
     *	a serial poll on each one.
     *)
    error_handle(IOSPOLL(source, response), 'IOSPOLL #2');

    (* see if we've cleared the srq yet
     *)
    error_handle(IOSTATUS(isc, 1, response), 'IOSTATUS #3');
    if (response = 1) then begin
	cleanup;
	writeln('SRQ locked high');
	halt(1);
    end;
end;

procedure setup;
begin
    (* let's use dma to send the strings to program the devices
     *)
    error_handle(IODMA(isc, 40, 3), 'IODMA #1');

    (* program the function generator
     *)
    cmd := 'RF1 FR30HZ FU1 ST1KH SP10KH MF1KH AM1VR TI5SE' ;
    len := length(cmd);
    error_handle(IOOUTPUTS(source, cmd, len), 'IOOUTPUTS #1');

    (* program the dvm
     *)
    cmd := ':CONF:VOLT:DC 30,.1;';
    cmd := cmd + ':ZERO:AUTO OFF;';
    cmd := cmd + ':TRIG:DELAY MIN;';
    cmd := cmd + ':DISP:STATE OFF;';
    cmd := cmd + '';
    len := length(cmd);
    error_handle(IOOUTPUTS(dvm, cmd, len), 'IOOUTPUTS #2');

    (* turn dma off again
     *)
    error_handle(IODMA(isc, 0, 3), 'IODMA #2');
end;

procedure initialize;
var
    GraphDriver : integer;
    GraphMode	: integer;
    ErrCode	: integer;
    TempChar	: char ;
begin
    isc := 7;
    dvm := isc * 100 + 22;
    source := isc * 100 + 12;
    device_addr_1 := isc * 100 + 20;
    device_addr_2 := isc * 100 + 7;

    (* initialize the hpib interface and scope
     *)
    error_handle(IORESET(isc), 'IORESET');
    error_handle(IOTIMEOUT(isc, 3.0), 'IOTIMEOUT');
    error_handle(IOCLEAR(source), 'IOCLEAR #1');
    error_handle(IOCLEAR(dvm), 'IOCLEAR #2');
    error_handle(IOFASTOUT(isc, 1), 'IOFASTOUT');
    TempChar := chr(10);
    error_handle(IOEOL(isc, TempChar, 0), 'IOEOL');

    (* We will now configure all devices that can respond to a parallel
     *	poll.  This example assumes devices at addresses 20 and 7 can
     *	respond to a parallel poll.  see operators manual of individual
     *	devices to see if they can respond to a parallel poll.
     *)

    (* configure the device at address 20 for a parallel poll
     *)
    error_handle(IOPPOLLC(device_addr_1, $08), 'IOPPOLLC #1');

    (* configure the device at address 7 for a parallel poll
     *)
    error_handle(IOPPOLLC(device_addr_2, $09), 'IOPPOLLC #2');

    (* configure any other devices that can respond to parallel poll here
     *)

    (* set video mode
     *)
    GraphDriver := Detect;
    InitGraph(GraphDriver, GraphMode, '');
    ErrCode := GraphResult;
    if ErrCode <> grOk then
    begin
	writeln ('Graphics error:', GraphErrorMsg(ErrCode));
    end;

end;

begin  { main }

    initialize;

    setup;

    while not keypressed do
    begin
	error_handle(IOSTATUS(isc, 1, response), 'IOSTATUS #1');
	if response = 1 then
	    check_srq;
	get_data ;
    end;

    cleanup;
end.
