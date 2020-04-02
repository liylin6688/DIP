%求均值、方差
function [mean var]=cal_mv(data)
[row col]=size(data);
sum=0;
for i=1:row
    for j=1:col
        sum=sum+data(i,j);
    end
end
mean = sum/(row*col);
sum=0;
for i=1:row
    for j=1:col
        sum=sum+(data(i,j)-mean)^2;
    end
end
var = sum/(row*col);
        

        