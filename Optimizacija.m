clc;clear;
load('iradDiff.mat');
load('iradDirekt.mat');
load('iradTot.mat');
load('niavg.mat');

L = 44.01/180*pi;
n=36;
delta = 23.45*pi/180*sin((360/365)*(n-81)*pi/180);

ro=0.2;
phiC=-55*180/pi;
sigma = 30*180/pi;


%treba naci Ibc...
H=[165:-15:-180];
H=H*pi/180;
ii=0;jj=0;
figure 
hold on
RBB=[;];
RBB2=[;];
for sigmaa = 0:5:60
    ii=ii+1;
    jj=0;
    sigma=sigmaa/180*pi;
    for phiCC = -90:5:90
    jj=jj+1;
        phiC = phiCC/180*pi;
        Rb=[1:1:24];
        beta=0;phiS=0;theta=0;
        for i=1:1:24;
           Idc = iradDiff*(1+cos(sigma))/2;
           Irc = iradTot*ro*(1-cos(sigma))/2;
           beta = asin( cos(L)*cos(delta)*cos(H(i)) + sin(L)*sin(delta));
           phiS = asin( cos(delta)*sin(H(i))/cos(beta));
           theta = acos( cos(beta)*cos(phiS-phiC)*sin(sigma)+sin(beta)*cos(sigma));
           if(beta<0 || cos(theta)<0)
               Rb(i)= 0;
           else
               Rb(i)=cos(theta)/sin(beta);
           end
        end
        S=[0 0 0 0 0  0 0 0 1:1:7 0 0 0 0 0 0 0 0 0]/7*pi;
        S=sin(S);
        RBB2 = [RBB2;Rb]
        Rb = Rb.*S;
        RBB = [RBB;Rb]
        %plot(Rb)

        Ibc = iradDirekt.*Rb;

        IdcAvg = mean(Idc); Wdc = IdcAvg*24/1000;
        IbcAvg = mean(Ibc); Wbc = IbcAvg*24/1000;
        IrcAvg = mean(Irc); Wrc = IrcAvg*24/1000;
        Ic = Idc+Ibc+Irc;
        ICC(ii,jj) = mean(Ic);
        PHIC(jj) = phiC;
    end
        SIGMA(ii) = sigma;
end

surf(RBB)
grid minor
view(3)
export_fig('RBFAKTORs.png','-png','-transparent','-nocrop');
surf(RBB)
grid minor
view(3)
export_fig('RBFAKTOR2.png','-png','-transparent','-nocrop');
WcAvgDnevno = ICC*24/1000;%U KWH

PacDnevnoAvg = 30*265*niavg.*ICC/1000;
figure
PHIC = PHIC*180/pi;
SIGMA = SIGMA*180/pi;

surf(PHIC,SIGMA,PacDnevnoAvg);
grid minor;
xlabel('\phi_c [ \circ ]');
ylabel('\Sigma [ \circ ]');
zlabel('P_{AC avg} [ W ]');
view([-116 25]);

export_fig('iCCtot.png','-png','-transparent','-nocrop');

PacMaxAvg = max(max(PacDnevnoAvg))

clc
clear all
