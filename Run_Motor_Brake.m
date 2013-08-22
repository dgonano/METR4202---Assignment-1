h = COM_OpenNXT();
COM_SetDefaultNXT(h);

%Main motor
% +ve power goes clockwise
% 2nd motor
% +ve power goes down
%3 rdd motor
% +ve power goes down



mA = NXTMotor('A', 'Power', 30, 'TachoLimit', 90, 'ActionAtTachoLimit', 'HoldBrake');
% mB = NXTMotor('B', 'Power',-30, 'TachoLimit', 1, 'ActionAtTachoLimit', 'HoldBrake');
% mC = NXTMotor('C', 'Power',-30, 'TachoLimit', 1, 'ActionAtTachoLimit', 'HoldBrake');


mA.SendToNXT();
% mB.SendToNXT();
% mC.SendToNXT();

mA.WaitFor();

COM_CloseNXT(COM_GetDefaultNXT());