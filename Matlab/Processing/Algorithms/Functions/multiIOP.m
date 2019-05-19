function [a, bb, bw, bbp] = multiIOP(at, bbt, bwt,bbpt, hwl, mmin, mmax)

% Description: Hyperspectral to Multispectral Wavelength

        [wlminI, wlmaxI] = rangeWL(hwl,mmin, mmax);
        
        a = mean(at(wlminI:wlminI));
        bb = mean(bbt(wlminI:wlmaxI));
        bw = mean(bwt(wlminI:wlmaxI));
        bbp = mean(bbpt(wlminI:wlmaxI));
end

