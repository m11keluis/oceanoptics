function [centerWl] = bandCenter(minwl, maxwl)

    centerWl = floor(minwl + abs(minwl-maxwl)./2);
    
end