clear
clc
close all

cd('/Users/kellyluis/PycharmProjects/oceanoptics/Matlab/Instruments/SpectralEvolution/run_rrs')
addpath('/Users/kellyluis/PycharmProjects/oceanoptics/Matlab/Instruments/HyperProSBA/Functions/save_fig')
load('SEV_191015.mat')
date = '10/15/19';

%% Plot All Stations: Ed, Ls, Lu, Rrs
figure(1)
subplot(2,2,1)

for file = 1:length(SEV_191015)
    wl = SEV_191015(file).wl;
    Index = find(wl > 400 & wl < 700);
    wl_vis = wl(Index);
    Ed_vis = SEV_191015(file).Ed_avg(Index);
    
    plot(wl_vis,Ed_vis, 'Linewidth', 2, 'DisplayName',SEV_191015(file).St)
    hold on
end

xlabel('Wavelength (nm)')
ylabel('E_d (\muW/cm^2/sr/nm)')
title(strcat('Spectral Evolution E_d:', date))
set(gcf,'Color','w')
set(gca,'LineWidth',2','FontSize',16);

subplot(2,2,2)
for file = 1:length(SEV_191015)
    wl = SEV_191015(file).wl;
    Index = find(wl > 400 & wl < 700);
    wl_vis = wl(Index);
    Lu_vis = SEV_191015(file).Lu_avg(Index);
    
    plot(wl_vis,Lu_vis, 'Linewidth', 2, 'DisplayName',SEV_191015(file).St)
    hold on
end

xlabel('Wavelength (nm)')
ylabel('L_u (\muW/cm^2/sr/nm)')
title(strcat('Spectral Evolution L_u:', date))
set(gcf,'Color','w')
set(gca,'LineWidth',2','FontSize',16);

subplot(2,2,3)
for file = 1:length(SEV_191015)
    wl = SEV_191015(file).wl;
    Index = find(wl > 400 & wl < 700);
    wl_vis = wl(Index);
    Ls_vis = SEV_191015(file).Ls_avg(Index);
    
    plot(wl_vis,Ls_vis, 'Linewidth', 2, 'DisplayName',SEV_191015(file).St)
    hold on
end

xlabel('Wavelength (nm)')
ylabel('L_s (\muW/cm^2/sr/nm)')
title(strcat('Spectral Evolution L_s:', date))
set(gcf,'Color','w')
set(gca,'LineWidth',2','FontSize',16);


subplot(2,2,4)
for file = 1:length(SEV_191015)
    wl = SEV_191015(file).wl;
    Index = find(wl > 400 & wl < 700);
    wl_vis = wl(Index);
    Rrs_vis = SEV_191015(file).Rrs_avg(Index);
    
    plot(wl_vis,Rrs_vis, 'Linewidth', 2, 'DisplayName',SEV_191015(file).St)
    hold on
end

legend show
xlabel('Wavelength (nm)')
ylabel('R_r_s_ (1/sr)')
title(strcat('Spectral Evolution R_r_s:', date))
set(gcf,'Color','w')
set(gca,'LineWidth',2','FontSize',16);

%export_fig('specE_allrrs','-m3','-painters')


