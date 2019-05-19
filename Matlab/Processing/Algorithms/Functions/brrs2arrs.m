function [Rrs] = brrs2arrs(rrs)
    % Converts below water remote sensing reflectance to above water
    % remote sensing reflectance
    % Input:
    % rrs = below water remote sensing reflectance (sr^-1)
    % Output:
    % Rrs = above water remote sensing reflectance (sr^-1)

    Rrs = 0.52*rrs/(1-1.7*rrs);
    
end

