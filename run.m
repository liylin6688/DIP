close all;clc;clear


img_name = 'gray.png';
img_orig = imread(img_name);
img_noise=imnoise(img_orig, 'salt & pepper', 0.02);
img_recover = medfilt2(img_noise);
subplot(131);imshow(img_orig);title('ԭʼͼ��');
subplot(132);imshow(img_noise);title('����ͼ��');
subplot(133);imshow(img_recover);title('�˲���ͼ��');


%%%%%%%%%%%%%%%%%%��ֵ�˲�
% I=im2double(I);
% J1=ordfilt2(I, 1, true(5));%��Сֵ��� 5x5
% J2=ordfilt2(I, 25, true(5));%���ֵ��� 5x5  ����
% figure;
% subplot(131);
% imshow(I);
% subplot(132);
% imshow(J1);
% subplot(133);



% img_name = 'gray.png';
% img_orig = imread(img_name);
% img_noise=imnoise(img_orig, 'salt & pepper', 0.02);
% H1 = fspecial('gaussian', 3, 1);
% img_smooth1 = imfilter(img_noise, H1); 
% H2 = fspecial('gaussian', 5, 1);
% img_smooth2 = imfilter(img_noise, H2); 
% H3 = fspecial('gaussian', 7, 1);
% img_smooth3 = imfilter(img_noise, H3); 
% H4 = fspecial('gaussian', 11, 1);
% img_smooth4 = imfilter(img_noise, H4 );
% subplot(231),imshow(img_orig),title('ԭʼͼ��')
% subplot(232),imshow(img_noise),title('����ͼ��')
% subplot(233);imshow(img_smooth1);title('3*3�˲���');
% subplot(234);imshow(img_smooth2);title('5*5�˲���')
% subplot(235),imshow(img_smooth3),title('7*7�˲���')
% subplot(236),imshow(img_smooth4),title('11*11�˲���')


% %%%%%%%%%%%%%%%%%%%%ֱ��ͼƥ��
% r=127;x=-r:r+1;
% sigma=20;
% y1=exp(-((x-80).^2)/(2*sigma^2));
% y2=exp(-((x+80).^2)/(2*sigma^2));
% y=y1+y2;y=y/sum(y);
% subplot(221),plot(y),title('����������ʽ')
% G=[];
% for i=1:256
%    G=[G sum(y(1:i))]; 
% end
% img=imread('gray.png');
% [m n]=size(img);
% hist=imhist(img);
% p=hist/(m*n);           
% subplot(222),plot(p),title('ֱ��ͼƥ��任')
% s=[];
% for i=1:256
%     s=[s sum(p(1:i))];
% end
% for i=1:256
%     tmp{i}=G-s(i);tmp{i}=abs(tmp{i});
%     [a index(i)]=min(tmp{i});
% end
% imgn=zeros(m,n);
% for i=1:m
%    for j=1:n
%       imgn(i,j)=index(img(i,j)+1)-1;  
%    end
% end
% imgn=uint8(imgn);
% subplot(223),imshow(imgn),title('ƥ����ͼ��')
% subplot(224),imhist(imgn),title('ƥ����ͼ��ֱ��ͼ')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ֱ��ͼ���⻯
% J=histeq(I); 
% subplot(221)
% imshow(uint8(I))
% title('ԭͼ')
% subplot(222)
% imshow(uint8(J))
% title('���⻯��')
% subplot(223)
% imhist(I,64)
% title('ԭͼ��ֱ��ͼ');
% subplot(224)
% imhist(J,64)
% title('���⻯���ֱ��ͼ');



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%ͼ��
% img1 = rgb2gray(img_orig);
% img2 = min(img1 + 100, 255);
% c = 150 / log(1 + 255);
% img_size = size(img_orig);
% for i = 1:img_size(1)
%     for j = 1:img_size(2)
%         s(i, j) = c * log(double(1 + img_orig(i, j)));
%     end
% end
% img3 = uint8(s);
% J = img1;I = img1;
% [w,l] = size(I);area = w * l;
% a = zeros(1,256);b = zeros(1,256);
% for i = 1:w %��¼ÿ���Ҷȵĸ���
%     for j = 1:l
%         m = I(i,j) + 1;
%         a(1,m) = a(1,m) + 1;
%     end
% end
% for i = 1:256 %���⻯
%     sum = 0;
%     for j = 1:i
%         sum = sum + a(1,j);
%     end
%     b(1,i) = sum * 255/area;
% end
% for i = 1:w %�þ��⻯������ݴ���ԭλ�õ�����
%     for j = 1:l
%         m = J(i,j) + 1;
%         J(i,j) = b(1,m);
%     end
% end
% img4 = J;
% subplot(241),imshow(img1),title('��ͼ��')
% subplot(242),imshow(img2),title('��ͼ��')
% subplot(243);imshow(img3);title('�͌��ն�ͼ��');
% subplot(244);imshow(img4);title('�ߌ��ն�ͼ��')
% subplot(245),imhist(img1),title('��ͼ��')
% subplot(246),imhist(img2),title('��ͼ��')
% subplot(247);imhist(img3);title('�͌��ն�ͼ��');
% subplot(248);imhist(img4);title('�ߌ��ն�ͼ��')



% %%%%%%%%%%%%%%%%%%%%%%�Ҷ��и�
% img_size = size(img_orig);
% img_orig2 = img_orig;
% for i = 1:img_size(1)
%     for j = 1:img_size(2)
%         if img_orig(i, j) > 10 && img_orig(i, j) < 50
%             img_orig2(i, j) = 250;
%         else
%             img_orig2(i, j) = 25;
%         end
%     end
% end
% subplot(221),imshow(img_orig),title('ԭʼͼ��')
% subplot(222),imshow(img_orig2),title('�Ҷ��и�')
% subplot(223);imhist(img_orig);title('ԭʼͼ��');
% subplot(224);imhist(img_orig2);title('�Ҷ��и�')


% %%%%%%%%%%%%%%%�ֶ����Ա任
% [M,N]=size(I);
% I=im2double(I);
% out=zeros(M,N);
% X1=0.3;Y1=0.15;X2=0.7;Y2=0.85;
% subplot(231);
% x1=0:0.001:X1;y1=Y1/X1*x1;
% plot(x1,y1);grid on;title('�ֶ����Ժ���');hold on
% x2=X1:0.001:X2;
% y2=(Y2-Y1)/(X2-X1)*(x2-X1)+Y1;
% plot(x2,y2);hold on
% x3=X2:0.001:1;
% y3=(Y2-1)/(X2-1)*(x3-X2)+Y2;
% plot(x3,y3);hold on
% x4=0:0.001:1;   
% y4=x4;
% plot(x4,y4);hold on
% for i=1:M
%     for j=1:N
%         if I(i,j)<X1
%             out(i,j)=Y1*I(i,j)/X1;
%         elseif I(i,j)>X2
%             out(i,j)=(I(i,j)-X2)*(1-Y2)/(1-X2)+Y2;
%         else
%             out(i,j)=(I(i,j)-X1)*(Y2-Y1)/(X2-X1)+Y1;
%         end
%     end
% end
% subplot(232),imshow(I),title('ԭʼͼ��')
% subplot(233),imshow(out),title('�ֶ����Ա任')
% subplot(235);imhist(I);title('ԭʼͼ��');
% subplot(236);imhist(out);title('�ֶ����Ա任')

%%%%%%%%%%%%%%٤��任
% img2 = gammaCorrection(img1, 1, 0.5);
% img3 = gammaCorrection(img1, 1, 0.1);
% img4 = gammaCorrection(img1, 1, 5);
% subplot(221),imshow(img1),title('ԭʼͼ��')
% subplot(222),imshow(img2),title('gamma=0.5')
% subplot(223),imshow(img3),title('gamma=0.1')
% subplot(224),imshow(img4),title('gamma=5')

%%%%%%%%%%%%%%%%%%�����任
% c = 150 / log(1 + 255);
% img_size = size(img_orig);
% for i = 1:img_size(1)
%     for j = 1:img_size(2)
%         s(i, j) = c * log(double(1 + img_orig(i, j)));
%     end
% end
% s = uint8(s);
% subplot(121),imshow(img1),title('ԭʼͼ��')
% subplot(122),imshow(s),title('�����任')

%%%%%%%%%%%%%%%%%%%%%%%%���任
% L = 255;
% img2 = L - img1; 
% subplot(121),imshow(img1),title('ԭʼͼ��')
% subplot(122),imshow(img2),title('���任ͼ��')

% %%%%%%%%%%%%%%%%%��ת
% img2 = rotate(img1,15);
% img3 = rotate(img1,-15);
% subplot(311),imshow(img1),title('ԭʼͼ��')
% subplot(312),imshow(img2),title('��ת15��')
% subplot(313),imshow(img3),title('��ת-15��')



%%%%%%%%%%%%%%%%%%%%%%%����
% [R, C] = size(img1);
% res = zeros(R, C);
% %��y����ת
% for i = 1 : R
%     for j = 1 : C
%         x = i;
%         y = C - j + 1;
%         res(x, y) = img1(i, j);
%     end
% end
% img2 = uint8(res);
% %��x����ת
% for i = 1 : R
%     for j = 1 : C
%         x = R - i + 1;
%         y = j;
%         res(x, y) = img1(i, j);
%     end
% end
% img3 = uint8(res);
% %��ԭ����ת
% for i = 1 : R
%     for j = 1 : C
%         x = R - i + 1;
%         y = C - j + 1;
%         res(x, y) = img1(i, j);
%     end
% end
% img4 = uint8(res);
% subplot(221),imshow(img1),title('ԭʼͼ��')
% subplot(222),imshow(img2),title('��y����ת')
% subplot(223),imshow(img3),title('��x����ת')
% subplot(224),imshow(img4),title('��ԭ����ת')


%%%%%%%%%%%%%%%%%����
% img2 = zoom(img1,0.5,0.5);
% img3 = zoom(img1,0.25,0.25);
% img4 = zoom(img1,0.2,0.2);
% img5 = zoom(img1,0.1,0.1);
% img6 = zoom(img1,2,2);
% img7 = zoom(img1,2,1);
% img8 = zoom(img1,1,2);
% subplot(421),imshow(img1),title('ԭʼͼ��')
% subplot(422),imshow(img2),title('����4��')
% subplot(423),imshow(img3),title('����16��')
% subplot(424),imshow(img4),title('����25��')
% subplot(425),imshow(img5),title('����100��')
% subplot(426),imshow(img6),title('�Ŵ�4��')
% subplot(427),imshow(img7),title('x�������2��')
% subplot(428),imshow(img8),title('y�������2��')


%%%%%%%%%%%%%%%%%%%%ƽ��ͼ��
% img2 = pan(img1,100,100);
% subplot(211),imshow(img1),title('ԭʼͼ��')
% subplot(212),imshow(img2),title('ƽ��ͼ��')

%%%%%%%%%%%�Աȶ�����
% a = min(min(img1));
% b = max(max(img1));
% c = a - 10; 
% d = b - 10;
% img2 = (d - c) / (b - a) * (img1 - a) + c;
% subplot(221),imshow(img2),title('�ԱȶȲ���')
% c = a - 10; 
% d = b + 10;
% img3 = (d - c) / (b - a) * (img1 - a) + c;
% subplot(222),imshow(img3),title('�Աȶ�����')
% c = a + 10; 
% d = b - 10;
% img4 = (d - c) / (b - a) * (img1 - a) + c;
% subplot(223),imshow(img4),title('�Աȶȼ�С')
% img5 = (c - d) / (b - a) * (img1 - a) + d;
% subplot(224),imshow(img5),title('��ɫ')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��������
% img2 = min(img1 + 100, 255);
% img3 = max(img1 - 100, 0);
% subplot(131),imshow(img1),title('ԭʼͼ��')
% subplot(132),imshow(img2),title('��������')
% subplot(133),imshow(img3),title('���Ƚ���')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����%
% t2=histeq(t1,256);
% t3=histeq(t1,128);
% t4=histeq(t1,64);
% t5=histeq(t1,32);
% t6=histeq(t1,16);
% t7=histeq(t1,8);
% t8=histeq(t1,4);
% t9=histeq(t1,2);
% subplot(241),imshow(t2),title('������Ϊ256')
% subplot(242),imshow(t3),title('������Ϊ128')
% subplot(243),imshow(t4),title('������Ϊ64')
% subplot(244),imshow(t5),title('������Ϊ32')
% subplot(245),imshow(t6),title('������Ϊ16')
% subplot(246),imshow(t7),title('������Ϊ8')
% subplot(247),imshow(t8),title('������Ϊ4')
% subplot(248),imshow(t9),title('������Ϊ2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����
% img1 = imread(img_name);
% img2 = downSample(img1,4);
% img3 = downSample(img1,16);
% img4 = downSample(img1,36);
% img5 = downSample(img1,64);
% img6 = downSample(img1,100);
% subplot(321);imshow(img1);title('ԭͼ')
% subplot(322);imshow(img2);title('4���²���')
% subplot(323);imshow(img3);title('16���²���')
% subplot(324);imshow(img4);title('36���²���')
% subplot(325);imshow(img5);title('64���²���')
% subplot(326);imshow(img6);title('100���²���')




