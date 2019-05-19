function [kd] = Kd(at, bbt, bwt, sa, hwl, mmin, mmax)

% Description: Computes Kd from IOPs and finds the minimum Kd and
% corresponding wavelength. 

% Functions:
% iop2Kd.m

        [wlminI, wlmaxI] = rangeWL(hwl,mmin, mmax);
        
        % Kd Calculation (Lee et al. 2013)
        a = mean(at(wlminI:wlminI));
        bb = mean(bbt(wlminI:wlmaxI));
        bw = mean(bwt(wlminI:wlmaxI));
        kd = iop2kd(a, bb, bw, sa);
        
end