function [wl, ravg, rmin, rmax] = averagespectra(r, T, plotscale, mdata)
dirin = mdata.dirin;
XMIN = 350.00; XMAX = 900.00;
YMIN =   0.00; YMAX =  30.00;
wl = r(:,1,1);
[ ~, Bidx ] = min( abs( wl - 350 ) ); % Find index of wavelength closest to 350nm
[ ~, Cidx ] = min( abs( wl - 450 ) ); % Find index of wavelength closest to 450nm
[ ~, Didx ] = min( abs( wl - 900 ) ); % Find index of wavelength closest to 900nm
[ ~, Eidx ] = min( abs( wl - 450 ) ); % Find index of wavelength closest to 450nm
[ ~, Fidx ] = min( abs( wl - 650 ) ); % Find index of wavelength closest to 650nm
gray = [0.7 0.7 0.7];
r1idx = find(T==1); r2idx = find(T==2); r3idx = find(T==3);  % classfied & valid spectra

%  Collect valid spectra classified previously 1 water, 2 sky, 3 reference
r1avg = mean(r(:,2,r1idx), 3);   r2avg = mean(r(:,2,r2idx), 3);   r3avg = mean(r(:,2,r3idx), 3);
ravg = [r1avg r2avg r3avg];

%  FIND min and max spectra by integrating radiance over 350nm to 850nm for all
%  valid spectra given by r1idx, r2idx and r3idx
[~,r1minidx] = min(sum(r(wl<850 & wl>350,2,r1idx)));  [~,r1maxidx] = max(sum(r(wl<850 & wl>350,2,r1idx)));
[~,r2minidx] = min(sum(r(wl<850 & wl>350,2,r2idx)));  [~,r2maxidx] = max(sum(r(wl<850 & wl>350,2,r2idx)));
[~,r3minidx] = min(sum(r(wl<850 & wl>350,2,r3idx)));  [~,r3maxidx] = max(sum(r(wl<850 & wl>350,2,r3idx)));
r1min = r(:,2,r1idx(r1minidx));  r2min = r(:,2,r2idx(r2minidx));  r3min = r(:,2,r3idx(r3minidx));
r1max = r(:,2,r1idx(r1maxidx));  r2max = r(:,2,r2idx(r2maxidx));  r3max = r(:,2,r3idx(r3maxidx));

%% Alternativelly can calculate max / min over all radiances within ensamble of spectra
%r1minall = min (r(:,3,r1idx),[],3); r2minall = min (r(:,3,r2idx),[],3); r3minall = min (r(:,3,r3idx),[],3);
%r1maxall = max (r(:,3,r1idx),[],3); r2maxall = max (r(:,3,r2idx),[],3); r3maxall = max (r(:,3,r3idx),[],3);

rmin = [r1min r2min r3min];
rmax = [r1max r2max r3max];

figure('units','normalized','outerposition',[0 0 1 1]); hold on;
plot(wl, r1avg, 'g', 'LineWidth', 4);
plot(wl, r2avg, 'b', 'LineWidth', 4);
plot(wl, r3avg, 'r', 'LineWidth', 4);
for scnt = 1:length(r(1,1,:))
    if     (T(scnt) == 1) 
        MarkerColor = 'g'; % Water
    elseif (T(scnt) == 2)
        MarkerColor = 'b'; % Sky
    elseif (T(scnt) == 3)
        MarkerColor = 'r'; % Reference
    else
        MarkerColor = 'k';
    end
    if (MarkerColor == 'k')
       plot(r(:,1,scnt),r(:,2,scnt), 'Color', gray, 'LineWidth', 2);
    else
        plot(r(:,1,scnt),r(:,2,scnt), MarkerColor);
    end
end
if     (plotscale == 0)
    ymax = YMAX;
elseif (plotscale == 1)
    ymax = max(max(r(:,2,r1idx)));
elseif (plotscale == 2)
    ymax = max(max(r(:,2,r2idx)));
elseif (plotscale == 3)
    ymax = max(max(r(:,2,r3idx)));
end
axis([XMIN,XMAX,YMIN,ymax]);
xlabel('Wavelength (nm)'); ylabel('Radiance (uW/cm^2/sr/nm)');
title('All Spectra (Bold Average)');
text(810, ymax*29/YMAX, 'Reference', 'Color', 'r', 'FontSize', 15);
text(810, ymax*27/YMAX, 'Sky',       'Color', 'b', 'FontSize', 15);
text(810, ymax*25/YMAX, 'Water',     'Color', 'g', 'FontSize', 15);
text(810, ymax*23/YMAX, 'Unused',    'Color', '[0.5 0.5 0.5]', 'FontSize', 15);
set(gca, 'FontSize', 15);
hold off;
saveas(gcf,[dirin,'f_spe_2.png']); 
close all;
end
