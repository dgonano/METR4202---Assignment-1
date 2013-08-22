function ReadMotor()
    
    h = COM_OpenNXT();
    COM_SetDefaultNXT(h);




    mA = NXTMotor('A');
    
    
    while true
        position = mA.ReadFromNXT();
        disp(sprintf('Motor A is currently at position %d', position.Position));
        data = input('Move to? ');
        MoveMotor(mA, data);
    end
    

    COM_CloseNXT(COM_GetDefaultNXT());

end


