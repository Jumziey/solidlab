Notes on Low Resistance Measurments
======
We have just wipped some notes together from different sources

First paper = "Accurate Low-Resistance Measurements Start with Identifying Sources of Error" - keithley
-----
###Thermoelectric voltages
Is an effect that happens in different metal junktions or as leads get different temperatures during measurements. This is probably critical to take care of since we go from 10 degrees Kelvin to 300  

Things we can do to compensate includes:  

* Current-Reversal
* Delta method
* Offset-Compensation
###Non ohmic contacts
When potential difference across a contact isn't linearly proportional to the current flowing through it. Mostly due oxide films or other non-linear conneections. This is likely to rectify any radio frequency energy present, leading to the apperance of an offset voltage in the circuit. 

If this happening the offset-compensated ohm method is preferable to reverse current.

Make sure that connections are clean. choose good contact material such as indiom or gold. To reduce use sheilding and ground properly to reduce AC pickup. 


Second paper = "Making Precision Low Voltage and Low Resistance Measurements" - keithley
------
###Thermoelectric Voltage
* Current reversal
* Delta Method
* Offset compensated ohms method
###RFI/EMI
Disturbance due to radio signals

* Sheilding


###Zero drift
Change in the meter reading with no input signal

*  Make sure measurement equipment are in a temperature stable enviroment

###Johnson Noise
It's the ultimate limit of resolution in an electrical measurment

v = sqrt(4kTBR)

k = boltzmann  
T = absolute temperature of the source in Kelvin   
B = noise bandwith in hertz   
R = resistance of the source in ohms   

###Notes concerning superconductor measurments
First off it's recommended to use a model2182A nanovoltmeter and a model6220 current source A kit that costs about 60 000 swedish kronor. 

Note that we have critical current density that we can go above. 