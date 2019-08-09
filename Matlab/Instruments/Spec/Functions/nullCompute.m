function [null, error] = nullCompute(wl, ab, low, high)

    % wl = wavelength 
    % ab = absorbance measured by spec
    
    if nargin < 4
        low = 750;
        high = 800;
    end
    
    null = nanmean(ab(wl >= low & wl <= high));
    error = nanstd(ab(wl >= low & wl <= high));
    
end
