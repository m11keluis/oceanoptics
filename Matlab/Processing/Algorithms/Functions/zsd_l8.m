function [kdminwl, kdmin, zsd] = zsd_l8(Rrs, kd, wl)
% zsd_l8-Compute Secchi disk depth (zsd) according to Lee et al.(2016) 
%
% Syntax: [kdminwl, kdmin, zsd] = zsd_l8(Rrs, kd, wl)
%
% Inputs:
%    Rrs - Remote sensing reflectance (sr^-1) from Landsat 8
%    wl - Wavelengths corresponding to Landsat 8 Rrs
%    kd - Diffuse attenuation coefficient (1/m) from Lee et al. (2013)
%
% Outputs:
%    kdmin - Minimum diffuse attenuation coefficient (1/m)                                                            
%    kdminwl - Wavelength (nm) of minimum kd value
%    zsd = Secchi Disc Depth (m)
%
% Examples: 
%    Example 1: All zsd_l8 output:
%    [kdminwl, kdmin, zsd] = zsd_l8(Rrs, kd, wl)  
%    
% Other m-files required: qaa_v6_l8.m, iop2kd, and h20_iops
% Subfunctions: none
% MAT-files required: none
% See also: none
%
% Author: Kelly Luis
% Email: kelly.luis001@umb.edu or m11keluis@gmail.com
% Website: http://www.github.com/m11keluis
% March 8, 2019
% ************************************************************************

% Find the the minimum Kd and index
[kdmin, index] = min(kd); 

% Find the wavelength of the minimum kd
kdminwl = wl(index);

% Use max rrs value in rrs vector for secchi if wl is 530
    if kdminwl == 530 
        zsd = 1./(2.5.*kdmin).*log(abs(0.14-max(Rrs))./0.013);
    else
    zsd = 1./(2.5.*kdmin).*log(abs(0.14-Rrs(index))./0.013);
    end
    


