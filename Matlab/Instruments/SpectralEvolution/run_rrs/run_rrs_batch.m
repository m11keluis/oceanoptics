%%% Main script for processing Spectral Evolution
% Core code to Q3.2016: 	nbt
% Updates post Q3.2016: 	ilalovic
% Update Version: 1.2 	Date: 	11.01.2017
% Update Includes: reference calibration input, instrument-independent wavelenght selectionsm, etc.
%
% usage:  run_rrs.m
% modification for UMB Spectral Evolution Xiaolong Yu_20180619 
% SEV file of the UMB measurements only has two columns
% (wl,radiance/iradiance)
%%   optionally to conver to function without input argument:
%%   function output = run_rrs()
clear;clc;
addpath('ScreenCapture');

disp('Choose Spectral Evolution Data Directory');
% dirin = uigetdir(' ','Spectral Evolution Data Directory'); 
dirin1 = uigetdir('Spectral Evolution Data Directory'); 
allstdir = dir([dirin1 '/ST*']);

for ii =1: length(allstdir)
dirin = [dirin1 '/' allstdir(ii).name '/'];

settings_file = [dirin,'c_settings.txt'];
disp(' ');
disp(['Loading: ', settings_file])
load(settings_file); 
settings = c_settings;
disp(' ');
disp('Settings for Processing Rrs');
disp(['Year:        ', num2str(settings(1))]);
disp(['Month:       ', num2str(settings(2))]);  
disp(['Day:         ', num2str(settings(3))]);
disp(['Hour:        ', num2str(settings(4))]);
disp(['Minute:      ', num2str(settings(5))]); 
disp(['Second:      ', num2str(settings(6))]);
disp(['Latitude:    ', num2str(settings(7)),  '.  % Digital North']); %used to be "Digital East" chd IL10202016
disp(['Longitude:   ', num2str(settings(8)),  '.  % Digital East']); %formerly "Digital North" chg IL10202016
disp(['Altitude:    ', num2str(settings(9))]);
disp(['Wind Speed:  ', num2str(settings(10))]); 
disp(['Sigma Water: ', num2str(settings(11))]);
disp(['Sigma Sky:   ', num2str(settings(12))]);
disp(['Sigma Ref:   ', num2str(settings(13))]);
disp(['Plot Scale:  ', num2str(settings(14)), '.   % 0: Fixed | 1: Max Water | 2: Max Sky| 3: Max Reference']);
disp(['RefCal:      ', num2str(settings(15)), '.   % 0: White plaque = 99%   | 1: Use calibration file']);
disp(['Pedestal:    ', num2str(settings(16)), '.   % 0: None |1: MIN(750-800] | 2: AVG[750-850] | 3: Other']);

YYYY         = settings(1);
MM           = settings(2);
DD           = settings(3);
hh           = settings(4);
mm           = settings(5);
ss           = settings(6);
lat          = settings(7);
lon          = settings(8);
alt          = settings(9);
wind_speed   = settings(10);
stdfrac      = [settings(11) settings(12) settings(13)];
plotscale    = settings(14);
refcalset    = settings(15);
pedestal     = settings(16);

date_time = [num2str(YYYY),'/',num2str(MM),'/',num2str(DD),' ', ...
             num2str(hh),':',num2str(mm),':',num2str(ss)];

directorystr = ['Directory:   ...', dirin(end-19:end)];
datestring   = ['Date:        ', num2str(YYYY), '-', num2str(MM,'%02d'), '-', num2str(DD,'%02d'), ...
    ' Time: ',  num2str(hh,'%02d'),':',num2str(mm,'%02d'),':',num2str(ss,'%02d')];
disp(' ');
disp(directorystr);
disp(['Data:',datestring(6:end)]);

mdata.date_time    = date_time;
mdata.lat          = lat;
mdata.lon          = lon;
mdata.alt          = alt;
mdata.wind_speed   = wind_speed;
mdata.dirin        = dirin;
mdata.directorystr = directorystr;
mdata.datestr      = datestring;
mdata.refcalset    = refcalset;
mdata.pedestal     = pedestal;

[wl, rrs, rrsmin, rrsmax, rrsopt, mdata] = ref2rrs(stdfrac, plotscale, mdata);

save([dirin,'d_wavelength.txt'], 'wl', '-ascii');
save([dirin,'d_rrs.txt'], 'rrs', '-ascii');
save([dirin,'d_rrsopt.txt'], 'rrsopt', '-ascii');
save([dirin,'d_rrsoptmin.txt'], 'rrsmin', '-ascii');
save([dirin,'d_rrsoptmax.txt'], 'rrsmax', '-ascii');
T = mdata.T;
save([dirin,'d_T_spectra.txt'], 'T', '-ascii');
ravg = mdata.ravg;
save([dirin,'d_r_average.txt'], 'ravg', '-ascii');
% Rrs(:,ii)=rrs;
% Rrsopt(:,ii)=rrsopt;
% Ravg.Lu=ravg(:,1);
% Ravg.Ls=ravg(:,2);
% Ravg.Ed=ravg(:,3);
SEV_May(ii).St=allstdir(ii).name;
SEV_May(ii).SZA=mdata.solar_zenith;
SEV_May(ii).rho = mdata.mobly_factor;
SEV_May(ii).wl=wl;
SEV_May(ii).Lu_avg=ravg(:,1);
SEV_May(ii).Ls_avg=ravg(:,2);
SEV_May(ii).Ed_avg=ravg(:,3);
SEV_May(ii).Rrs_avg=rrs;
SEV_May(ii).Rrs_avgcorr=rrsopt;
proc_par_date_time     = mdata.date_time;
proc_par_proc_date     = datestr(datetime);
proc_par_lat           = mdata.lat;
proc_par_lon           = mdata.lon;
proc_par_alt           = mdata.alt;
proc_par_wind_speed    = mdata.wind_speed;
proc_par_dirin         = mdata.dirin;
proc_par_directorystr  = mdata.directorystr;
proc_par_datestr       = mdata.datestr;
proc_par_solar_azimuth = mdata.solar_azimuth;
proc_par_solar_elevation = mdata.solar_elevation;
proc_par_solar_zenith  = mdata.solar_zenith;
proc_par_mobly_factor  = mdata.mobly_factor;
proc_par_redmin        = mdata.redmin;
proc_par_refcalset     = mdata.refcalset;
proc_par_pedestal      = mdata.pedestal;
disp(' ');
disp(['Data Directory:  ', proc_par_directorystr(14:end)]);
disp(['Processing Date: ', proc_par_proc_date(1:end)]);
disp(['Solar Azimuth:   ', num2str(proc_par_solar_azimuth)]);
disp(['Solar Elevation: ', num2str(proc_par_solar_elevation)]);
disp(['Solar Zenith:    ', num2str(proc_par_solar_zenith)]);
disp(['Molby Factor:    ', num2str(proc_par_mobly_factor)]);
disp(['Rrs Minimum:     ', num2str(proc_par_redmin)]);

fileid = fopen([dirin,'d_processing_parameters.txt'], 'w');
fprintf(fileid, '%s %s\n', 'Data Directory:     ', proc_par_directorystr(14:end));
fprintf(fileid, '%s %s\n', 'Measurement Date:   ', datestring(14:end));
fprintf(fileid, '%s %s\n', 'Latitude:           ', num2str(settings(7)));
fprintf(fileid, '%s %s\n', 'Longitude:          ', num2str(settings(8)));
fprintf(fileid, '%s %s\n', 'Processing Date:    ', proc_par_proc_date(1:end));
fprintf(fileid, '%s %s\n', 'Wind Speed:         ', num2str(settings(10)));
fprintf(fileid, '%s %s\n', 'Sigma Water:        ', num2str(settings(11)));
fprintf(fileid, '%s %s\n', 'Sigma Sky:          ', num2str(settings(12)));
fprintf(fileid, '%s %s\n', 'Sigma Reference:    ', num2str(settings(13)));
fprintf(fileid, '%s %s\n', 'Plot Scale:         ', num2str(settings(14)));
fprintf(fileid, '%s %s\n', 'Solar Elevation:    ', num2str(proc_par_solar_azimuth));
fprintf(fileid, '%s %s\n', 'Solar Zenith:       ', num2str(proc_par_solar_elevation));
fprintf(fileid, '%s %s\n', 'Solar Azimuth:      ', num2str(proc_par_redmin));
fprintf(fileid, '%s %s\n', 'Moby Factor:       ', num2str(proc_par_solar_zenith));
fprintf(fileid, '%s %s\n', 'Rrs Minimum:        ', num2str(proc_par_mobly_factor));
fprintf(fileid, '%s %s\n', 'RefCal, 0=no 1=yes: ', num2str(proc_par_refcalset));
fprintf(fileid, '%s %s\n', 'Pedestal Type 0-3:  ', num2str(proc_par_pedestal));
fprintf(fileid, '\n%s \n%s \n\n%s \n',  'Processed Files', '(1 Water; 2 Sky; 3 Reference; Neg - Not Used)',  'NAME                       TYPE');
processed_files = listsedfilenames(dirin);
for fcnt = 1:length(processed_files)
    filename = char(processed_files(fcnt));
    filetype = num2str(T(fcnt));
    if (T(fcnt) > 0)
        filetype = [' ',filetype];
    end
    fprintf(fileid, '%s %s\n', filename, filetype);
end
fclose(fileid);

% close all
end
save('SEV_May.mat','SEV_May');
% save('d_Rrs.txt', 'Rrs', '-ascii');
% save('d_Rrsopt.txt', 'Rrsopt', '-ascii');
%  system('shutdown -s');