function [ img_Mout ]  =  HE( img_Min )
    I = img_Min;
    I1 = I(:,:,1);%提取R通道
    I2 = I(:,:,2);%提取G通道
    I3 = I(:,:,3);%提取B通道
    I1 = test(I1);%直方图均衡化
    I2 = test(I2);%直方图均衡化
    I3 = test(I3);%直方图均衡化
    img_Mout = cat(3,I1,I2,I3); %合并
end

function m = test(I)
    J = I;
    [w,l] = size(I);%确定矩阵大小
    area = w * l;
    a = zeros(1,256);
    b = zeros(1,256);
    for i = 1:w %记录每个灰度的个数
         for j = 1:l
             m = I(i,j) + 1;
             a(1,m) = a(1,m) + 1;
         end
    end
    for i = 1:256 %均衡化
         sum = 0;
         for j = 1:i
            sum = sum + a(1,j);
         end
         b(1,i) = sum * 255/area;
    end
    for i = 1:w %用均衡化后的数据代替原位置的数据
         for j = 1:l
            m = J(i,j) + 1;
            J(i,j) = b(1,m);
         end
    end
    m = J;
end

