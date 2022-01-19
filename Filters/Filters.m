%% Clears
clear;
clc;
clf;
close all;
clear;

%% Measurements
nofilter = xlsread("NoFilter.xlsx");
blue = xlsread("BlueFilter.xlsx");
green = xlsread("GreenFilter.xlsx");
red = xlsread("RedFilter.xlsx");
cyan = xlsread("CyanFilter.xlsx");
magenta = xlsread("MagentaFilter.xlsx");

[MaxBlue, indexBlue] = max(blue);
[MaxGreen, indexGreen] = max(green);
[MaxRed, indexRed] = max(red);

[MaxCyan, indexCyan] = max(cyan);
[MaxMagenta, indexMagenta] = max(magenta);
cyan1 = cyan(1:250,1);
cyan2 = cyan(251:end,1);
magenta1 = magenta(1:500,1);
magenta2 = magenta(501:end,1);
[MaxCyan1, indexCyan1] = max(cyan1);
[MaxCyan2, indexCyan2] = max(cyan2);
indexCyan2 = indexCyan2 + 250;
[MaxMagenta1, indexMagenta1] = max(magenta1);
[MaxMagenta2, indexMagenta2] = max(magenta2);
indexMagenta2 = indexMagenta2 + 500;

avgIndexBlue = (indexBlue + indexCyan1 + indexMagenta1)/3;
avgIndexGreen = (indexGreen + indexCyan2)/2;
avgIndexRed = (indexRed + indexMagenta2)/2;

figure();
plot(nofilter,'black');
figure();
plot(blue,'b');
figure();
plot(green,'g');
figure();
plot(red,'r');
figure();
plot(cyan,'c');
figure();
plot(magenta,'m');
figure();
plot(nofilter,'black');
hold on;
plot(blue,'b');
plot(green,'g');
plot(red,'r');
plot(cyan,'c');
plot(magenta,'m');

%% Green
datag=dlmread('Green.txt','',0,0);
wlg=datag([107:1151],1);
Ig=datag([107:1151],2);
[Mg, indg]=max(Ig(:,1));
Ig_norm = MaxGreen*Ig/Mg;
figure();
plot(wlg,Ig_norm,'g');
green_w=wlg(indg,1);
%% Blue
datab=dlmread('Blue.txt','',0,0);
wlb=datab([107:1151],1);
Ib=datab([107:1151],2);
[Mb, indb]=max(Ib(:,1));
Ib_norm = MaxBlue*Ib/Mb;
figure();
plot(wlb,Ib_norm,'b');
blue_w=wlb(indb,1);
%% Cyan
datac=dlmread('Cyan.txt','',0,0);
wlc=datac([107:1151],1);
Ic=datac([107:1151],2);
[Mc, indc]=max(Ic([107:800],1));
Ic_norm = MaxCyan*Ic/Mc;
figure();
plot(wlc,Ic_norm,'c');
cyan_w=wlc(indc,1);
%% Magenta
datam=dlmread('Magenta.txt','',0,0);
wlm=datam([107:1151],1);
Im=datam([107:1151],2);
[Mm, indm]=max(Im(:,1));
Im_norm = MaxMagenta*Im/Mm;
figure();
plot(wlm,Im_norm,'m');
magenta_w=wlm(indm,1);
%% Red
datar=dlmread('Red.txt','',0,0);
wlr=datar([107:1151],1);
Ir=datar([107:1151],2);
[Mr, indr]=max(Ir(:,1));
Ir_norm = MaxRed*Ir/Mr;
figure();
plot(wlr,Ir_norm,'r');
red_w=wlr(indr,1);
%% All
figure();
plot(wlg,Ig_norm, 'g');
hold on;
plot(wlb,Ib_norm,'b');
plot(wlc,Ic_norm,'c');
plot(wlm,Im_norm,'m');
plot(wlr,Ir_norm,'r');

%% Post Process

wps1 = (blue_w-green_w)/(avgIndexBlue-avgIndexGreen);
sp11 = blue_w - (avgIndexBlue*wps1);
sp12 = green_w - (avgIndexGreen*wps1);
wps2 = (blue_w-red_w)/(avgIndexBlue-avgIndexRed);
sp21 = blue_w - (avgIndexBlue*wps2);
sp22 = red_w - (avgIndexRed*wps2);
wps3 = (green_w-red_w)/(avgIndexGreen-avgIndexRed);
sp31 = green_w - (avgIndexGreen*wps3);
sp32 = red_w - (avgIndexRed*wps3);
avgWpS = (wps1 + wps2 + wps3)/3;
avgSP = (sp11 + sp12 + sp21 + sp22 + sp31 + sp32)/6;