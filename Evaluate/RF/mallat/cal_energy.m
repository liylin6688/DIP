%�������һ���ּ��ߵ�Ƶ�����ֲ�
function energy=cal_energy(data,order)
result=zeros(1,4);
[row,col]=size(data);
%���ƵC(order)������
sum=0;
for i=1:row/2^order;
    for j=1:row/2^order;
        sum=sum+data(i,j)^2;
    end
end
result(1,1)=sum;
%��d(order,1)������
sum=0;
for i=(row/2^order+1:row/2^(order-1))
    for j=1:row/2^order;
        sum=sum+data(i,j)^2;
    end
end
result(1,2)=sum;
%��d(order,2)������
sum=0;
for i=1:row/2^order;
    for j=(row/2^order+1:row/2^(order-1))
        sum=sum+data(i,j)^2;
    end
end
result(1,3)=sum;
%��d(order,3)������
sum=0;
for i=(row/2^order+1:row/2^(order-1))
    for j=(col/2^order+1:col/2^(order-1))
        sum=sum+data(i,j)^2;
    end
end
result(1,4)=sum;
energy=result;
        
        
