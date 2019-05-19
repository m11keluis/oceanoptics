function [shade]=gettRrs(a,bb,s1,s2,s3,s4)
% calculate shading error
global thetaw radius PI;
global WN WL
   
    for i=1:WN
        temp1=s1*a(i)*exp(s2*bb(i))+s3*bb(i)*exp(s4*a(i));
        shade(i)=1-exp(-temp1*radius/tan(thetaw/180*PI));
    end
end