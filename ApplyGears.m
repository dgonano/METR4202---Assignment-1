function [ arrayGears ] = ApplyGears( arrayAngles )
%APPLYGEARS Summary of this function goes here
%   applies gear ratios to angles array
%Gear Ratios
gearRatio1 = 56/24;
gearRatio2 = 36/16;
gearRatio3 = 1;
arrayGears = [];

%code start
inputSize = size(arrayAngles);

if length(inputSize) > 3 || inputSize(2) ~= 3
    return
elseif length(inputSize) == 3
    numArrays = inputSize(3);
else
    numArrays =1;
end

arrayGears = zeros(inputSize(1) ,3 ,numArrays );
for i=1 : numArrays
    arrayGears(:,1,i) = arrayAngles(:,1,i)*gearRatio1;
    arrayGears(:,2,i) = arrayAngles(:,2,i)*gearRatio2;
    arrayGears(:,3,i) = arrayAngles(:,3,i)*gearRatio3;
end

end

