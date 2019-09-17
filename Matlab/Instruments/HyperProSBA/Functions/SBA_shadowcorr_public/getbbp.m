function [bbp]=getbbp(bbp440,Y)
% calculate particle backscattering 
% bbp=bbp440*(440/lambda)^Y
global WL WN
     bbp(1:WN)=bbp440.*((440./WL(1:WN)).^Y);
end