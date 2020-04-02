


function y=mdec1(x,h,g)
%x 行数组
%h为低通滤波器
%g为高通滤波器
%输出： y 进行一级小波分解后的系数
lenx=size(x,2);                 %求行的长度
lenh=size(h,2);                 %求低通滤波器的长度
rh=h(end:-1:1);                 %rh是h的逆序  h0(n)=h(-n)
rrh=[zeros(1,(lenx-lenh)),rh];  %rrg在rg前插入(lenx-lenh))个零
rrh=circshift(rrh',1)';         %循环位移

rg=g(end:-1:1);                 %rg为高通滤波器的逆序g0(n)=g(-n)
rrg=[zeros(1,(lenx-lenh)),rg];  %rrg在rg前插入(lenx-lenh))个零
rrg=circshift(rrg',1)';         %循环位移

r1=dyaddown(ifft(fft(x).*fft(rrh,lenx)),1); %use para 1，下2奇采样
r2=dyaddown(ifft(fft(x).*fft(rrg,lenx)),1); %use para 1，下2奇采样
y=[r1,r2];                     %相加得到小波系数

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%内部子函数，对一行小波系数进行重构


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%二维小波重构函数


 

%%%%%%%%%%%%%%%%%%%%%%%%%%


