img_name = 'gray.png';
img_orig = imread(img_name);
disp_r = 2;
disp_c = 4;
subplot(disp_r, disp_c, 1);
imshow(img_orig);
title('Origin');
%% Image Negative ͼ��ת��Image Negative�������Ӧ���ж������ã�������ʾҽѧͼ����õ�ɫ��Ƭ������Ļ�����뷨�ǽ������ĸ�Ƭ����ͶӰƬ��
L = 255;
img_negative = L - img_orig; 
subplot(disp_r, disp_c, 2);
imshow(img_negative);
title('Negative');
%% Contrast Stretching �Աȶ����죨Contrast Stretching��������뷨������ͼ�����лҶȵĶ�̬��Χ��
imgContrastStretch=imadjust(img_orig, [0.1 0.2], [0.1 0.5 ]);
subplot(disp_r, disp_c, 3);
imshow(imgContrastStretch);
title('ContrastStretch');
%% Compression of dynamic range ��̬��Χѹ�� [0,255]ѹ����[0,150]
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
%% Grey level slicing �Ҷ���Ƭ(Grey level slicing)�൱�ڴ�ͨ�˲��Ŀռ��򡣻Ҷ���Ƭ�����ȿ���ǿ��һ��Ҷ�ֵ�������������лҶ�ֵ��Ҳ����ǿ��һ��Ҷ�ֵ�������������Ҷ�ֵ�������ͼ���лҶ�ֵΪ[100, 180]���������ǿ��������������������ơ�
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
%% Image Subtractionͼ������Ǵ���һ��ͼ���м�ȥһ�����ػ�����ͼ���������ֵ�Ĺ��̡�����Ҫ�ǳ�������ԭ�򡪡���ƽͼ��Ĳ����Ȳ��ֺͼ������ͼ��֮��ı仯��һ�����õķ����Ǵӳ����м�ȥ�������յı仯���Ա�����׵ط������е�ǰ������.�����ڲ�������й��պܲ���ı����Ա�������ͼ�����к�ǿ�Ĺ����ݶȣ��������ϣ����ǰ���ı��ӱ���ҳ���з��������Ҳ�����ǲ��ܵ������գ��������ǿ����ڳ����з��벻ͬ�Ķ�����
img_sub = uint8(img_orig - imgContrastStretch);
subplot(disp_r, disp_c, 6);
imshow(img_sub);
title('Subtraction');
%% Image Averaging ͼ��ƽ����ͨ���ҵ�K��ͼ���ƽ��ֵ����õġ�Ӧ����ͼ��ȥ�롣
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
