function f=optimization1(x)
% x0=[P S bbp440 Y];
% optimization process
global a0 a1 aw bbw;
global s1 s2 s3 s4 Rrsraw;
global WL WN;
global G;
%
    i=32; %wavelength=555
    aph555=(a0(i)+a1(i)*log(x(1)))*x(1);
    bbp555=x(3)*((440/WL(i))^x(4));
    bb555=bbw(i)+bbp555;
    rrs555=Rrsraw(i)/(0.52+1.7*Rrsraw(i));
    
    
    %Newton's method to solve a(555)+bb(555)
    %x=a555+bb555
    %x_n+1=x_n + f(x_n)/f'(x_n)
    %x1=0.014
    %f(x)=0.113*bbw555/x+bbp555/x*0.2*(1-0.63*exp(-2.448*bbp/x))-rrs555
    %f'(x)=-0.113*bbw555/x^2-0.2*bbp555/x^2+0.2*0.63*bbp555*exp(-2.448*bbp555/x)/x^2-0.2*0.63*bbp555/x*exp(-2.448*bbp555/x)*(2.448*bbp555/x^2)
    tolerance=0.05; %tolerance ratio for Newton's method

    ab1=2*aph555+aw(i)+bb555; %first guess of a(555)+bb(555)
    countn=0;
    tol=999;
    while tol>tolerance
       countn=countn+1;
    ftemp1=0.113*bbw(i)/ab1+bbp555/ab1*0.2*(1-0.63*exp(-2.448*bbp555/ab1))-rrs555;
    ftemp11=-0.113*bbw(i)/(ab1^2)-0.2*bbp555/(ab1^2)+0.2*0.63*bbp555*exp(-2.448*bbp555/ab1)/(ab1^2);
    ftemp11=ftemp11-0.2*0.63*bbp555/ab1*exp(-2.448*bbp555/ab1)*(2.448*bbp555/(ab1^2));
    abn=ab1-ftemp1/ftemp11;
    
    tol=abs(abn-ab1)/ab1;

    ab1=abn;
    end
    
    %#### this is for back up when Newton's method is not working
    %#### binary search
    % lab=0.001;    % first guess of lower boundary of a555+b555
    % uab=1.0;        % first guess of upper boundary of a555+b555   
    %   [abn]=bi_search(lab,uab,bbw(i),bbp555,rrs555);
    %####
    
    Sab555=abn; %final estimated a555+bb555
    
    a555=Sab555-bb555;
    ag555=a555-aph555-aw(i);

    G=ag555/exp(-x(2)*(WL(i)-440));    
       
    %now we have the guess of P,G,S,bbp440,Y
    %calculate error between simuated Rrs and measured Rrs,
    %see if this pair of P,S,bbp440,Y get better match
    %
    
    [ag]=getag(G,x(2));
    [aph]=getaph(x(1),a0,a1);
    [bbp]=getbbp(x(3),x(4));
    [a]=geta(aw,aph,ag);
    [bb]=getbb(bbw,bbp);
    
    [rrsw]=getrrsw(bbw,a,bb);
    [rrsdp]=getrrsdp(rrsw,bbp,a,bb);
    [rrs]=getrrs(rrsdp);
    [Rrs]=gettRrs(rrs);
    [shade]=getshade(a,bb,s1,s2,s3,s4);
    [Rrss]=getRrss(Rrs,shade);
    
    temp=geterror(Rrsraw,Rrss);
    f=temp; %calculated error between simulate Rrs and measured Rrs

end
