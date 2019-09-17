function [a_bN, a_bN_error] = nullCorrection(ab, ab_error, wl, low, high)

    if nargin < 4
        low = 750;
        high = 800;
    end
    
    null = nanmean(ab(wl >= low & wl <= high));
    error = nanstd(ab(wl >= low & wl <= high));
    
    a_bN = ab - null;
    a_bN_error = sqrt(ab_error.^2 + error.^2);
    
end
