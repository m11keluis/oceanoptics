function [a, bb, apg, bbp, id_ref, kd, kd530, kdminwl, kdmin, zsd] = rrs_zsd(Rrs, wl, bbw, sa)
% rrs2secchi-Computes Secchi disk depth (zsd) according to Lee et al.(2016) 
%
% Syntax: [a, bb, apg, bbp, id_ref, kd, kd530, kdminwl, kdmin, zsd] = rrs_zsd(Rrs, wl, bbw, sa)
%
% Inputs:
%    Rrs - Remote sensing reflectance (sr^-1) from Landsat 8
%    wl - Wavelengths corresponding to Landsat 8 Rrs
%    bbw - Pure water backscattering coefficients [0.002 0.0014 0.0008
%    0.004] from Lee et al. (2016)
%    sa - Solar Zenith Angle [30 degrees]
%
% Outputs:
%    a - Total absorption (1/m) from QAAv6 (Lee et al. 2002)
%    bb - Total backscattering (1/m) from QAAv6 (Lee et al. 2002)
%    apg - Absorption by pighments (1/m) from QAAv6 (Lee et al. 2002)
%    bbp - Backscattering by particles (1/m) from QAAv6 (Lee et al. 2002)
%    id_ref - Reference wavelength (nm) used for QAAv6 (Lee et al. 2002)
%    kd - Diffuse attenuation coefficient (1/m) from Lee et al. (2013)
%    kd530 - Diffuse attenuation coefficient (1/m) for 530 nm from Lee et 
%    al. (2016)                                                               
%    kdminwl - wavelength (nm) of minimum Kd value
%    zsd = Secchi Disc Depth (m)
%
% Examples: 
%    Example 1: All rrs2secchi output: 
%    [a, bb, apg, bbp, id_ref, kd, kd530, kdminwl, kdmin, zsd] =
%    rrs_zsd(Rrs, wl, bbw, sa)
%    
%    Example 2: Only Secchi rrs2secchi output:
%    [~, ~, ~, ~, ~, ~, ~, ~, ~, zsd] = rrs_zsd(Rrs, wl, bbw, sa)
%
% Other m-files required: qaa_v6_l8.m, iop2kd, h20_iops, and zsd_l8
% Subfunctions: none
% MAT-files required: none
% See also: none
%
% Author: Kelly Luis
% Email: kelly.luis001@umb.edu or m11keluis@gmail.com
% Website: http://www.github.com/m11keluis
% March 8, 2019
% ************************************************************************

% Compute IOPs
[a, bb, apg, bbp, id_ref] = qaa_v6_l8(Rrs, wl);

% Compute kd and kd530
kd = iop2kd(a, bb, bbw,sa);
kd530 = 0.2.*kd(:,2) + 0.75.*kd(:,3);

% Compute zsd
Rrs = [Rrs(:,1:2) nan Rrs(:,3:4)];
wl = [wl(1:2) 530 wl(3:4)];

[kdminwl, kdmin, zsd] = zsd_l8(Rrs, wl, bbw);  

end

