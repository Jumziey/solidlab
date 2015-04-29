clear all
close all
clc

r1 = load('SSPRES1.DAT');
r2 = load('SSPRES2.DAT');
r3 = load('SSPRES3.DAT');
t1 = load('SSPTEMP1.DAT');
t2 = load('SSPTEMP2.DAT');
test = load('TestMeasurmentUP.dat');
test2 = load('supercondTest2.txt');
test3 = load('../measurements/superCondTest3Avg10delay04.dat');
test4 = load('../measurements/superCond3Avg20delay02');
test5 = load('../measurements/supercondAvg40delay00.dat');
%test6 = load('../measurements/superCAvg5delay02');
load('test6');
%test7 = load('../measurements/superCAvg5delay02Rev.dat');
load('test7');

Revcur=[mean([test6(:,1)';test7(:,1)'])',mean([test6(:,2)';-test7(:,2)'])'];


figure(2)
 hold all   
%axis([0 130 ])

    plot(t1,r1)
if 0
    plot(test(:,1),test(:,4))
    plot(test2(:,1),test2(:,2))
    plot(test3(:,1),test3(:,2))
    plot(test4(:,1),test4(:,2))
    plot(test5(:,1),test5(:,2))
end    
    plot(test6(:,1),test6(:,2))
    plot(test7(:,1),test7(:,2))
    plot([0 120], [0 0])
    plot(Revcur(:,1),Revcur(:,2))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('Super cond,R1 vs vs Temperature')

if 0
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
    plot(t1,r1,test(:,1),test(:,4),test2(:,1),test2(:,2))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('Super cond,R1 vs vs Temperature')

%figure(3)
subplot(2,2,3)
    plot(t1,r2,test(:,1),test(:,3))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('Metal, R2 vs Temperature')
    
%figure(4)
subplot(2,2,4)
    plot(t1,r3,test(:,1),test(:,2))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('Semi-cond, R3 vs Temperature')
    
figure(2)

    plot(t1,r1,test(:,1),test(:,4),test2(:,1),test2(:,2))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('Super cond,R1 vs vs Temperature')
end