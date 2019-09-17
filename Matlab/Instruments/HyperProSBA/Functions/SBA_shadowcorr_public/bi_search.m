function [ab]=bi_search(lb,ub,bbw555,bbp555,rrs555)

if abs((ub-lb)/ub)<0.05
    [ab]=(ub+lb)/2.0;
else

mid=(ub+lb)/2;
xxx1=lb;
r1=0.113*bbw555/xxx1+bbp555/xxx1*0.2*(1-0.63*exp(-2.448*bbp555/xxx1))-rrs555;
xxx1=mid;
r2=0.113*bbw555/xxx1+bbp555/xxx1*0.2*(1-0.63*exp(-2.448*bbp555/xxx1))-rrs555;
xxx1=ub;
r3=0.113*bbw555/xxx1+bbp555/xxx1*0.2*(1-0.63*exp(-2.448*bbp555/xxx1))-rrs555;

if (r1*r2<=0)
    [ab]=bi_search(lb,mid,bbw555,bbp555,rrs555);
elseif (r2*r3<=0)
    [ab]=bi_search(mid,ub,bbw555,bbp555,rrs555);
elseif (r1*r3>0)
    [ab]=bi_search(lb,ub*2,bbw555,bbp555,rrs555);
else
    % bug checking
%     r1
%     r2
%     r3
%     ub
%     lb
%     mid
end
end

end
