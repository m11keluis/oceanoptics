function [r T] = classifyspectra(r, stdfrac, plotscale, mdata)
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
%%%%%% Print out wavelength index %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [(1:512)' squeeze(squeeze(r(:,1,1)))] % print out index vs wavelength
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cluster analysis to identify spectra from water (1), sky (2), reference (3)
Cr = squeeze(squeeze(r(Cidx,2,:)));
% plot([1:length(r350)],r350,'.k', 'MarkerSize', 40);
T = clusterdata(Cr,3);
% T=zeros(size(Cr));
% [clusters,clusterInds,~]= clusterData(Cr,0.1);
% A=cell2mat(clusters(1));
% if size(clusters)<3    
% T=clusterInds+1;
% [clusters1,clusterInds1,~]= clusterData(A,0.1);
% clusterInds1(clusterInds1>2)=2;
% T(1:size(clusterInds1))=clusterInds1;
% else
%     T=clusterInds;
% end

figure('units','normalized','outerposition',[0 0 1 1]);
%%% Re-order Cluster indexing from lowest to highest
  r1idx = find(T==1); r2idx = find(T==2); r3idx = find(T==3);
  r1mean = mean(r(Cidx,2,r1idx));
  r2mean = mean(r(Cidx,2,r2idx));
  r3mean = mean(r(Cidx,2,r3idx));
%  disp(' '), disp('MEANS')
%  disp(num2str([r1mean r2mean r3mean],'%10.5e\t'))

[Ts, iTs] = sort([r1mean r2mean r3mean]);
iTs = iTs';
if 		mdata.refcalset==0 || mdata.refcalset==2
	T(r1idx) = find(iTs==1);  T(r2idx) = find(iTs==2); T(r3idx) = find(iTs==3);
elseif 	mdata.refcalset==1
	T(r1idx) = find(iTs==1);  T(r2idx) = find(iTs==3); T(r3idx) = find(iTs==2);
end
clear r1idx r2idx r3idx;
	r1idx = find(T==1); r2idx = find(T==2); r3idx = find(T==3);

% Re-order done: Water --> 1; Sky --> 2; Reference --> 3;
for wcnt = 1:length(wl)
   r1med(wcnt) = median(r(wcnt,2,r1idx)); 
   r2med(wcnt) = median(r(wcnt,2,r2idx)); 
   r3med(wcnt) = median(r(wcnt,2,r3idx));
   r1mea(wcnt) =   mean(r(wcnt,2,r1idx));
   r2mea(wcnt) =   mean(r(wcnt,2,r2idx));
   r3mea(wcnt) =   mean(r(wcnt,2,r3idx));
   r1std(wcnt) =    std(r(wcnt,2,r1idx));
   r2std(wcnt) =    std(r(wcnt,2,r2idx));
   r3std(wcnt) =    std(r(wcnt,2,r3idx));
end
r1med = r1med'; r2med = r2med'; r3med = r3med';
r1mea = r1mea'; r2mea = r2mea'; r3mea = r3mea';
r1std = r1std'; r2std = r2std'; r3std = r3std';
% Confidence interval to include in averaging spectra
% if stdfrac == 1, then +/- one standard deviation.
r1itv = stdfrac(1)*r1std; r2itv = stdfrac(2)*r2std; r3itv=stdfrac(3)*r3std; 
PSKP = 10;
errorbar(wl(1:PSKP:end),r1med(1:PSKP:end), r1itv(1:PSKP:end), '.g', 'MarkerSize', 15); 
hold on;
errorbar(wl(1:PSKP:end),r2med(1:PSKP:end), r2itv(1:PSKP:end), '.b', 'MarkerSize', 15); 
errorbar(wl(1:PSKP:end),r3med(1:PSKP:end), r3itv(1:PSKP:end), '.r', 'MarkerSize', 15); 
plot(wl,r1med, 'Color','g', 'LineWidth', 2);
plot(wl,r2med, 'Color','b', 'LineWidth', 2); 
plot(wl,r3med, 'Color','r', 'LineWidth', 2);
% Check to see if spectra are out of range and remove from computation of
% average spectra. If so update T classification matrix to minus
% previous value to mark not to use.
r1min = -9999*ones(length(wl),1); r1max = +9999*ones(length(wl),1);
r2min = r1min; r2max = r1max; r3min = r1min; r3max = r1max;
for wcnt = Bidx:Didx
    r1min(wcnt) = r1med(wcnt)-r1itv(wcnt);
    r1max(wcnt) = r1med(wcnt)+r1itv(wcnt);
    r2min(wcnt) = r2med(wcnt)-r2itv(wcnt);
    r2max(wcnt) = r2med(wcnt)+r2itv(wcnt);
    r3min(wcnt) = r3med(wcnt)-r3itv(wcnt);
    r3max(wcnt) = r3med(wcnt)+r3itv(wcnt);
end
for wcnt = Eidx:Fidx
for r1cnt = 1:length(r1idx)
    bidx = r1idx(r1cnt); 
    a = squeeze(r1min(wcnt)); c = squeeze(r1max(wcnt));
    b = squeeze(squeeze((r(wcnt,2,bidx)))); 
    if ( a > b || b > c)
        T(bidx) = -abs(T(bidx));
    end
end
for r2cnt = 1:length(r2idx)
    bidx = r2idx(r2cnt); 
    a = squeeze(r2min(wcnt)); c = squeeze(r2max(wcnt));
    b = squeeze(squeeze((r(wcnt,2,bidx)))); 
    if ( a > b || b > c)
        T(bidx) = -abs(T(bidx));
    end
end
for r3cnt = 1:length(r3idx)
    bidx = r3idx(r3cnt); 
    a = squeeze(r3min(wcnt)); c = squeeze(r3max(wcnt));
    b = squeeze(squeeze((r(wcnt,2,bidx)))); 
    if ( a > b || b > c)
        T(bidx) = -abs(T(bidx));
    end
end
end 
% identify spectra for out of range
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
xlabel('Wavelength (nm)'); ylabel('Radiance (\muW/cm^2/sr/nm)');
title(  ['All Spectra ',     '(Confidence Interval: Water: ',  ...
        num2str(stdfrac(1)), '\sigma  Sky: ',  ...
        num2str(stdfrac(2)), '\sigma  Reference: ',  ...
        num2str(stdfrac(3)), '\sigma )'   ...
        ]);
text(810, ymax*29/YMAX, 'Reference', 'Color', 'r', 'FontSize', 15);
text(810, ymax*27/YMAX, 'Sky',       'Color', 'b', 'FontSize', 15);
text(810, ymax*25/YMAX, 'Water',     'Color', 'g', 'FontSize', 15);
text(810, ymax*23/YMAX, 'Unused',    'Color', '[0.5 0.5 0.5]', 'FontSize', 15);
set(gca, 'FontSize', 15);
hold off;
saveas(gcf,[dirin,'f_spe_1.png']); 
close all;
end

