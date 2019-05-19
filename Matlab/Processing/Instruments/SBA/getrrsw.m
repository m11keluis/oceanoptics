function [rrsw]=getrrsw(bbw,a,bb)
%calculate rrs contributed from water
%rrsw=0.113*bbw/(a+bb)
global WL WN
    rrsw(1:WN)=0.113.*bbw(1:WN)./(a(1:WN)+bb(1:WN)); 
end