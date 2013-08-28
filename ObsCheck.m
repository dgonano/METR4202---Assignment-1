function [ output_args ] = ObsCheck( input_args )
%OBSCHECK Summary of this function goes here
%   Detailed explanation goes here

points = [100,150,100;100,300,200;300,100,300];
corners = [];
lines = [];
path = [];
lineofsight = [];
tol = 1e-1;
[n,c] = sizeof(points);
for i = 1 : n
    index = i*4;
    x1 = points(1, i)+16+tol;
    x2 = points(1, i)-16-tol;
    y1 = points(2, i)+16+tol;
    y2 = points(2, i)-16-tol;
    %POINTS NO LONGER AT 0 OR 1
    
    %append to list in right order    
    corners(1, index)=(x1);
    corners(1, inder+1)=(x1+1e-1);
    corners(1, inder+2)=(x2);
    corners(1, inder+3)=(x2+1e-6);
    corners(2, index)=(y1);
    corners(2, index+1)=(y2);
    corners(2, index+2)=(y2);
    corners(2, index+3)=(y1);
    %CORNERS NO LONGER AT 0 OR 1
end

for i = 1:n
    for j = 1:4
        index = i*4+j;
        if j <3
            x1 = corners(1, index);
            x2 = corners(1, index+1);
            y1 = corners(2, index);
            y2 = corners(2, index+1);
            m = (y2-y1)/(x2-x1);
            c = y1-m*x1;
            lines[0][index]=(m)
            lines[1][index]=(c)
        else
            x1 = corners[0][index]
            x2 = corners[0][index-3]
            y1 = corners[1][index]
            y2 = corners[1][index-3]
            m = (y2-y1)/(x2-x1);
            c = y1-m*x1;
            lines(1, index)=m;
            lines(2, index)=c:
%LINES NO LONGER AT 0 OR 1
        end
    end
end


[c,r]= sizeof(corners);
%CHECK THIS

for i = 1:c-4
    x1 = corners(1, i);
    x2 = corners(1, i+4);
    y1 = corners(2, i);
    y2 = corners(2, i+4);
    if (x2-x1) == 0
        x2 = x2 + 1e-1;
    end
    m = (y2-y1)/(x2-x1);
    c = y1-m*x1;
    lineofsight(1, i)=m;
    lineofsight(2, i)=c;
    %LINE OF SIGHT NO LONGER AT 0 or 1
end

hits = [];  
tol = 1e-1; 
traj = zeros(n-1,1);
count = 0;

for path =1:n-1
    for eye =1:4
        path_eye = path*4+eye;
        %line we're checking            
        m1 = lineofsight(1, path_eye);
        c1 = lineofsight(2, path_eye);
        for obstacle = 1:n
            if (obstacle <path) || (obstacle>(path+1))
                x1 = corners(1, obstacle*4);
                x2 = corners(1, obstacle*4+2);
                y1 = corners(2, obstacle*4);
                y2 = corners(2, obstacle*4+2);
                z = points(3, obstacle);
                if x1<x2
                    xmax = x2;
                    xmin = x1;
                else
                    xmax = x1;
                    xmin = x2;
                end
                if y1<y2
                    ymax = y2;
                    ymin = y1;
                else
                    ymax = y1;
                    ymin = y2;
                end
                for corner = 1:4
                    index = obstacle*4+corner;
                    m2 = lines(1, index);
                    c2 = lines(2, index);
                    if (m1 ~= 0) || (m2 ~= 0)                    
                        xsol = (c2-c1)/(m1-m2);
                        ysol = m1*xsol + c1;
                        if (xmin-tol<=xsol<=xmax+tol) && (ymin-tol<=ysol<=ymax+tol)
                            x1 = points(1, path);
                            x2 = points(1, path+1);
                            y1 = points(2, path);
                            y2 = points(2, path+1);
                            z1 = points(3, path);
                            z2 = points(3, path+1);
                            if z1<z2
                                zmin = z1;
                            else
                                zmin = z2;
                            end
                            if x1<x2
                                xmax = x2;
                                xmin = x1;
                            else
                                xmax = x1;
                                xmin = x2;
                            end
                            if y1<y2
                                ymax = y2;
                                ymin = y1;
                            else
                                ymax = y1;
                                ymin = y2;
                            end
                            if (xmin-tol<=xsol<=xmax+tol) && (ymin-tol<=ysol<=ymax+tol)    
                                count = count+1;
                                dsip('Hit %s, %d, %d, %d', path,obstacle,xsol,ysol,z);
                                hits(1, count)=xsol;
                                hits(2, count)=ysol;
                                hits(3, count)=z;
                                if (z > zmin) && (z> traj(path, 1))
                                    traj(path, 0)=z;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

end

