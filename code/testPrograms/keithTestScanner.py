import pyvisa
import time

rm = pyvisa.ResourceManager()
keith = rm.open_resource('GPIB::16::INSTR')

#Reset Init, arm and trig subsystems
keith.write("*rst")
#reset the status subsystem
keith.write("stat:pres;*cls")

#Set so the srq line gets turned on when buffer full
keith.write("stat:meas:enab 512") #BFL
keith.write("*sre 1") # MSB

#Pick channel 1
keith.write("rout:clos (@1)");
#Set offset compensation and fres measurement on trigger
keith.write(':sens:fres:ocom 1')
keith.write("func 'fres'")
keith.write("sens:fres:range:auto:ulim 1;llim 0")
keith.write("sens:fres:dig 9")


#Set trigger with delay on init
keith.write("trig:count 10")
#query buff size
keith.write("trac:poin 10;egr full")
#From where
keith.write("trac:feed sens1;feed:cont next")
#Now measure with an init
keith.write("init")



keith.wait_for_srq()

keith.write("form:elem read")
resis = keith.query_ascii_values("trac:data?")
print("Average Resistance1: ", sum(resis)/len(resis))

########################################################
keith.write("rout:clos (@2)")
keith.write("trac:feed sens;feed:cont next")
keith.write("init")

#Should actually be a poll and w8 for srq
time.sleep(5)

resis = keith.query_ascii_values("trac:data?")
print("Average Resistance2: ", sum(resis)/len(resis))

########################################################
keith.write("rout:clos (@3)")
###Must change the upper limit here
keith.write("sens:fres:range:auto:ulim 67;llim 0")
#This is just to tell the multimeter to  store the next measurements
keith.write("trac:feed sens;feed:cont next")
keith.write("init")

#Should actually be a poll and w8 for srq
time.sleep(5)

resis = keith.query_ascii_values("trac:data?")
print("Average Resistance2: ", sum(resis)/len(resis))