%计算最后一级分级高低频能量分布
function energy=cal_energy(data,order)
result=zeros(1,4);
[row,col]=size(data);
%求低频C(order)的能量
sum=0;
for i=1:row/2^order;
    for j=1:row/2^order;
        sum=sum+data(i,j)^2;
    end
end
result(1,1)=sum;
%求d(order,1)的能量
sum=0;
for i=(row/2^order+1:row/2^(order-1))
    for j=1:row/2^order;
        sum=sum+data(i,j)^2;
    end
end
result(1,2)=sum;
%求d(order,2)的能量
sum=0;
for i=1:row/2^order;
    for j=(row/2^order+1:row/2^(order-1))
        sum=sum+data(i,j)^2;
    end
end
result(1,3)=sum;
%求d(order,3)的能量
sum=0;
for i=(row/2^order+1:row/2^(order-1))
    for j=(col/2^order+1:col/2^(order-1))
        sum=sum+data(i,j)^2;
    end
end
result(1,4)=sum;
energy=result;
        
        
