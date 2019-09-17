function [rrsdp]=getrrsdp(rrsw,bbp,a,bb)
% calculate rrs for infinite depth
% rrsdp=0.2*{1-0.63*exp[-2.448*bbp/(a+bb)]}*bbp/(a+bb)+rrsw
global WL WN    
     for i=1:WN
        temp2=bbp(i)/(a(i)+bb(i));
        temp1=0.2*(1-0.63*exp(-2.448*temp2));
        rrsdp(i)=temp1*temp2+rrsw(i);
    end
    
end