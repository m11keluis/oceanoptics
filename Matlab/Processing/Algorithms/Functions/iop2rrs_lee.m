function [rrs] = iop2rrs_lee(a, bb, bbp, bbw)
    % Lee et al (2004) - Compute Subsurface Remotes Sensing Reflectance
    % (rrs) with total absorption (a) and backscattering coefficients (bb)

    % Coefficients
    gw = 0.113;
    G0 = 0.197;
    G1 = 0.636;
    G2 = 2.552;
    
    % Step 1: Calculate gp
    gp = G0*(1-(G1*exp(-G2*(bbp/(a+bb)))));
    
    % Step 2: Calculate rrs 
    rrs = gw*(bbw/(a+bb))+gp*(bbp/(a+bb));
    
end


