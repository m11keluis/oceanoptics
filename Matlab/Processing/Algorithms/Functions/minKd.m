function [kdmin, kdminwl] = minKd(kd, wl)

    % Find the the minimum Kd and index
    [kdmin, index] = min(kd); 

    % Find the wavelength of the minimum kd
    kdminwl = wl(index);
    
end
