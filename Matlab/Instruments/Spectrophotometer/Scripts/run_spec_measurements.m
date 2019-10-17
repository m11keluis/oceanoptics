clear
clc
close all 


%% Set Up
folder = '/Users/kellyluis/PycharmProjects/oceanoptics/Matlab/Instruments/Spectrophotometer/';
addpath(genpath(folder)); 
figureFolder = '/Users/kellyluis/PycharmProjects/oceanoptics/Matlab/Instruments/Spectrophotometer/Figures/massbay_191015/';

% Load Dataset
filename = 'MassBayCruise_191015.xlsx';
[wl, blank_p, blank_g, ap, anap, ag] = read_spec(filename);

%% DON'T TOUCH CODE BELOW %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set Parameters for Particulate Absopriton
% Volume (ml)
V = 500; % ml = cm^3

% Pathlength
L = pathlength(V);

%% Extract MetaData
% Names
part_names = ap.Properties.VariableNames; 
cdom_names = ag.Properties.VariableNames; 

% Blank
part_blank = nanmean(table2array(blank_p),2);
cdom_blank = nanmean(table2array(blank_g),2);

% Wavelength 
wl = table2array(wl);

% Set ColorMap 
cmap_ap = colormap(jet(size(ap,2)));
cmap_ag = colormap(jet(size(ag,2)));

%% Process Particulate Samples
for sample = 1:size(ap, 2)
    
    name = part_names{sample};
    ap_raw = table2array(ap(:,sample));
    anap_raw = table2array(anap(:,sample));
    
    % Blank Correction
    ap_blank_corrected = ap_raw - part_blank;
    anap_blank_corrected = anap_raw - part_blank;
    
    % NIR Correction
    [null_ap, null_aperr] = nullCompute(wl, ap_blank_corrected);
    [null_anap, null_anaperr] = nullCompute(wl, anap_blank_corrected);
    
    ap_NIR_corrected = ap_blank_corrected - null_ap;
    anap_NIR_corrected = anap_blank_corrected - null_anap;
    
    % Absorption of Particles
    ap_temp = particleCompute(ap_NIR_corrected,L);
    ap_temp(imag(ap_temp)~=0) = nan;
    ap_total(:,sample) = ap_temp;

    % Non-Algal Particles
    anap_temp = particleCompute(anap_NIR_corrected, L);
    anap_temp(imag(anap_temp)~=0) = nan;
    anap_total(:,sample) = anap_temp;

    % Phytoplankton
    apg_total(:, sample) = ap_total(:, sample) - anap_total(:, sample);
    
end

%% Plot all Particulate Samples
figure(1)
subplot(1,3,1)
for sample = 1:size(ap_total, 2)
    
    plot(wl, ap_total(:,sample), 'Linewidth', 2, 'DisplayName', part_names{sample},'Color',cmap_ap(sample,:))
    hold on 
    legend off
end
xlim([400 700])
hold off
legend show
xlabel('Wavelength (nm)')
ylabel('Absorption (1/m)')
title('Absorption by Particles')
set(gcf,'Color','w')
set(gca,'LineWidth',2','FontSize',16)
set(gca, 'YLim', [0, get(gca, 'YLim') * [0; 1]])

subplot(1,3,2)
for sample = 1:size(anap_total, 2)
    
    plot(wl, anap_total(:,sample), 'Linewidth', 2, 'DisplayName', part_names{sample},'Color',cmap_ap(sample,:))
    hold on 
    legend off
end
xlim([400 700])
hold off
legend show
xlabel('Wavelength (nm)')
ylabel('Absorption (1/m)')
title('Absorption by Non-Algal Particles')
set(gcf,'Color','w')
set(gca,'LineWidth',2','FontSize',16);
set(gca, 'YLim', [0, get(gca, 'YLim') * [0; 1]])

subplot(1,3,3)
for sample = 1:size(apg_total, 2)
    
    plot(wl, apg_total(:,sample), 'Linewidth', 2, 'DisplayName', part_names{sample},'Color',cmap_ap(sample,:))
    hold on 
    legend off
end
xlim([400 700])
hold off
legend show
xlabel('Wavelength (nm)')
ylabel('Absorption (1/m)')
title('Absorption by Phytoplankton')
set(gcf,'Color','w')
set(gca,'LineWidth',2','FontSize',16);
set(gca, 'YLim', [0, get(gca, 'YLim') * [0; 1]])

% export_fig([figureFolder 'all_ap'],'-m3','-painters')

%% Process CDOM Measurements

 for sample_g = 1:size(ag, 2)
     name = cdom_names{sample_g};
     ag_raw = table2array(ag(:,sample_g));
     
     % Blank Correction
     ag_blank_corrected = ag_raw - cdom_blank;
     
     % NIR Correction
     [null_ag, null_aperr] = nullCompute(wl, ag_blank_corrected);
     ag_NIR_corrected = ag_blank_corrected - null_ag;
      
     % Absorption of CDOM
     ag_total(:,sample_g) = cdomCompute(ag_NIR_corrected);

 end

%% Plot CDOM 
figure(2)
for sample = 1:size(ag_total, 2)
    
    plot(wl, ag_total(:,sample), 'Linewidth', 2, 'DisplayName', cdom_names{sample},'Color',cmap_ag(sample,:))
    hold on 
    legend off
end
xlim([400 700])
hold off
legend show
xlabel('Wavelength (nm)')
ylabel('Absorption (1/m)')
title('Absorption by CDOM')
set(gcf,'Color','w')
set(gca,'LineWidth',2','FontSize',16)
     
export_fig([figureFolder 'all_ag'],'-m3','-painters')

