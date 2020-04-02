img_name = 'gray.png';
img_orig = imread(img_name);
disp_r = 3;
disp_c = 5;
subplot(disp_r, disp_c, 1);
imshow(img_orig);
title('Origin');

img_noise=imnoise(img_orig, 'salt & pepper', 0.02);
subplot(disp_r, disp_c, 2);
imshow(img_noise);
title('salt & pepper');
%% Smoothing operations 用于突出图像的宽大区域、低频成分、主干部分或抑制图像噪声和干扰高频成分的图像处理方法，目的是使图像亮度平缓渐变，减小突变梯度，改善图像质量
H1 = fspecial('average', 3);
img_smooth1 = imfilter(img_noise, H1); 
H2 = fspecial('average', 7);
img_smooth2 = imfilter(img_noise, H2); 
H3 = fspecial('average', 11);
img_smooth3 = imfilter(img_noise, H3 );
subplot(disp_r, disp_c, 3);
imshow(img_smooth1);
title('Smoothing3');
subplot(disp_r, disp_c, 4);
imshow(img_smooth2);
title('Smoothing7');
subplot(disp_r, disp_c, 5);
imshow(img_smooth3);
title('Smoothing11');
%% Median Filtering 中值滤波是基于排序统计理论的一种能有效抑制噪声的非线性信号处理技术，中值滤波的基本原理是把数字图像或数字序列中一点的值用该点的一个邻域中各点值的中值代替，让周围的像素值接近的真实值，从而消除孤立的噪声点。
img_recover = medfilt2(img_noise);
subplot(disp_r, disp_c, 6);
imshow(img_recover);
title('Median Filtering');
%% sharpening operations 图像锐化(image sharpening)是补偿图像的轮廓，增强图像的边缘及灰度跳变的部分，使图像变得清晰，分为空间域处理和频域处理两类。图像锐化是为了突出图像上地物的边缘、轮廓，或某些线性目标要素的特征。这种滤波方法提高了地物边缘与周围像元之间的反差，因此也被称为边缘增强。
H1 = fspecial('sobel');
edge1 = imfilter(img_orig, H1); 
sharpened1 = img_orig + edge1;
subplot(disp_r, disp_c, 7);
imshow(sharpened1);
title('sobel sharpening');

H2 = fspecial('laplacian');
edge2 = imfilter(img_orig, H2); 
sharpened2 = img_orig + edge2;
subplot(disp_r, disp_c, 8);
imshow(sharpened2);
title('laplacian sharpening');
%% other filter
filter1 = fspecial('gaussian', 3, 0.5);%高斯滤波器
gaussian = imfilter(img_orig, filter1); 
subplot(disp_r, disp_c, 9);
imshow(gaussian);
title('gaussian');

filter2 = fspecial('disk', 3);%圆盘滤波器
disk = imfilter(img_orig, filter2); 
subplot(disp_r, disp_c, 10);
imshow(disk);
title('disk');

filter3 = fspecial('log', 3, 0.5);%拉普拉斯高斯滤波器
log = imfilter(img_orig, filter3); 
log = img_orig + log;
subplot(disp_r, disp_c, 11);
imshow(log);
title('log');

filter4 = fspecial('prewitt');%边缘增强
prewitt = imfilter(img_orig, filter4); 
prewitt = img_orig + prewitt;
subplot(disp_r, disp_c, 12);
imshow(prewitt);
title('prewitt');

filter5 = fspecial('motion', 9, 0);%运动模糊
motion = imfilter(img_orig, filter5); 
subplot(disp_r, disp_c, 13);
imshow(motion);
title('motion');

filter6 = fspecial('unsharp', 0.5);%对比度增强
unsharp = imfilter(img_orig, filter6); 
subplot(disp_r, disp_c, 14);
imshow(unsharp);
title('unsharp');


