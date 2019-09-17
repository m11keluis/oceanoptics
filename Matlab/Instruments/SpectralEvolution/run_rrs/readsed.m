function [r] = readsed(dirin, filein)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
fileID  = fopen([dirin,filein])
lcnt = 1; dcnt = 1;
DSL = 28; % Data Start read at Line #
while ~feof(fileID)
    line = fgetl(fileID); % # read line by line
    if (lcnt > (DSL-1))
       [r(dcnt,1:)]  = sscanf(line,'%f%f%f');
       dcnt = dcnt+1;
    end
    lcnt = lcnt + 1;
end
r;
fclose(fileID);
end
