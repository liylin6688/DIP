%分解变换
function data_d=decomp(lo_d,hi_d,order,data)
[row,col]=size(data);
%一维行变换
firowlen=size(lo_d,2);
l=fix(firowlen/2);
%excoldata=wextend('ac','sym',data(1:row/2^(order-1),1:col/2^(order-1)),l);
excoldata=wextend('ac','ppd',data(1:row/2^(order-1),1:col/2^(order-1)),firowlen-1,'r');%往右周期延拓
for i=1:row/2^(order-1);
    for j=1:row/2^order;
        data(i,j)=lo_d*excoldata(i,(2*j-1):(2*j+firowlen-2))';
        data(i,j+row/2^order)=hi_d*excoldata(i,(2*j-1):(2*j+firowlen-2))';
    end
end

%一维列变换
ficollen=size(hi_d,2);
l=fix(ficollen/2);
%exrowdata=wextend('ar','sym',data(1:row/2^(order-1),1:col/2^(order-1)),l);
exrowdata=wextend('ar','ppd',data(1:row/2^(order-1),1:col/2^(order-1)),ficollen-1,'d');%往下周期延拓
for i=1:col/2^(order-1);
    for j=1:col/2^order;
        data(j,i)=lo_d*exrowdata((2*j-1):(2*j+ficollen-2),i);
        data(j+col/2^order,i)=hi_d*exrowdata((2*j-1):(2*j+ficollen-2),i);
    end
end
data_d= data;
