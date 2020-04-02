function [ img_Mout ]  =  LinearContrastStretching( img_Min )
    f = img_Min;
    f1 = im2double(f); % Cast to double.
    channelCount = size(f1 ,3);
    %f3 = zeros(size(f1,1) ,size(f1, 2), size(f1, 3));
    for i = 1:channelCount
        fmatrix = f1(:,:,i);
        min1 = min(min(fmatrix));
        max1 = max(max(fmatrix));
        f2 = round( ((fmatrix - min1)*255)/(max1- min1));
        f3(:,:,i) = uint8(255 * mat2gray(f2));
    end
    img_Mout = f3;