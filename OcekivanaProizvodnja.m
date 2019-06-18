clc;clear all;

load('Pac.mat');
load('niavg.mat');
load('Ic.mat');

PdcMax = 30*265;
PacAvg = mean(Pac);
PacMax = niavg*PdcMax;

CF = PacAvg/PacMax;

WcAvg = 24*mean(Ic)/1000;