function [aph]=getaph(p,a0,a1)
%calculate absorption of phytoplankton
%Z. Lee, "VISIBLE-INFRARED REMOTE-SENSING MODEL," (University of South Florida, 1994).
%aph=(a0+a1*ln(P))P
global WL WN
    for i=1:WN
        aph(i)=(a0(i)+a1(i)*log(p))*p;
    end
end