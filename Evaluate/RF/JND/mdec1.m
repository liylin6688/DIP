


function y=mdec1(x,h,g)
%x ������
%hΪ��ͨ�˲���
%gΪ��ͨ�˲���
%����� y ����һ��С���ֽ���ϵ��
lenx=size(x,2);                 %���еĳ���
lenh=size(h,2);                 %���ͨ�˲����ĳ���
rh=h(end:-1:1);                 %rh��h������  h0(n)=h(-n)
rrh=[zeros(1,(lenx-lenh)),rh];  %rrg��rgǰ����(lenx-lenh))����
rrh=circshift(rrh',1)';         %ѭ��λ��

rg=g(end:-1:1);                 %rgΪ��ͨ�˲���������g0(n)=g(-n)
rrg=[zeros(1,(lenx-lenh)),rg];  %rrg��rgǰ����(lenx-lenh))����
rrg=circshift(rrg',1)';         %ѭ��λ��

r1=dyaddown(ifft(fft(x).*fft(rrh,lenx)),1); %use para 1����2�����
r2=dyaddown(ifft(fft(x).*fft(rrg,lenx)),1); %use para 1����2�����
y=[r1,r2];                     %��ӵõ�С��ϵ��

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%�ڲ��Ӻ�������һ��С��ϵ�������ع�


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%��άС���ع�����


 

%%%%%%%%%%%%%%%%%%%%%%%%%%


