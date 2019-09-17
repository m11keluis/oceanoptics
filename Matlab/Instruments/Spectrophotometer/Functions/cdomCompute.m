function ag = cdomCompute(od, l)

    if nargin < 2
        l = 0.1;
    end
        
    ag = (2.303./l).*od;
    
end