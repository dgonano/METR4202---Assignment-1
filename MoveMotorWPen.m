function [] = MoveMotorWPen(motors, desPosition)
    %both must be arrays, [ , , , ]
    activeMotors = [];
    OFFSET = 14;
    
    desPosition(1) = round(desPosition(1)*56/24);
    desPosition(2) = round(desPosition(2)*36/16);
    
    if (length(motors) ~= length(desPosition))
        disp('Arrays must be same length');
        return;
    end
    
    for i = 1 : length(motors)
        
        m = motors(i);
        position = m.ReadFromNXT();
        desMove = desPosition(i) - position.Position;
        
        if desMove == 0 
            disp('Done, No move');
        else
            m = NXTMotor(m.Port, 'Power', 10, 'TachoLimit', abs(desMove), 'ActionAtTachoLimit', 'HoldBrake');
            if desMove < 0
                m.Power = -m.Power;
                if m.Port == 0
                    m.TachoLimit = m.TachoLimit + OFFSET;
                    disp('compensated');
                end
                
            end
            motors(i) = m;
            activeMotors = cat(2,activeMotors, m);
        end
        
    end


    for i = activeMotors
        i.SendToNXT();
    end
    
    for i = activeMotors
       i.WaitFor();
    end

end