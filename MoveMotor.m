function [] = MoveMotor(motor, desPosition)
    position = motor.ReadFromNXT();
    desMove = desPosition - position.Position;
    if desMove == 0 
        return
        disp('Done, No move');
    end
    
    motor = NXTMotor('A', 'Power', 50, 'TachoLimit', abs(desMove), 'ActionAtTachoLimit', 'HoldBrake');
    if desMove < 0 
        motor.Power = -motor.Power;
    end
    
    motor.SendToNXT();
    
    motor.WaitFor();
    disp('Done');

end