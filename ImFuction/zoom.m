function [ output ] = zoom( img,dx,dy )
    [width, height] = size(img);
    output = zeros(round(width*dx), round(height*dy));
    for i = 1:(width*dx)
        for j = 1:(height*dy)
            cord = [1/dx,0,0;0,1/dy,0;0,0,1]*[i;j;1];
            x = round(cord(1));
            y = round(cord(2));
            if (x <= width) & (y <= height) & (x >= 1) & (y >= 1)
                output(i,j) = img(x,y);
            end
        end
    end    
    output = uint8(output);
end
