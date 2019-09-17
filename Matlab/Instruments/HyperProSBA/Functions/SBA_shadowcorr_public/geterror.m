function [error]=geterror(Rrsraw,Rrss)
%calculate the error between simulated Rrs and measured Rrs     
%error = {avg[(Rrsraw-Rrss)^2 (1:WN)]}^0.5/avg[(Rrsraw) (1:WN)]
global WL WN   

    temp1=0;
    temp2=0;
    temp3=0;
    temp4=0;
    count=0;
    
    for i=1:WN
        temp1=temp1+Rrsraw(i);
        temp2=temp2+(Rrsraw(i)-Rrss(i))*(Rrsraw(i)-Rrss(i));
        count=count+1;
    end
    temp3=temp1/count;
    temp4=temp2/count;

	
    %error=((temp1+temp3)^0.5)/(temp2+temp4);
    error=(temp4^0.5)/temp3;
    
end