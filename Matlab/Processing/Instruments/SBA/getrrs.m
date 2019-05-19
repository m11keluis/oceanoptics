function [rrs]=getrrs(rrsdp)
%calculate rrs
%rrs=rrsdp
global WL WN
   
    rrs(1:WN)=rrsdp(1:WN);
end