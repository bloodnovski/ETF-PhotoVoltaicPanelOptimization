clear all
load('Ic.mat');
load('tempSatno.mat');

Tamb=tempSatno;
Tpv = Tamb + (25+35)/2 * Ic/1000;

niZ = 0.96;
niN = 0.97;
deltaPdc = 0.005;

niT = (1-deltaPdc*(Tpv-25)/100);


Psc = 265*30;
Pdc = Psc*niZ.*niT*niN.*Ic/1000;

niEuro = 0.98;
niavg = mean(niEuro*niZ*niN.*niT);

Pac = niEuro*Pdc;
PacAvg = mean(Pac)

figure
hold on
b1 = bar(Tpv);
b1.BaseValue = -6;
grid on
title('Srednja satna temperatura PV panela[\circ C]')

b1 = bar(Tamb);
b1.BaseValue = -6;

ylim([-6 2]);
legend('\Delta T_{IC}','T_{amb}');
xlabel('t [h]')
ylabel('T [\circ C]');


export_fig('tempPV.png','-png','-transparent','-nocrop');

figure
hold on
bar(Pdc);
grid on
title('Srednja satna snaga na izlazu invertora[ W ]')

bar(Pac);

legend('P_{DC}-P_{AC}','P_{AC}');
ylabel('P [W]');
xlabel('t [h]');


export_fig('PACDC.png','-png','-transparent','-nocrop');

save('Pdc.mat','Pdc');
save('Pac.mat','Pac');
save('niavg.mat','niavg');
clear all
