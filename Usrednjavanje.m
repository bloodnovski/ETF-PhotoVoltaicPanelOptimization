

load('in.mat');

temp=in(:,1);
irad=in(:,2);

iradAvg=[1:1:672];
for i = 1:6:length(temp)
    iradAvg((i-1)/6+1) = (irad(i)+irad(i+1)+irad(i+2)+irad(i+3)+irad(i+4)+irad(i+5))/6;
end
iradAvg = transpose(iradAvg);

tempAvg=[1:1:672];
for i = 1:6:length(temp)
    tempAvg((i-1)/6+1) = (temp(i)+temp(i+1)+temp(i+2)+temp(i+3)+temp(i+4)+temp(i+5))/6;
end
tempAvg = transpose(tempAvg);

iradAvg2=zeros(1,24);
for i=0:1:length(iradAvg)-1
iradAvg2(mod(i,24)+1) = iradAvg2(mod(i,24)+1) + iradAvg(i+1);
end
iradAvg2 = iradAvg2/28;


tempAvg2=zeros(1,24);
for i=0:1:length(tempAvg)-1
tempAvg2(mod(i,24)+1) = tempAvg2(mod(i,24)+1) + tempAvg(i+1);
end
tempAvg2 = tempAvg2/28;
tempAvg=tempAvg2;
iradAvg=iradAvg2;

figure

subplot(2,1,1)  
b1 = bar(tempAvg2);
b1.BaseValue = -6;
grid on
title('Srednja satna temperatura [\circ C]')

subplot(2,1,2)
bar(iradAvg2)
grid on
title('Srednja satna temperatura [W/m^2]')

export_fig('TempIradSatno.png','-png','-transparent','-nocrop');

iradSatno=iradAvg;
tempSatno=tempAvg;
save('iradSatno.mat','iradSatno')
save('tempSatno.mat','tempSatno')
clear all


