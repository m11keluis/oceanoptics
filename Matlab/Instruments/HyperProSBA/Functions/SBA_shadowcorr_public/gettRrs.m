function [Rrs]=gettRrs(rrs)
% calculate Rrs from rrs
% Rrs=0.52*rrs/(1-1.7rrs)
    global WL WN

    Rrs(1:WN)=0.52.*rrs(1:WN)./(1-1.7*rrs(1:WN));
end