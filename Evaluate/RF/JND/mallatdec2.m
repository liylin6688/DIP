function Y=mallatdec2(X,wname,level)
%����:X????? ����Ķ�άͼ������ֵ;
%???? level? С���ֽ��(��)���趨ֵ(����趨ֵ������߿ɷֽ����,����߷ֽ�����ֽ�)
%????? wname? С������wavelet name
%�����Y???? �༫С���ֽ���С��ϵ������
%wfilters��С���˲���

[h,g]=wfilters(wname,'d');    %h,g�ֱ�Ϊ�ֽ�ĵ�ͨ�͸�ͨ�˲���
X=double(X);
t=1;
hh=size(X,2);
Y=zeros(1,hh);
while t<=level   %ѭ��
    %�Ƚ�����С���任
    for row=1:hh
        Y(row,1:hh)=mdec1(X(row,1:hh),h,g) ;
    end
    %�ٽ�����С���任
    for col=1:hh
        temp=mdec1( Y(1:hh,col)',h,g); %Y(1:hh,col)Ϊ�����е�һ�У�ת�ú�Ϊ���������õ��Ľ��tempҲ��������
        Y(1:hh,col)=temp';             %��������ת��Ϊ�������洢��Y��
    end
    t=t+1;                             %ѭ��������1������level��ѭ����ֹ
    hh=hh/2;                           %�ֽ�ľ���Ĵ�СΪԭ�����ķ�֮һ
    X=Y;                               %��Yֵ����X�ȴ���һ�ηֽ�                     
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
