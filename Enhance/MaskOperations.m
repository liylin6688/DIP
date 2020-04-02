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
%% Smoothing operations ����ͻ��ͼ��Ŀ�����򡢵�Ƶ�ɷ֡����ɲ��ֻ�����ͼ�������͸��Ÿ�Ƶ�ɷֵ�ͼ��������Ŀ����ʹͼ������ƽ�����䣬��Сͻ���ݶȣ�����ͼ������
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
%% Median Filtering ��ֵ�˲��ǻ�������ͳ�����۵�һ������Ч���������ķ������źŴ���������ֵ�˲��Ļ���ԭ���ǰ�����ͼ�������������һ���ֵ�øõ��һ�������и���ֵ����ֵ���棬����Χ������ֵ�ӽ�����ʵֵ���Ӷ����������������㡣
img_recover = medfilt2(img_noise);
subplot(disp_r, disp_c, 6);
imshow(img_recover);
title('Median Filtering');
%% sharpening operations ͼ����(image sharpening)�ǲ���ͼ�����������ǿͼ��ı�Ե���Ҷ�����Ĳ��֣�ʹͼ������������Ϊ�ռ������Ƶ�������ࡣͼ������Ϊ��ͻ��ͼ���ϵ���ı�Ե����������ĳЩ����Ŀ��Ҫ�ص������������˲���������˵����Ե����Χ��Ԫ֮��ķ�����Ҳ����Ϊ��Ե��ǿ��
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
filter1 = fspecial('gaussian', 3, 0.5);%��˹�˲���
gaussian = imfilter(img_orig, filter1); 
subplot(disp_r, disp_c, 9);
imshow(gaussian);
title('gaussian');

filter2 = fspecial('disk', 3);%Բ���˲���
disk = imfilter(img_orig, filter2); 
subplot(disp_r, disp_c, 10);
imshow(disk);
title('disk');

filter3 = fspecial('log', 3, 0.5);%������˹��˹�˲���
log = imfilter(img_orig, filter3); 
log = img_orig + log;
subplot(disp_r, disp_c, 11);
imshow(log);
title('log');

filter4 = fspecial('prewitt');%��Ե��ǿ
prewitt = imfilter(img_orig, filter4); 
prewitt = img_orig + prewitt;
subplot(disp_r, disp_c, 12);
imshow(prewitt);
title('prewitt');

filter5 = fspecial('motion', 9, 0);%�˶�ģ��
motion = imfilter(img_orig, filter5); 
subplot(disp_r, disp_c, 13);
imshow(motion);
title('motion');

filter6 = fspecial('unsharp', 0.5);%�Աȶ���ǿ
unsharp = imfilter(img_orig, filter6); 
subplot(disp_r, disp_c, 14);
imshow(unsharp);
title('unsharp');


