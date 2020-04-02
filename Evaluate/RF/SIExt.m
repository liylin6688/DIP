% ref   大家都在发大家都在发https://blog.csdn.net/qq_36614557/article/details/86763655
function[siext]= SIExt(I1,I2) %I1复原图像 I2 参考图像
    I1=double(rgb2gray(I1));
    I2=double(rgb2gray(I2));
    if size(I1)~=size(I2)
        siext=-Inf;
        return 
    end
    [I1_l,I1_s,I1_n]=getSI(I1);
    [I2_l,I2_s,I2_n]=getSI(I2);
    [sl,map]=ssim(I1_l,I2_l);
    [ss,map]=ssim(I1_s,I2_s);
    [sn,map]=ssim(I1_n,I2_n);
    wl=0.1;%权值
    ws=0.8;
    wn=0.1;
siext=wl*sl+ws*ss+wn*sn;
end

function [I_l,I_s,I_n]=getSI(I)%返回对DCT解构后再进行IDCT的图像
    [m,n]=size(I);
    I_dct=dct2(I,[m n]);
    D=zeros(m,n);%D（i,j） ：点(i,j) 到左上角距离
    A=zeros(m,n);%A(i,j)为I_dct(i,j)的幅值(max-min)
    map=zeros(m,n);%map： I_dct(i,j)对应的分类结果 0=低频系数 100-结构信息系数 200-次要信息系数
    for i=1:m
        for j=1:n %计算D\A
            D(i,j)=sqrt((i-1)^2+(j-1)^2);
            A(i,j)=max(max(I_dct(1:i,1:j)))-min(min(I_dct(1:i,1:j)));             
        end
    end
    tf=mean(mean(D));%频率阈值
    te=mean(mean(A));%能量阈值
    for i=1:m
        for j=1:n
            if(D(i,j)<tf)
                map(i,j)=0;
            else
                if A(i,j)>te
                    map(i,j)=100;
                end
                if A(i,j)<te
                    map(i,j)=200;
                end
            end
        end
    end
    I_dct_l=zeros(m,n);
    I_dct_s=zeros(m,n);
    I_dct_n=zeros(m,n);
    for i=1:m
        for j=1:n
            if (map(i,j)==0)
                I_dct_l(i,j)=I_dct(i,j);
            elseif (map(i,j)==100)
                I_dct_s(i,j)=I_dct(i,j);
            else
                I_dct_n(i,j)=I_dct(i,j);
            end
        end
    end
    I_l=idct2(I_dct_l);
    I_s=idct2(I_dct_s);
    I_n=idct2(I_dct_n);
end
