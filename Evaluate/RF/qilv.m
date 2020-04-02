%qilv  https://blog.csdn.net/qq_36614557/article/details/86764086
function[QILV]=qilv(I1,I2)
    I1=double(rgb2gray(I1));
    I2=double(rgb2gray(I2));
    lenx=8;%һ�з�Ϊ���ٸ�
    leny=8;%һ�з�Ϊ���ٸ�
    [miu1,kesi1,I_comp1]=getcompI(I1,lenx,leny);
    [miu2,kesi2,I_comp2]=getcompI(I2,lenx,leny);
    kesi=0;
    for i=1:lenx*leny
        kesi=kesi+(I_comp1(i,2)-miu1)*(I_comp2(i,2)-miu2);%�Աȶ�
    end
    kesi=kesi/(lenx*leny-1);
    QILV=abs(4*miu1*miu2*kesi1*kesi2*kesi/((miu1^2+miu2^2)*(kesi1^2+kesi2^2)*kesi1*kesi2));
end


function [miu,kesi,I_comp]=getcompI(I,lenx,leny)%����ͼ�����Miu��kesi
    [m,n]=size(I);
    co_m=floor(m/lenx);%һ��ĳ���
    co_n=floor(n/leny);
    I_comp=zeros(lenx*leny,2);%�洢ÿһ��ľ�ֵ�ͷ���
    num=0;
    kesi=0;
    for i=1:lenx
        for j=1:leny
            I_del=I(1+(i-1)*co_m:i*co_m,1+(j-1)*co_n:j*co_n);
            num=num+1;
            [I_comp(num,1),I_comp(num,2)]=get_every_image(I_del);
        end
    end
    miu=mean(I_comp(:,2));
    for i=1:size(I_comp,1)
        kesi=kesi+(I_comp(i,2)-miu)^2;
    end
    kesi=kesi/(size(I_comp,1)-1);
    kesi=sqrt(kesi);
end

function [avg,var]=get_every_image(I)%������ͼ��ļ�Ȩ��ֵ�ͷ���
    [m,n]=size(I);
    maxi=max(m,n);
    mini=min(m,n);
    %sig=randi([mini,maxi]);
    sig=(maxi+mini)/2;
    w_x=(1-floor(n/2):n-floor(n/2));%Ϊ��ͼ���С��ͬ mn����
    w_y=(1-floor(m/2):m-floor(m/2));
    [X,Y]=meshgrid(w_x,w_y);
    W=exp(-(X.^2+Y.^2)./sig.^2);%���ɶ�ά��˹���������ڼ������ÿ�������ص�Ȩֵ 
    avg=0;
    var=0;
    for i=1:m
        for j=1:n
            avg=avg+W(i,j)*I(i,j);
        end
    end
    avg=avg/sum(sum(W));%�����ֵ
    for i=1:m
        for j=1:n
            var=var+((I(i,j)-avg)^2)*W(i,j);
        end
    end
    var=var/sum(sum(W));%���㷽��


end