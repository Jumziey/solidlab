import pyvisa

rm = pyvisa.ResourceManager()
keith = rm.open_resource('GPIB::16::INSTR')

#Reset Init, arm and trig subsystems
keith.write("*rst")
#reset the status subsystem
keith.write("stat:pres;*cls")

#Set so the srq line gets turned on when buffer full
keith.write("stat:meas:enab 512") #BFL
keith.write("*sre 1") # MSB


#Set offset compensation and fres measurement on trigger
keith.write(':sens:fres:ocom 1')
keith.write("func 'fres'")
keith.write("sens1:fres:range:auto:ulim 1;llim 0")
keith.write("sens1:fres:dig 9")


#Set trigger with delay on init
keith.write("trig:count 10; delay .1")
#query buff size
keith.write("trac:poin 10;egr full")
#From where
keith.write("trac:feed sens1;feed:cont next")
#Now measure with an init
keith.write("init")



keith.wait_for_srq()

keith.write("form:elem read")
resis = keith.query_ascii_values("trac:data?")
print("Average Resistance: ", sum(resis)/len(resis))
