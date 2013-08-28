function [] = MoveMotorWObs(motors, desPosition)
    %both must be arrays, [mA ,mB ,mC ]
    B_angle = 20; %20
    C_angle = 150;
    
    if (length(motors) ~= 3 || length(desPosition) ~= 3)
        disp('Arrays must be 3 long');
        return;
    end
    
    currentBase = ceil(motors(1).ReadFromNXT.Position/56*24);
    currentTop = motors(3).ReadFromNXT.Position;
    
    disp('Move 1');
    MoveMotor(motors, [currentBase, B_angle, currentTop]);
    disp('Move 2');
    MoveMotor(motors, [desPosition(1), B_angle, desPosition(3)]);
    disp('Move 3');
    MoveMotor(motors, [desPosition(1), desPosition(2), desPosition(3)]);

end