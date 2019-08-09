clear
clc
close all 


addpath('/Users/kellyluis/Desktop/Projects/Spec/Functions')
addpath('/Users/kellyluis/Desktop/Projects/Spec/Functions/save_fig')


%% Load Dataset
cd('/Users/kellyluis/Desktop/Projects/Spec/Datasets')
load('test.mat')

%% Format Wavelength, Volume, and Area
% Wavelength
wl = table2array(wl);

% Volume
V = 250; % ml -> meter
% Area
D_1 = nanmean([22.12 22.58 22.41]);
D_1std = nanstd([22.12 22.58 22.41]);

D_2 = nanmean([22.07 22.19 22.25]);
D_2std = nanstd([22.07 22.19 22.25]);

D_3 = nanmean([22.62 22.19 21.74]);
D_3std = nanstd([22.62 22.19 21.74]);

D_mean = nanmean([D_1 D_2 D_3]);
D_std = sqrt(D_1std.^2 + D_2std.^2 + D_3std.^2);

A = (pi./4).*((D_mean./10).^2);

L = V/A;

%% Compute Mean and Standard Deviation of Absorbance 

% Mean
ap_mean = nanmean(table2array(ap),2);
anap_mean = nanmean(table2array(anap),2);
blank_mean = nanmean(table2array(blank),2);

% Standard Deviation
ap_std = nanstd(table2array(ap),0,2);
anap_std = nanstd(table2array(anap),0,2);
blank_std = nanstd(table2array(blank),0,2);

% Plot Values

figure(1)
errorbar(wl,ap_mean,ap_std)
hold on
errorbar(wl,anap_mean,anap_std)
xlabel('Wavelength')
ylabel('Absorbance')
title('Dock Sample')
legend('ap', 'anap')
set(gca,'FontSize',14)

set(gcf,'Color','w')
export_fig('/Users/kellyluis/Desktop/Projects/Spec/Figures/raw_absorbance','-m3','-painters')
close all

figure(2)
errorbar(wl,blank_mean,blank_std);
xlabel('Wavelength')
ylabel('Absorbance')
title('Blank')
set(gca,'FontSize',14)

set(gcf,'Color','w')
export_fig('/Users/kellyluis/Desktop/Projects/Spec/Figures/raw_blank','-m3','-painters')
close all

%% Blank Correction 

ap_blankc = ap_mean-blank_mean;
anap_blankc = anap_mean-blank_mean;
ap_blankstd = sqrt((ap_std.^2) + (blank_std.^2));
anap_blankstd = sqrt((anap_std.^2) + (blank_std.^2));

figure(3)
errorbar(wl,ap_blankc,ap_blankstd)
hold on
errorbar(wl,anap_blankc,anap_blankstd)
xlabel('Wavelength')
ylabel('Absorbance')
title('Filter Pad Minus Blank')
legend('ap', 'anap')
set(gca,'FontSize',14)

set(gcf,'Color','w')
export_fig('/Users/kellyluis/Desktop/Projects/Spec/Figures/blankcorrected','-m3','-painters')
close all

%% NIR Correction

[null_ap, null_aperr] = nullCompute(wl, ap_mean);
[null_anap, null_anaperr] = nullCompute(wl, anap_mean);

% Correct Filter Pad Minus Blank and NIR

ap_bNIRc = ap_blankc - null_ap;
ap_bNIRstd = sqrt(ap_blankstd.^2 + null_aperr^2);
anap_bNIRc = anap_blankc - null_anap;
anap_bNIRstd = sqrt(anap_blankstd.^2 + null_anaperr^2);

% Plot 
figure(4) 
errorbar(wl,ap_bNIRc,ap_bNIRstd)
hold on
errorbar(wl,anap_bNIRc,anap_bNIRstd)
xlabel('Wavelength')
ylabel('Absorbance')
title('Filter Pad Minus Blank + NIR')
legend('ap', 'anap')
set(gca,'FontSize',14)

set(gcf,'Color','w')
export_fig('/Users/kellyluis/Desktop/Projects/Spec/Figures/blankNIRcorrected','-m3','-painters')
close all

%% 
% Particles
ap_total = particleCompute(ap_bNIRc,L);

% Non-Algal Particles
anap_total = particleCompute(anap_bNIRc,L);

% Phytoplankton
apg_total = ap_total - anap_total;

figure(6)
plot(wl,ap_total,'LineWidth',1.5)
hold on
plot(wl,anap_total,'LineWidth',1.5)
plot(wl,apg_total,'LineWidth',1.5)
legend('ap','anap','apg')
xlabel('Wavelength (nm)')
ylabel('a (1/m)')
title('Absorption Coefficients')
set(gca,'FontSize',14)

set(gcf,'Color','w')
export_fig('/Users/kellyluis/Desktop/Projects/Spec/Figures/a_coeff','-m3','-painters')
close all



