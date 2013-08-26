function TargetMain()
%MAIN Summary of this function goes here
%   Detailed explanation goes here
% CONSTANTS
pauseTime = 5;

%setup Motors and NXT conection
ResetNXT();
mA = NXTMotor('A');
mB = NXTMotor('B');
mC = NXTMotor('C');
motors = [mA, mB, mC];

%get data from file (ReadFile() or ReadInputs())
Disp('Staring read...');
PointsXYZ = ReadFile();

%send points to thomas to get angles back
disp('Getting angles...');
arrayAngles = []; %change this

disp('Applying Gear ratios...');
arrayGears = ApplyGears(arrayAngles);

arraySize = size(arrayGears);

if length(arraySize) == 2
    numMoves = 1;
else
    numMoves = arraySize(3);
end

begin = input('Begin? (y/n):', 's');
if(begin ~= 'y')
    %exit if anything but yes
    return;
end

disp('Begining Moves...');
for m = 1 : numMoves
    for s = 1 : arraySize(1)
        MoveMotor(motors, arrayGears(s, :, m));
        disp('Step Complete');
    end
    disp('Move Complete');
    pause(pauseTime);
end

%close NXT connection
COM_CloseNXT(COM_GetDefaultNXT());
disp('Program Finished!');
end

