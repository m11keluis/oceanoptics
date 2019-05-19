function [rrs] = arrs2brrs(Rrs)
    % Converts above water remote sensing reflectance to below water
    % remote sensing reflectance
    % Input:
    % Rrs = above water remote sensing reflectance (sr^-1)
    % Output:
    % rrs = below water remote sensing reflectance (sr^-1)

    rrs = Rrs/(0.52+1.7*Rrs);
    
end

