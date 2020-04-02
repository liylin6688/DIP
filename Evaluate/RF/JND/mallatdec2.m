function Y=mallatdec2(X,wname,level)
%输入:X????? 载入的二维图像像数值;
%???? level? 小波分解次(级)数设定值(如果设定值超过最高可分解次数,按最高分解次数分解)
%????? wname? 小波名字wavelet name
%输出：Y???? 多极小波分解后的小波系数矩阵
%wfilters：小波滤波器

[h,g]=wfilters(wname,'d');    %h,g分别为分解的低通和高通滤波器
X=double(X);
t=1;
hh=size(X,2);
Y=zeros(1,hh);
while t<=level   %循环
    %先进行行小波变换
    for row=1:hh
        Y(row,1:hh)=mdec1(X(row,1:hh),h,g) ;
    end
    %再进行列小波变换
    for col=1:hh
        temp=mdec1( Y(1:hh,col)',h,g); %Y(1:hh,col)为矩阵中的一列，转置后为行向量，得到的结果temp也是行向量
        Y(1:hh,col)=temp';             %将行向量转置为列向量存储在Y中
    end
    t=t+1;                             %循环次数加1，大于level，循环终止
    hh=hh/2;                           %分解的矩阵的大小为原来的四分之一
    X=Y;                               %将Y值赋给X等待下一次分解                     
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
