clear
tic
I1 = imread('img1.jpg');
I2 = imread('img2.jpg');
[des1,loc1] = getFeatures(I1);
[des2,loc2] = getFeatures(I2);
matched = match(des1,des2);
drawFeatures(I1,loc1);
drawFeatures(I2,loc2);
drawMatched(matched,I1,I2,loc1,loc2);
toc