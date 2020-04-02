function [ res ] = rotate( init, alfa )
    [R, C] = size(init); 
    res = zeros( R,  C) + 255; 
    alfa = alfa * 3.1415926 / 180.0; 
    tras = [cos(alfa) -sin(alfa) 0; sin(alfa) cos(alfa) 0; 0 0 1];
    for i = 1 : R
        for j = 1 : C
            temp = [i; j; 1];
            temp = tras * temp;
            x = uint16(temp(1, 1));
            y = uint16(temp(2, 1));
            if (x <= R) & (y <= C) & (x >= 1) & (y >= 1)
                res(i, j) = init(x, y);
            end
        end
    end;
    res = uint8(res);  
end

