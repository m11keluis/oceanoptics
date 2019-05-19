function [min_index, max_index] = rangeWL(hyper_wl,multi_min, multi_max)
    
    [~, min_index] = min(abs(hyper_wl-multi_min));
    [~, max_index] = min(abs(hyper_wl-multi_max));
   
end

