function [ points ] = ReadInputs(  )
%READINPUTS Summary of this function goes here
%   Detailed explanation goes here

points = [];

finish = false;

disp('Blank input to end');


i=1;
while(finish == false)
    
    disp(sprintf('Point %d:',i));
    
    x = input('    x = ');
    y = input('    y = ');
    z = input('    z = ');
    
    if(isempty(x) || isempty(y) || isempty(z))
        finish = true;
    else 
        points(i,1) = x;
        points(i,2) = y;
        points(i,3) = z;

    end
    i = i+1;
    
    if (i > 6)
        finish = true;
    end
    
    
end
