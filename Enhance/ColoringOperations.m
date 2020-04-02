%% False coloring
% 将彩色图像转换为灰度图像是一个不可逆的过程，灰度图像也不可能变换为原来的彩色图像。而某些场合需要将灰度图像转变为彩色图像；伪彩色处理主要是把黑白的灰度图像或者多波段图像转换为彩色图像的技术过程。其目的是提高图像内容的可辨识度。
% 伪彩色图像的含义是，每个像素的颜色不是由每个基色分量的数值直接决定，而是把像素值当作彩色查找表(事先做好的)的表项入口地址，去查找一个显示图像时使用的R，G，B强度值，用查找出的R，G，B强度值产生的彩色称为伪彩色。
img_name = 'img.png';
source = imread(img_name);
gray = rgb2gray(source);
% FalseRGB = label2rgb(gray2ind(gray, 255),jet(255));
% subplot(131);imshow(source);title('原彩色')
% subplot(132);imshow(gray);title('灰度图')
% subplot(133);imshow(FalseRGB);title('伪彩色')

%% Full color processing
%要处理全彩色图像，则需要对彩色的每个通道分别处理，然后叠加在一起。下面以中值滤波为例，对彩色图像进行处理。
% img_name = 'img.png';
% source = imread(img_name);
% for i = 1:3
%     img_noise(:, :, i) = imnoise(source(:, :, i), 'salt & pepper', 0.02);
%     img_recover(:, :, i) = medfilt2(img_noise(:, :, i));
% end
% subplot(131);imshow(source);title('原图')
% subplot(132);imshow(img_noise);title('噪声图')
% subplot(133);imshow(img_recover);title('滤波图')

