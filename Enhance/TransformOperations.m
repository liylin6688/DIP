%% ��ͼƬ�ӿռ���ת��Ƶ����Ƶ����в��� ���ٸ���Ҷ�任ת����Fast Fourier Transform, ���fft����Ƶ���Ƶ�� ͨ�����ٸ���Ҷ���任(ifft)�õ��˲���ͼ��
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
%% Low pass filtering  Ƶ�׽��������ͨ�˲������ڽ�ֹƵ�� ��ͨ�������ڵ�����
dl = 50; %��ֵ
type = 'ideal';%�˲������� �����˲�����������˹�˲�������˹�˲���
n = 1;%�ǰ�����˹�˲����Ĵ���
img_f = fftshift(fft2(double(img_noise)));%���任��ԭ������Ƶ�ʾ��ε����� 
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
img_lpf=uint8(real(ifft2(img_lpf))); %ȡʵ������
subplot(disp_r, disp_c, 3);
imshow(img_lpf);
title('LPF');
%% High pass filtering  ��ͨ�˲����ͨ�˲����ƣ��������ڵ��ڽ�ֹƵ�ʵ����ƣ����ڽ�ֹƵ�ʵ�ͨ����
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
img_hpf=uint8(real(ifft2(img_hpf))); %ȡʵ������
subplot(disp_r, disp_c, 4);
imshow(img_hpf);
title('HPF');
%% Band pass filtering ��ͨ�˲���������ֹƵ��dl ,dh ������ �ǽϵ͵�Ƶ�ʣ� �ǽϸߵ�Ƶ��
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
img_bpf=uint8(real(ifft2(img_bpf))); %ȡʵ������
subplot(disp_r, disp_c, 5);
imshow(img_bpf);
title('BPF');
%% Homomorphic filtering ̬ͬ�˲��ǰ�Ƶ�ʹ��˺ͻҶȱ任���������һ��ͼ��������������ͼ����ն�/ ������ģ����ΪƵ����Ļ���������ѹ�����ȷ�Χ����ǿ�Աȶ�������ͼ���������ʹ�����ַ�������ʹͼ����������۶���������Ӧ�ķ��������ԣ�������ֱ�Ӷ�ͼ����и���Ҷ�任�����ʧ�档
% ̬ͬ�˲��Ļ���ԭ���ǣ�����Ԫ�Ҷ�ֵ�������նȺͷ�����������ݵĲ�������ն���Ա仯��С�����Կ�����ͼ��ĵ�Ƶ�ɷݣ������������Ǹ�Ƶ�ɷݡ�ͨ���ֱ����նȺͷ����ʶԻҶ�ֵ��Ӱ�죬�ﵽ��ʾ��Ӱ��ϸ��������Ŀ�ġ�
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
        H(i,j)=(rH-rL).*(exp(c*(-D(i,j)./(d0^2))))+rL;%��˹̬ͬ�˲�
    end
end
G = H.*FI;
final=ifft2(G);
final=real(exp(final));
subplot(disp_r, disp_c, 6);
imshow(final);
title('HF');


