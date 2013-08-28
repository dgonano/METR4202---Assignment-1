function TargetMain()
%MAIN Summary of this function goes here
%   Detailed explanation goes here
% CONSTANTS
pauseTime = 0;

%setup Motors and NXT conection
% ResetNXT();
mA = NXTMotor('A');
mB = NXTMotor('B');
mC = NXTMotor('C');
motors = [mA, mB, mC];

%get data from file (ReadFile() or ReadInputs())
disp('Staring read...');
arrayAngles = ReadFile();

if isempty(arrayAngles)
    return
end


arraySize = size(arrayAngles);
numMoves = arraySize(1);

begin = input('Begin? (y/n):', 's');
if(begin ~= 'y')
    %exit if anything but yes
    return;
end
for i = 1 : 3
    disp('Begining Moves...');
    for m = 1 : numMoves
        MoveMotorWObs(motors, arrayAngles(m,:));
        disp('Move Complete');
        pause(pauseTime);
    end
end
%close NXT connection
% COM_CloseNXT(COM_GetDefaultNXT());
disp('Program Finished!');
end

