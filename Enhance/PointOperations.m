img_name = 'gray.png';
img_orig = imread(img_name);
disp_r = 2;
disp_c = 4;
subplot(disp_r, disp_c, 1);
imshow(img_orig);
title('Origin');
%% Image Negative 图像反转（Image Negative）在许多应用中都很有用，例如显示医学图像和用单色正片拍摄屏幕，其想法是将产生的负片用作投影片。
L = 255;
img_negative = L - img_orig; 
subplot(disp_r, disp_c, 2);
imshow(img_negative);
title('Negative');
%% Contrast Stretching 对比度拉伸（Contrast Stretching）背后的想法是增加图像处理中灰度的动态范围。
imgContrastStretch=imadjust(img_orig, [0.1 0.2], [0.1 0.5 ]);
subplot(disp_r, disp_c, 3);
imshow(imgContrastStretch);
title('ContrastStretch');
%% Compression of dynamic range 动态范围压缩 [0,255]压缩到[0,150]
c = 150 / log(1 + 255);
img_size = size(img_orig);
for i = 1:img_size(1)
    for j = 1:img_size(2)
        s(i, j) = c * log(double(1 + img_orig(i, j)));
    end
end
subplot(disp_r, disp_c, 4);
imshow(uint8(s));
title('Compression');
%% Grey level slicing 灰度切片(Grey level slicing)相当于带通滤波的空间域。灰度切片函数既可以强调一组灰度值而减少其他所有灰度值，也可以强调一组灰度值而不考虑其他灰度值。例如对图像中灰度值为[100, 180]的区域进行强调，对其他区域进行抑制。
img_orig2 = img_orig;
for i = 1:img_size(1)
    for j = 1:img_size(2)
        if img_orig(i, j) > 100 && img_orig(i, j) < 180
            img_orig2(i, j) = 250;
        else
            img_orig2(i, j) = 25;
        end
    end
end
subplot(disp_r, disp_c, 5);
imshow(img_orig2);
title('Gray level slicing');
%% Image Subtraction图像相减是从另一个图像中减去一个像素或整个图像的数字数值的过程。这主要是出于两个原因——调平图像的不均匀部分和检测两幅图像之间的变化。一个常用的方法是从场景中减去背景光照的变化，以便更容易地分析其中的前景对象.例如在捕获过程中光照很差的文本，以便在整个图像中有很强的光照梯度，如果我们希望将前景文本从背景页面中分离出来，也许我们不能调整光照，但是我们可以在场景中放入不同的东西。
img_sub = uint8(img_orig - imgContrastStretch);
subplot(disp_r, disp_c, 6);
imshow(img_sub);
title('Subtraction');
%% Image Averaging 图像平均是通过找到K个图像的平均值来获得的。应用于图像去噪。
img_noise1 = imnoise(img_orig, 'gaussian', 0, 0.01);
img_noise2 = imnoise(img_orig, 'gaussian', 0, 0.01);
img_noise3 = imnoise(img_orig, 'gaussian', 0, 0.01);
img_noise4 = imnoise(img_orig, 'gaussian', 0, 0.01);
img_noise5 = imnoise(img_orig, 'gaussian', 0, 0.01);
img_average = imlincomb(0.2,img_noise1, 0.2,img_noise2, 0.2,img_noise3, 0.2,img_noise4, 0.2,img_noise5);
subplot(disp_r, disp_c, 7);
imshow(img_noise1);
title('noise');
subplot(disp_r, disp_c, 8);
imshow(img_average);
title('average');
