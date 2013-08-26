function [ rowData ] = recordPosRow( )
%RECORDPOSROW Summary of this function goes here
%   Detailed explanation goes here
rowData = zeros(3,10);
start = input('zero robot? (return):', 's');
if isempty(start)
    ResetNXT();
else
    return;
end

mA = NXTMotor('A');
mB = NXTMotor('B');
mC = NXTMotor('C');

for i = 1 : 10
    disp(sprintf('New Point! point %d:',i));
    record = input('record pos? (return):', 's');
    if isempty(record)
        posA = mA.ReadFromNXT();
        posB = mB.ReadFromNXT();
        posC = mC.ReadFromNXT();
        rowData(:,i) = [posA.position, posB.position, posC.position];
    else
        return;
    end
end


end

