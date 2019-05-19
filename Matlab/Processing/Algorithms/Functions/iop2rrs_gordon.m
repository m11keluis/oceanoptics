function [rrs] = iop2rrs_gordon(a,bb)
    % Gordon et al. 1989 - Compute Subsurface Remotes Sensing Reflectance
    % (rrs) with total absorption (a) and backscattering coefficients (bb)

    % Coefficients
    g0 = 0.0949;
    g1 = 0.0794;
    
    % Step 1: Calculate g
    g = g0 + g1*(bb/(a+bb));
    
    % Step 2: Calculate rrs 
    rrs = g*(bb/(a+bb));
    
end

