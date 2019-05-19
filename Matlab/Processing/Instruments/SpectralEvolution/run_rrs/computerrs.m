% The SE PSR-1100-F Spectroradiometer measures 
% light at 1.5 nm sampling and 3.2 nm spectral 
% resolution over the 320 nm to 1100 nm spectral 
% range. However, due to the difficulty in calibrating 
% the 99% Spectralon plaque below 360 nm and the 
% low signal-to-noise ratio received from the water 
% above 850 nm, we generally only output spectra in 
% the 360-850 nm range.
% 
% Rrs is estimated from the above-water data using the formula,
% 	Rrs = (Sw+s - Ssky ?(?))/( ?Sp/refl),
% 
% where Sw+s is the measured signal from the water 
% and includes both Lw and reflected skylight.  
% Ssky is the measured signal from the sky, 
% Sp is the average measured signal from the 
% white Spectralon Plaque, and refl is the 
% reflectivity of the plaque (the calibration measurement of
% the spectral values are used loaded from file and used 
% in the calculation). Pi (?) converts the reflected 
% radiance values to irradiance for this Lambertian 
% diffuser. The measured sky radiance is multiplied 
% by ?(?) which is the proportionality factor that 
% relates the radiance measured when the detector 
% views the sky to the reflected sky radiance 
% measured when the detector views the sea surface. 
%
% r1 - water
% r2 - sky
% r3 - reference
%

function [wl rrs rrsmin rrsmax rrsopt redmin] = computerrs(wl, ravg, rmin, rmax, mf, plotscale, mdata);

XMIN    = 350.00; XMAX = 850.00;
YMIN    =   0.00; YMAX =  0.02;
% Find index of wavelength closest to 350nm
[ ~, BMINidx ] = min( abs( wl - 350 ) );
% Find index of wavelength closest to 750nm
[ ~, RMINidx ] = min( abs( wl - 750 ) );
% Find index of wavelength closest to 800nm
[ ~, RMAXidx ] = min( abs( wl - 800 ) );
% Find index of wavelength closest to XMAX (= 850nm)
[ ~, XMAXidx ] = min( abs( wl - XMAX ) );

dirin        = mdata.dirin;
directorystr = mdata.directorystr;
datestr      = mdata.datestr;

% LOAD c_refcal/refcal.cal plaque reflectance calibration 
% file if mdata.refcalset ~=0 from dirin
    if mdata.refcalset==0
       refcal = 0.99;
	else
       caldata = load([dirin 'c_refcal/refcal.cal']);
       refcal  = interp1(caldata(:,1),caldata(:,2),wl);
    end

r1    = ravg(:,1); r2    = ravg(:,2); r3    = ravg(:,3);  % radiances (r1 water, r2 sky, r3 reference)
r1min = rmin(:,1); r2min = rmin(:,2); r3min = rmin(:,3);  % max / min radiances
r1max = rmax(:,1); r2max = rmax(:,2); r3max = rmax(:,3);  % max / min radiances
% 
% rrs    = (r1 - mf*r2)./((pi*r3)./refcal);				% compute rrs from radiances
% rrsmin = (r1min - mf*r2max)./((pi*r3max)./refcal);		% compute rrs max / min
% rrsmax = (r1max - mf*r2min)./((pi*r3min)./refcal);		% compute rrs max / min

rrs    = (r1 - mf*r2)./r3;				% compute rrs from radiances % irradiance dirrectly measured
rrsmin = (r1min - mf*r2max)./r3;		% compute rrs max / min
rrsmax = (r1max - mf*r2min)./r3;		% compute rrs max / min

%%% CALCULATE baseline / pedestal based on c_settings: 
%%% type: 0 = none, 1 = min(750-800), 2 = mean(750-850), 3 = TBD (currnently = 0)
if     mdata.pedestal ~= 1 && mdata.pedestal ~= 2
	redmin     = 0;      								% baseline calculation for rrs
	redminlow  = 0;  									% baseline for rrsmin
	redminhigh = 0;  									% baseline for rrsmax
elseif mdata.pedestal==1
	redmin     = min(rrs   (RMINidx:RMAXidx));      	% baseline calculation for rrs
	redminlow  = min(rrsmin(RMINidx:RMAXidx));  		% baseline for rrsmin
	redminhigh = min(rrsmax(RMINidx:RMAXidx));  		% baseline for rrsmax
elseif mdata.pedestal==2
	redmin     = mean(rrs   (RMINidx:XMAXidx));      	% baseline calculation for rrs
	redminlow  = mean(rrsmin(RMINidx:XMAXidx));  		% baseline for rrsmin
	redminhigh = mean(rrsmax(RMINidx:XMAXidx));  		% baseline for rrsmax
% elseif mdata.pedestal==3								% TBD
end

%%% Baseline removal
rrsopt = rrs    - redmin;
rrsmin = rrsmin - redminlow;
rrsmax = rrsmax - redminhigh;

figure('units','normalized','outerposition',[0 0 1 1]); hold on;
plot(wl, rrs, 'b', 'LineWidth', 5);
if (plotscale == 0)
else 
    ymax = max(rrs(BMINidx:RMAXidx));
	ymax = max ([ymax max(rrsmin(BMINidx:RMAXidx)) max(rrsmax(BMINidx:RMAXidx))]); %added to compute rrs max / min
end

axis([XMIN XMAX YMIN ymax]);
xlabel('Wavelength (nm)'); ylabel('Remote Sensing Reflectance (R_{rs})');
tu = title([directorystr, '  ', datestr]);
set(tu,'Interpreter','none');
set(gca, 'FontSize', 15);
	text(650, ymax*0.019/YMAX, 'R_{rs}', 'Color', 'b', 'FontSize', 15);
if     mdata.pedestal == 1,
	text(650, ymax*0.017/YMAX, 'R_{rs} - min[ R_{rs}(750-800) ]', ...
    	'Color', 'r', 'FontSize', 15);
elseif mdata.pedestal == 2
	text(650, ymax*0.017/YMAX, 'R_{rs} - mean[ R_{rs}(750-850) ]', ...
	    'Color', 'r', 'FontSize', 15);
elseif mdata.pedestal == 3
%	text(650, ymax*0.017/YMAX, 'R_{rs} - TBD f[R_{rs}]', ...
%	    'Color', 'r', 'FontSize', 30);
end

%%% Print additinal legend entries for max / min curves
%text(650, ymax*0.015/YMAX, 'R_{rs} MIN', 'Color', [.8 0 0], 'FontSize', 30);
%text(650, ymax*0.013/YMAX, 'R_{rs} MAX', 'Color', [.8 0 0], 'FontSize', 30);
%%% Print BL 'pedastal' levels on plot
%text(800, ymax*0.017/YMAX, strcat('BL = ' , num2str(redmin,2)), ...
%	'Color', 'r', 'FontSize', 30);  	% additional legend (temp)
%text(800, ymax*0.015/YMAX, strcat('BL = ' , num2str(redminlow,2)), ...
%	'Color', [.8 0 0], 'FontSize', 30);  % additional legend (temp)
%text(800, ymax*0.013/YMAX, strcat('BL = ' , num2str(redminhigh,2)), ...
%	'Color', [.8 0 0], 'FontSize', 30);  % additional legend (temp)

%%% Generate fill plot to for derived RRS uncertainty
	rrslow =rrsmin(~isnan(rrsmin));
	rrshigh=rrsmax(~isnan(rrsmax));
	rrsminmax = [rrslow' fliplr(rrshigh')];
	wlminmax=wl(~isnan(rrsmin)&~isnan(rrsmax));
	wlminmax = [wlminmax' fliplr(wlminmax')];

plot(wl, rrsopt, 'r', 'LineWidth', 5);
saveas(gcf,[dirin,'f_rrs_legacy.png']); 

%fill(wlminmax,rrsminmax,'r','linestyle','none','FaceAlpha',0.09)
fill(wlminmax,rrsminmax,'r','FaceAlpha',0.09,'EdgeColor','r')
saveas(gcf,[dirin,'f_rrs.png']);
%	plot(wl, rrsoptmin, 'rx','LineWidth', 2);
%	plot(wl, rrsoptmax, 'ro','LineWidth', 2);
hold off;
close all;
end