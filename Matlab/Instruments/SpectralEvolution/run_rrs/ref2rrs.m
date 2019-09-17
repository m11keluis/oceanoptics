function [wl, rrs, rrsmin, rrsmax, rrsopt, mdata] = ref2rrs(stdfrac, plotscale, mdata)
addpath('SolarAzEl','MoblyFactor');
dirin        = mdata.dirin;
date_time    = mdata.date_time;
lat          = mdata.lat;
lon          = mdata.lon;
alt          = mdata.alt;
wind_speed   = mdata.wind_speed;

[az el]      = SolarAzEl(date_time, lat, lon, alt);
solar_zenith = 90 - el;

[mf]         = mobly_factor(wind_speed, solar_zenith);
rin          = readsedfolder(dirin);

if((wind_speed > 8) || (wind_speed < 0))
    mf = -1; % Wind Speed Out of Range; disp(' '), disp(' ### ')
    disp('% ERROR: Wind Speed Out of Range');  disp(' ')
    disp('Exiting MATLAB script...'); %Save variables to matlab.mat
    save, quit cancel
end
if((solar_zenith > 80) || (solar_zenith < 0))
%     mf = -2; % Solar Zenith Out of Range; disp(' '), disp(' ### ')
    mf = 0.023; % Solar Zenith Out of Range; disp(' '), disp(' ### ')
    disp('% ERROR:  Solar Zenith Out of Range');  disp(' ')
    disp('Exiting MATLAB script...'); %Save variables to matlab.mat
%     save, quit cancel
end
if (isnan(mf)==1)
	disp(' '), disp (' ### ')
	disp ('ERROR:  Mobly Factor calc. fail = OTHER')
    disp('Exiting MATLAB script...'); %Save variables to matlab.mat
    save, quit cancel
end

% Convert to uW/cm^2/sr/nm from W/m^2/sr/nm  %%%%%%
r(:,1,:)     = rin(:,1,:); 
% r(:,2,:)     = rin(:,2,:);
 r(:,2,:)     = 100*rin(:,3,:);
%r(:,2,:)     = 100*rin(:,2,:);

[r T]        = classifyspectra(r, stdfrac, plotscale, mdata);
[wl ravg rmin rmax]    = averagespectra(r, T, plotscale, mdata);
[wl rrs rrsmin rrsmax rrsopt redmin] = computerrs(wl, ravg, rmin, rmax, mf, plotscale, mdata);

mdata.wavelength      = wl;
mdata.solar_azimuth   = az;
mdata.solar_elevation = el;
mdata.solar_zenith    = solar_zenith;
mdata.mobly_factor    = mf;
mdata.redmin          = redmin;
mdata.T               = T;
mdata.ravg            = ravg;
end

