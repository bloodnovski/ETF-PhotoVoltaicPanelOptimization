
load('iradSatno.mat');

iradTotHorAvg = mean(iradSatno);

SC = 1.337;
L = 44.01/180*pi;
n=36;

delta = 23.45*pi/180*sin((360/365)*(n-81)*pi/180);

Hsr = acos((-tan(L))*tan(delta));

C1 = 24/pi*SC*(1+0.034*cos(360/n));
W0avg = C1 * (cos(L)*cos(delta)*sin(Hsr) + Hsr*sin(L)*cos(delta));
WHavg = iradTotHorAvg*24/1000;

KT = WHavg/W0avg;

c2 = 1.39-4.027*KT+5.531*KT.^2-3.108*KT.^3;

iradDiff = c2.*iradSatno;
iradDirekt = iradSatno-iradDiff;
iradTot = iradSatno;



figure
subplot(2,1,1)
bar(iradDiff,'FaceColor',[0.8500 0.3250 0.0980]);
grid on
title('Difuzna komponenta iradijacije')
legend('I_{DH}');
xlabel('T [h]');
ylabel('I_{DH} [W/m^2]');


subplot(2,1,2)
bar(iradDirekt,'FaceColor',[0.9290 0.6940 0.1250])
grid on
title('Direktna komponenta iradijacije')
legend('I_{BH}');
xlabel('T [h]');
ylabel('I_{BH} [W/m^2]');

export_fig('iDB.png','-png','-transparent','-nocrop');

figure
hold on
bar(iradTot)
bar(iradDiff)
bar(iradDirekt)
grid on
legend('I_{H}','I_{DH}','I_{BH}');
title('Dekomponovanje horizontalne iradijacije')
xlabel('T [h]');
ylabel('I [W/m^2]');


export_fig('iDBTOT.png','-png','-transparent','-nocrop');
save('iradDiff.mat','iradDiff')
save('iradDirekt.mat','iradDirekt')
save('iradTot.mat','iradTot')
clear all




