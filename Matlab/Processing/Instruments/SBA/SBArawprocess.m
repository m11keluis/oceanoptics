clc
clear


WL_ES_LS=[
348.4	349.7
351.7	353
355	356.3
358.3	359.7
361.7	363
365	366.4
368.3	369.7
371.6	373
375	376.4
378.3	379.7
381.6	383.1
385	386.4
388.3	389.8
391.6	393.1
395	396.5
398.3	399.8
401.6	403.1
405	406.5
408.3	409.8
411.7	413.2
415	416.5
418.4	419.9
421.7	423.2
425	426.6
428.4	429.9
431.7	433.3
435.1	436.6
438.4	440
441.7	443.3
445.1	446.7
448.4	450.1
451.8	453.4
455.1	456.8
458.5	460.1
461.8	463.4
465.2	466.8
468.5	470.2
471.9	473.5
475.2	476.9
478.6	480.2
481.9	483.6
485.3	486.9
488.6	490.3
492	493.6
495.3	497
498.7	500.4
502	503.7
505.4	507.1
508.7	510.4
512.1	513.8
515.4	517.1
518.8	520.5
522.1	523.8
525.5	527.2
528.8	530.5
532.2	533.9
535.5	537.3
538.9	540.6
542.3	544
545.6	547.3
549	550.7
552.3	554
555.7	557.4
559	560.7
562.4	564.1
565.7	567.5
569.1	570.8
572.4	574.2
575.8	577.5
579.1	580.9
582.5	584.2
585.9	587.6
589.2	590.9
592.6	594.3
595.9	597.6
599.3	601
602.6	604.3
606	607.7
609.3	611
612.7	614.4
616	617.7
619.4	621.1
622.8	624.5
626.1	627.8
629.5	631.1
632.8	634.5
636.2	637.9
639.5	641.2
642.9	644.5
646.2	647.9
649.6	651.2
652.9	654.6
656.3	657.9
659.6	661.3
663	664.6
666.3	668
669.7	671.3
673	674.7
676.4	678
679.7	681.4
683.1	684.7
686.4	688
689.8	691.4
693.1	694.7
696.5	698.1
699.8	701.4
703.1	704.8
706.5	708.1
709.8	711.4
713.2	714.8
716.5	718.1
719.9	721.5
723.2	724.8
726.5	728.1
729.9	731.5
733.2	734.8
736.6	738.1
739.9	741.5
743.3	744.8
746.6	748.1
749.9	751.5
753.3	754.8
756.6	758.1
759.9	761.5
763.3	764.8
766.6	768.1
769.9	771.4
773.3	774.8
776.6	778.1
779.9	781.4
783.3	784.7
786.6	788
789.9	791.4
793.2	794.7
796.5	798
799.9	801.3
803.2	804.6
];

WL_ES_LS=WL_ES_LS';

% cd C:\Users\SZH\Desktop\KORUS_Mat_Files\Mat_Files
%  cd C:\Users\SZH\Desktop\KORUS_Mat_Files\Mat_Files\New_folder
path_0=dir('*.mat');
[numfiles temp]=size(path_0);

for k=1:1:numfiles
    a=path_0(k).name;
    [temp1 temp2]=size(a);
    b=a(1:temp2-4); %delete '.mat'
    load(b);
    
%     name=cell2mat(hdfdata.file_name);
    
    
%     load C:\Users\SZH\Desktop\KORUS_Mat_Files\Mat_Files\2016-142-232733_L2s
%     load C:\Users\SZH\Desktop\KORUS_Mat_Files\Mat_Files\2016-143-003120_L2s
%    load C:\Users\SZH\Desktop\KORUS_Mat_Files\Mat_Files\2016-143-013126_L2s
%     load C:\Users\SZH\Desktop\KORUS_Mat_Files\Mat_Files\2016-143-033941_L2s
% load C:\Users\SZH\Desktop\KORUS_Mat_Files\Mat_Files\2016-143-045049_L2s


%  load C:\Users\SZH\Desktop\KORUS_Mat_Files\Mat_Files\2016-151-044113_L2s
% load C:\Users\SZH\Desktop\KORUS_Mat_Files\Mat_Files\2016-153-031821_L2s

tiltraw=hdfdata.ABS_TILT_data;
Lsraw=hdfdata.LS_hyperspectral_data;
Esraw=hdfdata.ES_hyperspectral_data;
% % WL_Ls=hdfdata.LS_hyperspectral_fields;
% % WL_Es=hdfdata.ES_hyperspectral_fields;


% [end1 head1]=size(tiltraw);
% 
% head1_1=floor(0.25*end1);
% end1_1=end1-head1_1;
% 
% 
% tiltraw1=tiltraw(head1_1:end1_1);
% Lsraw1=Lsraw(head1_1:end1_1,:);
% Esraw1=Esraw(head1_1:end1_1,:);
% 
% 
% % remove tilting > 5 deg
% temp=find(tiltraw1<5);
% Ls_tilt=Lsraw1(temp,:);
% Es_tilt=Esraw1(temp,:);
% 
% %standard for sort: 490nm
% wl=44;
% Rrs_tilt=Ls_tilt./Es_tilt;
% Rrs_sort=sortrows(Rrs_tilt,44);
% % Ls_sort=sortrows(Ls_tilt,44);

% remove tilting > 5 deg
temp=find(tiltraw<5);
Ls_tilt=Lsraw(temp,:);
Es_tilt=Esraw(temp,:);



[end1 head1]=size(Ls_tilt);

head1_1=floor(0.25*end1);
end1_1=end1-head1_1;


% tiltraw1=tiltraw(head1_1:end1_1);
Lsraw1=Ls_tilt(head1_1:end1_1,:);
Esraw1=Es_tilt(head1_1:end1_1,:);







%standard for sort: 490nm
wl=44;%490
%wl=16;%400

[temp1 temp2]=size(Lsraw1);
for i=1:1:temp1
Esraw1_0(i,:)=interp1(WL_ES_LS(1,:),Esraw1(i,:),WL_ES_LS(2,:));
end

Rrs_tilt=Lsraw1./Esraw1_0;
Rrs_sort=sortrows(Rrs_tilt,wl);
% Ls_sort=sortrows(Ls_tilt,44);

% [end1 head1]=size(Rrs_sort);
%     % 90% confidence interval, sqrt(3)/2
%     
%     temp1=(1-sqrt(3.0)/2)/2
% %     temp1=0.2;
% head1_1=floor(temp1*end1);
% end1_1=end1-head1_1;
% Rrs_sort_2=Rrs_sort(head1_1:end1_1,:);


% median

% Rrs_0=Ls_sort_2./Es_sort_2;
% Rrs=median(Rrs_sort_2);
% Rrs_avg=mean(Rrs_sort_2,1);
% Ls_median=median(Ls_sort_2);
% Es_median=median(Es_sort_2);
% Rrs=Ls_median./Es_median;
Rrs_wl0=Rrs_sort(:,wl);
temp=find(~isnan(Rrs_wl0));
Rrs_wl=Rrs_wl0(temp);


Rrs_m1=mean(Rrs_wl);
Rrs_s1=std(Rrs_wl);

temp1=Rrs_m1+Rrs_s1;
temp2=Rrs_m1-Rrs_s1;

temp_2=find(Rrs_wl<temp1);
Rrs_sort_2=Rrs_sort(temp_2,:);
Rrs_wl_2=Rrs_wl(temp_2);

temp_3=find(Rrs_wl_2>temp2);
Rrs_sort_3=Rrs_sort_2(temp_3,:);

Rrs_sort_3_m=median(Rrs_sort_3);
Rrs_sort_3_m=Rrs_sort_3_m';
Rrs_sort_3_avg=mean(Rrs_sort_3,1);
Rrs_sort_3_avg=Rrs_sort_3_avg';
Rrs_sort_3_smooth=smooth(Rrs_sort_3_m);
% Rrs_sort_3_smooth_2=smooth(Rrs_sort_3_m,20,'lowess');

[temp1 temp2]=size(Rrs_sort_3_m);
Rrsm(1:temp1,k)=Rrs_sort_3_m(1:temp1);
Rrsavg(1:temp1,k)=Rrs_sort_3_avg(1:temp1);
Rrssmooth(1:temp1,k)=Rrs_sort_3_smooth(1:temp1);

clear hdfdata Lsraw1 Esraw1 Ls_tilt Es_tilt Esraw1_0 Rrs_tilt
end

save Rrsm Rrsm
save Rrsavg Rrsavg
save Rrssmooth Rrssmooth
