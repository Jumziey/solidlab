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
test8=load('../measurements/finalizingTest.dat');
test9=load('../measurements/V1FirstMeas.dat')

Revcur=[mean([test6(:,1)';test7(:,1)'])',mean([test6(:,2)';-test7(:,2)'])'];

maximus=max([test2(:,2)';zeros(length(test2(:,2)),1)'])';

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
   
    plot(test6(:,1),test6(:,2))
    plot(test7(:,1),test7(:,2))
    plot([0 120], [0 0])
    plot(Revcur(:,1),Revcur(:,2))

    plot(test8(:,1),test8(:,2))
   
    %plot(test2(:,1),maximus)
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('Super cond,R1 vs vs Temperature')
    legend('Original','Final test')
end


if 1
figure(1)
subplot(2,2,1)
hold all
    %plot(t1,r1,t1,r2,t1,r3)
    %plot(test(:,1),test(:,2),test(:,1),test(:,3),test(:,1),test(:,4))
    %plot(test9(:,1),test9(:,2),test9(:,1),test9(:,3),test9(:,1),test9(:,4))
    %xlabel('T [K]')
    %ylabel('Resistance, [Ohm]')
    %title('R1,R2,R3 vs Temperature')
    hold off

%figure(2)
subplot(1,3,1)
hold all
    plot(t1,r1)
    %plot(test(:,1),test(:,4))
    %plot(test2(:,1),test2(:,2))
    plot(test9(:,1),test9(:,2))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('Super cond,R1 vs vs Temperature')
    legend('Original','Latest test',...
        'Location','NorthWest')

%figure(3)
subplot(1,3,2)
hold all
    plot(t1,r2)
    %plot(test(:,1),test(:,3))
    plot(test9(:,1),test9(:,4))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('Metal, R2 vs Temperature')
    legend('Original','Latest test',...
        'Location','NorthWest')
    
%figure(4)
subplot(1,3,3)
hold all
    plot(t1,r3)
    %plot(test(:,1),test(:,2))
    plot(test9(:,1),test9(:,3))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('Semi-cond, R3 vs Temperature')
    legend('Original','Latest test')
   
end


if 0
figure(2)

    plot(t1,r1,test(:,1),test(:,4),test2(:,1),test2(:,2))
    xlabel('T [K]')
    ylabel('Resistance, [Ohm]')
    title('Super cond,R1 vs vs Temperature')
end