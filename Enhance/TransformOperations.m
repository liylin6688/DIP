%% 将图片从空间域转到频域，在频域进行操作 快速傅里叶变换转换（Fast Fourier Transform, 简称fft）到频域的频谱 通过快速傅里叶反变换(ifft)得到滤波的图像
img_name = 'gray.png';
img_orig = imread(img_name);
disp_r = 2;
disp_c = 4;
subplot(disp_r, disp_c, 1);
imshow(img_orig);
title('Origin');

img_noise=imnoise(img_orig, 'salt & pepper', 0.02);
subplot(disp_r, disp_c, 2);
imshow(img_noise);
title('salt & pepper');
%% Low pass filtering  频谱进行理想低通滤波，低于截止频率 的通过，高于的抑制
dl = 50; %阈值
type = 'ideal';%滤波器类型 理想滤波器、巴特沃斯滤波器、高斯滤波器
n = 1;%是巴特沃斯滤波器的次数
img_f = fftshift(fft2(double(img_noise)));%将变换的原点移至频率矩形的中心 
[m n]=size(img_f);
m_mid=fix(m/2); 
n_mid=fix(n/2); 
img_lpf=zeros(m,n);
for i = 1:m
    for j = 1:n
        d = sqrt((i-m_mid)^2+(j-n_mid)^2);
        switch type
            case 'ideal'
                if d < dl
                    h(i,j) = 1;
                else
                    h(i,j) = 0;
                end
            case 'btw'
                h=1./(1+(d./dl).^(2*n));
            case 'gaussian'
                h=exp(-(d.^2)./(2*(dl^2)));
            otherwise
                error('unknown filter type')
        end
        img_lpf(i,j)=h(i,j)*img_f(i,j);
    end
end
img_lpf = ifftshift(img_lpf);
img_lpf=uint8(real(ifft2(img_lpf))); %取实数部分
subplot(disp_r, disp_c, 3);
imshow(img_lpf);
title('LPF');
%% High pass filtering  高通滤波与低通滤波类似，区别在于低于截止频率的抑制，高于截止频率的通过。
dh = 30; 
img_hpf=zeros(m,n);
for i = 1:m
    for j = 1:n
        d = sqrt((i-m_mid)^2+(j-n_mid)^2);
        if d >= dh
            h(i,j) = 1;
        else
            h(i,j) = 0;
        end
        img_hpf(i,j)=h(i,j)*img_f(i,j);
    end
end
img_hpf = ifftshift(img_hpf);
img_hpf=uint8(real(ifft2(img_hpf))); %取实数部分
subplot(disp_r, disp_c, 4);
imshow(img_hpf);
title('HPF');
%% Band pass filtering 带通滤波有两个截止频率dl ,dh ，其中 是较低的频率， 是较高的频率
dbl=0; 
dbh=200; 
img_bpf=zeros(m,n);
for i = 1:m
    for j = 1:n
        d = sqrt((i-m_mid)^2+(j-n_mid)^2);
        if d >= dbl && d <= dbh
            h(i,j) = 1;
        else
            h(i,j) = 0;
        end
        img_bpf(i,j)=h(i,j)*img_f(i,j);
    end
end
img_bpf = ifftshift(img_bpf);
img_bpf=uint8(real(ifft2(img_bpf))); %取实数部分
subplot(disp_r, disp_c, 5);
imshow(img_bpf);
title('BPF');
%% Homomorphic filtering 同态滤波是把频率过滤和灰度变换结合起来的一种图像处理方法，它依靠图像的照度/ 反射率模型作为频域处理的基础，利用压缩亮度范围和增强对比度来改善图像的质量。使用这种方法可以使图像处理符合人眼对于亮度响应的非线性特性，避免了直接对图像进行傅立叶变换处理的失真。
% 同态滤波的基本原理是：将像元灰度值看作是照度和反射率两个组份的产物。由于照度相对变化很小，可以看作是图像的低频成份，而反射率则是高频成份。通过分别处理照度和反射率对灰度值的影响，达到揭示阴影区细节特征的目的。
rL=0.5;
rH=4.7;
c=2;
H0=10;
log_img=log(double(img_noise)+1);
FI=fft2(log_img);
n1=floor(m/2);
n2=floor(n/2);
for i = 1:m
    for j = 1:n
        D(i,j)=((i-n1).^2+(j-n2).^2);
        H(i,j)=(rH-rL).*(exp(c*(-D(i,j)./(d0^2))))+rL;%高斯同态滤波
    end
end
G = H.*FI;
final=ifft2(G);
final=real(exp(final));
subplot(disp_r, disp_c, 6);
imshow(final);
title('HF');


