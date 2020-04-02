function [ output ] = pan( img, dx, dy )
    [width, height] = size(img);
    output = zeros(width, height) + 255;
    for i = 1:width
        for j = 1:height
            cord = [1,0,dx;0,1,dy;0,0,1]*[i;j;1];
            x = cord(1);
            y = cord(2);
            if (x <= width) & (y <= height) & (x >= 1) & (y >= 1)
                output(x,y) = img(i,j);
            end
        end
    end    
    output = uint8(output);
end

