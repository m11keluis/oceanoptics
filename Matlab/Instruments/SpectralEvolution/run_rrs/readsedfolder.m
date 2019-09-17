function [r] = readsedfolder(dirin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
files = dir([dirin,'*.sed']);
for fcnt = 1:length(files)
filename = files(fcnt).name;
fileID  = fopen([dirin,filename]);
lcnt = 1; dcnt = 1;
DSL = 28; % Data Start read at Line #
while ~feof(fileID)
    line = fgetl(fileID); %# read line by line
    if (lcnt > (DSL-1))
        [r(dcnt,1:3,fcnt)]  = sscanf(line,'%f%f%f');
        %[r(dcnt,1:2,fcnt)]  = sscanf(line,'%f%f%f'); % only two column data
       dcnt = dcnt+1;
    end
    lcnt = lcnt + 1;
end
fclose(fileID);
end

