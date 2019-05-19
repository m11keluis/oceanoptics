%############################################################# 
%edited by Zhehai Shang on July 18, 2017
%#############################################################
%This script is designed for shading error correction of SBA
%not applicable for shallow water
%
% The input format could be easily customized by users
% make sure to include solar zenith and Rrs for each staion

%#################################
%#################################

clc
clear 

global G                                    % this one is designed for calculate from the four free variables
global P S bbp440 Y;                        % free variables
%   P: aph(440)
%   S: slope of adg
%   bbp440: bbp(440)
%   Y: slope of particle backscattering
%   G: adg(440)

global PI radius;                           % PI; radius of sensor 
global a0 a1;                               % for calculation of aph
global aw bbw                               % IOPs of pure water
global theta thetaw                         % solar zenith; solar zenith at subsurface
global s1 s2 s3 s4;                         % parameter for shading correction 
global Rrsraw Rrsc;                         % input Rrs; corrected Rrs
global WL WN                                % bands; number of bands

%##### parameter initialize #####
radius=0.05238;                             % radius of sensor, (meter)
WL=[400:5:750];                             % bands
[temp WN]=size(WL);                         

n=1.34;                                     % refraction index of water

temp1=cd; %###get current folder###
%or make sure get to the right folder where the code is at
parameterfolder=strcat(temp1,'\');  % which could be customized by user
scriptfolder=strcat(temp1,'\');     % which could be customized by user

PI=acos(-1.0);
twopi=2.0*PI;

% for reading pure water IOP###################################################3
filename=strcat(parameterfolder,'purewaterIOP.txt') ;
fidin=fopen(filename);
tempn=fscanf(fidin,'%f\t',[1 1]); % lines of heading
for i=1:1:tempn
    temp=fgetl(fidin);
end
clear temp

temp=fscanf(fidin,'%f\t',[3 inf]);

[temp1 temp2]=size(temp);

temp=temp';
aw=interp1(temp(:,1),temp(:,2),WL);
bbw=0.5*interp1(temp(:,1),temp(:,3),WL);
fclose(fidin);

%#### aph parameter ##########################
filename=strcat(parameterfolder,'a0a1.txt') ;
fidin=fopen(filename);
tempn=fscanf(fidin,'%f\t',[1 1]);   % lines of heading
for i=1:1:tempn
    temp=fgetl(fidin);
end
clear temp

temp=fscanf(fidin,'%f\t',[3 inf]);
[temp1 temp2]=size(temp);
temp=temp';

a0=interp1(temp(:,1),temp(:,2),WL,'cubic');
a1=interp1(temp(:,1),temp(:,3),WL,'cubic');

fclose(fidin);
%######################################################

starts=1; %start station number 
ends=1;   %end station number

%##### start circulation for each station ###########################
for i=starts:1:ends

    
%##### reading Rrs #################################################
filename=strcat(scriptfolder,'2015-260-140557.raw');
fidin=fopen(filename);

tempn=fscanf(fidin,'%f\t',[1 1]);   % lines of heading
for i=1:1:tempn
    temp=fgetl(fidin);
end
clear temp
temp=fscanf(fidin,'%f\t',[2 inf]);

[temp1 temp2]=size(temp);
temp=temp';

Rrsraw=interp1(temp(:,1),temp(:,2),WL);
%####### solar zenith #########################

theta=30;                                %solar zenith in degree, which is an example here   
thetaw=asin(sin(theta*PI/180)/n)*180/PI; %solar zenith at subsurface
    
%####### parameter for estimation of shading error ###
s1=1.15+3.15*sin(thetaw/180*PI);
s2=-1.57;
s3=5.62*sin(thetaw/180*PI)-0.23;
s4=-0.5;

%##### initial guess ################
% P=0.072*(Rrs(440)/Rrs(555))^1.62;
% G=P
% S=0.014
% Y=2.0*(1-1.2*exp(-0.9*rrs(400)/rrs(555)))
% bbp440=30*aw(640)*Rrs(640)*((400/440)^Y)

temp11=Rrsraw(1)/(0.52+1.7*Rrsraw(1)); 
temp12=Rrsraw(32)/(0.52+1.7*Rrsraw(32));

P=0.072*(Rrsraw(9)/Rrsraw(32))^1.62;
G=P;
S=0.014;
Y=2.0*(1-1.2*exp(-0.9*temp11/temp12));

bbp440=30*aw(49)*Rrsraw(49)*((400/440)^Y);

Y1=0.8*Y;
Y2=2.0*Y;
if (Y<0) 
    Y1=0.1;
    Y2=2.0;
end
    
% #### for debugg    #####
% [ag]=getag(G,S);
% [aph]=getaph(P,a0,a1);
% [bbp]=getbbp(bbp440,Y);
% [a]=geta(aw,aph,ag);
% [bb]=getbb(bbw,bbp);
% 
% [rrsw]=getrrsw(bbw,a,bb);
% [rrsdp]=getrrsdp(rrsw,bbp,a,bb);
% [rrs]=getrrs(rrsdp);
% [Rrs]=gettRrs(rrs);
% [shade]=getshade(a,bb,s1,s2,s3,s4);
% [Rrss]=getRrss(Rrs,shade);
% [error]=geterror(Rrsraw,Rrss)
% #################################

        x1=P;
        x2=S;
        x3=bbp440;
        x4=Y;
        x0=[x1 x2 x3 x4];

        options=optimset('largescale','on','display','iter','tolx',1e-8,'tolfun',1e-12,'Algorithm','active-set','MaxFunEvals',10000,'MaxIter',10000);
        LB=[0.001;0.008;0.001;Y1];  %lower boundary
        UB=[1;0.03;0.3;Y2];         %upper boundary  
    
        [xx,fval]=fmincon(@optimization1,x0,[],[],[],[],LB,UB,[],options);

        P=xx(1);
        S=xx(2);
        bbp440=xx(3);
        Y=xx(4);

        [ag]=getag(G,S);
        [aph]=getaph(P,a0,a1);
        [bbp]=getbbp(bbp440,Y); 
        [a]=geta(aw,aph,ag);                    %estimated absorption
        [bb]=getbb(bbw,bbp);                    %estimated backscattering

        [rrsw]=getrrsw(bbw,a,bb);
        [rrsdp]=getrrsdp(rrsw,bbp,a,bb);
        [rrs]=getrrs(rrsdp);
        [Rrs]=gettRrs(rrs);
        [shade]=getshade(a,bb,s1,s2,s3,s4);     %estimated shading error
        [Rrss]=getRrss(Rrs,shade);              %simulated Rrs with shading
        [error]=geterror(Rrsraw,Rrss);          %final error
      
    
    %#### correct shading error

    Rrsc(1:WN)=Rrsraw./(1-shade(1:WN));

    %#### plot figure
     h=figure(1);
     set(gca,'FontSize',40);
    hold off
    set(gcf,'Units','centimeters')
    set(gcf,'PaperUnits','centimeters')
    set(gcf,'Position',[1 2 35 25]);
    set(gca,'Position',[0.10 0.10 0.8 0.8]);  
    
    hold off
    plot(WL,Rrsc(1:WN),'r-','linewidth',3);
    
    hold on
    
    plot(WL,Rrsraw(1:WN),'b-','linewidth',3);
    plot(WL,Rrss(1:WN),'g-','linewidth',3);
     
     set(gca,'xlim',[WL(1) WL(WN)]);
     set(gca,'XTick',WL(1):50:WL(WN));
     xlabel('\lambda nm');
     ylabel('R_r_s');
     legend('R_r_s corrected','R_r_s measured','R_r_s simulated');
          
    %#### output ########

    filename=strcat(scriptfolder,'output.txt');
    fidin=fopen(filename,'wt');    
    fprintf(fidin,'band\tRrs measured\tRrscorrected\n');
    for i=1:WN
        fprintf(fidin,'%f\t%f\t%f',WL(i),Rrsraw(i),Rrsc(i));
        fprintf(fidin,'\n');
    end
    
    fclose(fidin);
end








