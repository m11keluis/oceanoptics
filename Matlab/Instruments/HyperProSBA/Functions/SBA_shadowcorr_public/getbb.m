function [bb]=getbb(bbw,bbp)
%calculate total backscattering
%bb=bbw+bbp
    global WL WN
    bb(1:WN)=bbw(1:WN)+bbp(1:WN);
end