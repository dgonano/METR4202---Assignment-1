function [ points ] = ReadFile()
%READFILE Summary of this function goes here
%   Detailed explanation goes here

points = csvread('/test.txt');
disp(points);
accept = input('Accept data? (y/n):', 's');
if(accept == 'y')
    return;
else
    disp('Data rejected');
    points = [];

end

