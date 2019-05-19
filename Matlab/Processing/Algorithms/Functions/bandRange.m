function [wlmin, wlmax] = bandRange(wlcenter, width)

    wlmin = wlcenter - (width./2);
    wlmax = wlcenter + (width./2);
    
end
