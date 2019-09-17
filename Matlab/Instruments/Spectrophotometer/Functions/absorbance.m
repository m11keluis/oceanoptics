function [A, A_error] = absorbance(a)

a_array = table2array(a);

A = nanmean(a_array,2);
A_error = nanstd(a_array,0,2);

end
