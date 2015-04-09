clear all
close all
clc

r1 = load('SSPRES1.DAT');
r2 = load('SSPRES2.DAT');
r3 = load('SSPRES3.DAT');
t1 = load('SSPTEMP1.DAT');
t2 = load('SSPTEMP2.DAT');
test = load('TestMeasurmentUP.dat')

figure(1)
subplot(2,2,1)
hold on
    plot(t1,r1,t1,r2,t1,r3)
    plot(test(:,1),test(:,2),test(:,1),test(:,3),test(:,1),test(:,4))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('R1,R2,R3 vs Temperature')
    hold off

%figure(2)
subplot(2,2,2)
    plot(t1,r1,test(:,1),test(:,4))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('R1 vs vs Temperature')

%figure(3)
subplot(2,2,3)
    plot(t1,r2,test(:,1),test(:,3))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('R2 vs Temperature')
    
%figure(4)
subplot(2,2,4)
    plot(t1,r3,test(:,1),test(:,2))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('R3 vs Temperature')
    

