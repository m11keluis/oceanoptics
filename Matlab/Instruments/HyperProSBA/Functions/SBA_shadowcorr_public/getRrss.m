function [Rrss]=gettRrs(Rrs,shade)
% calculate simulate Rrs with shading error
% Rrss=Rrs*(1-shade)
    global WL WN
    Rrss(1:WN)=Rrs(1:WN).*(1-shade(1:WN));
end