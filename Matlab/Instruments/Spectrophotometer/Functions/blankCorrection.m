function [a_blankC, a_blankE] = blankCorrection(a, a_error, blank, blank_error)

a_blankC = a - blank; 
a_blankE = sqrt((a_error.^2) + (blank_error.^2));

end