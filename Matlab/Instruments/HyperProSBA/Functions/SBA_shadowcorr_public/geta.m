function [a]=geta(aw,aph,ag)
%calculate total absorption
%a=aw+aph+adg
global WL WN 
        a(1:WN)=aw(1:WN)+aph(1:WN)+ag(1:WN);
end