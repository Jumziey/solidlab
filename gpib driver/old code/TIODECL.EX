CONST
  noerr    = 0;
  eunknown = 1;
  esel     = 2;
  erange   = 3;
  etime    = 4;
  ectrl    = 5;
  epass    = 6;
  enum     = 7;
  eaddr    = 8;
  efile    = 9;
  UNL	= '?';
  UNT	= '_';
  TAD	= '@';
  LAD	= ' ';

TYPE
  xxstr40 = STRING[40];

function errstr (error: integer): xxstr40;

begin
   case error of
	NoErr:	  errstr := ' No error                               ';
	EUnknown: errstr := ' Unknown error                          ';
	Esel:	  errstr := ' Invalid select code or device address  ';
	ERange:	  errstr := ' Value out of range                     ';
	ETime:	  errstr := ' Timeout                                ';
	ECtrl:	  errstr := ' HP-IB must be controller               ';
	EPass:	  errstr := ' Pass control not permitted             ';
	ENum:	  errstr := ' Invalid number                         ';
	EAddr:	  errstr := ' Improper addressing                    ';
	EFile:	  errstr := ' File I/O error                         ';
	else
	     errstr := ' What?                                  ';
   end;
end;
