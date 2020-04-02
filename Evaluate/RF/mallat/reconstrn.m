%重建
function data_r=reconstrn(lo_r,hi_r,order,data)
[row,col]=size(data);
lo_ro=lo_r(1:2:end);%提取lo_r奇数位上的值
lo_re=lo_r(2:2:end);%提取lo_r偶数位上的值
hi_ro=hi_r(1:2:end);%提取hi_r奇数位上的值
hi_re=hi_r(2:2:end);%提取hi_r偶数位上的值
leno=size(lo_ro,2);
lene=size(lo_re,2);
%列重构
exloodata=wextend('ar','ppd',data(1:row/2^order,1:col/2^(order-1)),(leno-1),'u');%向上周期延拓
exloedata=wextend('ar','ppd',data(1:row/2^order,1:col/2^(order-1)),(lene-1),'u');%向上周期延拓
exhiodata=wextend('ar','ppd',data((row/2^order+1):row/2^(order-1),1:col/2^(order-1)),(leno-1),'u');%向上周期延拓
exhiedata=wextend('ar','ppd',data((row/2^order+1):row/2^(order-1),1:col/2^(order-1)),(lene-1),'u');%向上周期延拓
for i=1:row/2^(order-1);
    for j=1:col/2^(order-1);
        k=fix((i+1)/2);
        if(mod(i,2)==0)
            lodata=lo_ro*exloodata(k:k+leno-1,j);
            hidata=hi_ro*exhiodata(k:k+leno-1,j);
            data(i,j)=lodata+hidata;
        else
            lodata=lo_re*exloedata(k:k+lene-1,j);
            hidata=hi_re*exhiedata(k:k+lene-1,j);
            data(i,j)=lodata+hidata;
        end
    end
end

%行重构
exloodata=wextend('ac','ppd',data(1:row/2^(order-1),1:col/2^order),(leno-1),'l');%向左周期延拓
exloedata=wextend('ac','ppd',data(1:row/2^(order-1),1:col/2^order),(lene-1),'l');%向左周期延拓
exhiodata=wextend('ac','ppd',data(1:row/2^(order-1),(col/2^order+1):col/2^(order-1)),(leno-1),'l');%向左周期延拓
exhiedata=wextend('ac','ppd',data(1:row/2^(order-1),(col/2^order+1):col/2^(order-1)),(lene-1),'l');%向左周期延拓
for i=1:row/2^(order-1);
    for j=1:row/2^(order-1);
        k=fix((j+1)/2);
        if(mod(j,2)==0)
            lodata=lo_ro*exloedata(i,k:k+lene-1)';
            hidata=hi_ro*exhiedata(i,k:k+lene-1)';
            data(i,j)=lodata+hidata;
        else
            lodata=lo_re*exloodata(i,k:k+leno-1)';
            hidata=hi_re*exhiodata(i,k:k+leno-1)';
            data(i,j)=lodata+hidata;
        end
    end
end
data_r=data;
