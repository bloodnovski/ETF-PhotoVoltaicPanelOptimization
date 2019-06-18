
load('iradDiff.mat');
load('iradDirekt.mat');
load('iradTot.mat');

L = 44.01/180*pi;
n=36;
delta = 23.45*pi/180*sin((360/365)*(n-81)*pi/180);

ro=0.2;
phiC=-55*180/pi;
sigma = 30*180/pi;

Idc = iradDiff*(1+cos(sigma))/2;
Irc = iradTot*ro*(1-cos(sigma))/2;
%treba naci Ibc...
H=[165:-15:-180];
H=H*pi/180;

Rb=[1:1:24];
beta=0;phiS=0;theta=0;
for i=1:1:24;
   beta = asin( cos(L)*cos(delta)*cos(H(i)) + sin(L)*sin(delta));
   phiS = asin( cos(delta)*sin(H(i))/cos(beta));
   theta = acos( cos(beta)*cos(phiS-phiC)*sin(sigma)+sin(beta)*cos(sigma));
   if(beta<0 || cos(theta)<0)
       Rb(i)= 0;
   else
       Rb(i)=cos(theta)/sin(beta);
   end
end


Ibc = iradDirekt.*Rb;

IdcAvg = mean(Idc); Wdc = IdcAvg*24/1000
IbcAvg = mean(Ibc); Wbc = IbcAvg*24/1000
IrcAvg = mean(Irc); Wrc = IrcAvg*24/1000
Ic = Idc+Ibc+Irc;
Wtot = Wdc+Wbc+Wrc




figure
subplot(3,1,1)
bar(Idc,'FaceColor',[0.8500 0.3250 0.0980]);
grid on
title('Difuzna komponenta iradijacije')
legend('I_{DC}');
xlabel('T [h]');
ylabel('I_{DC} [W/m^2]');


subplot(3,1,2)
bar(Ibc,'FaceColor',[0.9290 0.6940 0.1250])
grid on
title('Direktna komponenta iradijacije')
legend('I_{BC}');
xlabel('T [h]');
ylabel('I_{BC} [W/m^2]');


subplot(3,1,3) 
bar(Irc,'FaceColor',[0 0.4470 0.7410])
grid on
title('Reflektovana komponenta iradijacije')
legend('I_{RC}');
xlabel('T [h]');
ylabel('I_{RC} [W/m^2]');
export_fig('iC.png','-png','-transparent','-nocrop');

I = [Irc;Idc;Ibc];
I = transpose(I);
figure
grid on
hold on
bar(I,'stacked');
legend('I_{RC}','I_{DC}','I_{BC}');
title('Ukupna iradijacija na panel')
xlabel('T [h]');
ylabel('I [W/m^2]');


export_fig('iCtot.png','-png','-transparent','-nocrop');
save('Ic.mat','Ic')
clear all







