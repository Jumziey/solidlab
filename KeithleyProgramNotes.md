How To Measure 4w resistance using offset compensation keithley
------
* We wanna do a simple average filter 5 measurments
* offsetcompensated

If this isnt enough we can try

* better digital filtering 
* measurement speed

####Program Structure 
* Set configuration button

Keithley Usage
---
###Layers of operations
* idle 
* Arm layer   
	Arm is a command waiting for a trigger to be done. Note that the factory default for the arm source is immediate, thus no w8ing is done.
	* Manual - click trig on front panel.
	* Wait for external trigger on rear panel
	* GPIB (GET OR *TRG command)
	* TRIGGER LINK (a physical cable)
	* Hold - W8s until arm source is chhanged
* Scan layer
	Scan source is factory default to immidiate, thus is skipped. But can be used to for instance give a timer between measurements. 
* Measure layer   
	Here the measuring is actually don, and in general this layer only controls the reading rate. 
Note that in default usage only the measurement layer is used. 

Actual stuff
----
We start by making sure the keithley is in the GPIB mode, that should be set before everything is said and done. Then we use the message mode 
###Display mode
* Make sure that state is enabled for both windows <:disp:wind{1,2}:text:state 1>
* Send display message <:disp:wind{1,2}:text:data "Message">
###Configuration
* Offset compensation: <:SENSe:FRESistance:OCOMpensated bool>
* Average filter: <:SENSe:FRESistance:AVERage:COUNt [1-100]>
	* Making sure its average: <:SENSe:FRESistance:AVERage:TCONtrol REPeat>

###Making measurement
* command: <:meas:fres?>

	