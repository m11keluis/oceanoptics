function [sedfiles] = listsedfilenames(dirin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
files = dir([dirin,'*.sed']);
for fcnt = 1:length(files)
   sedfiles(fcnt) = {files(fcnt).name};
end

