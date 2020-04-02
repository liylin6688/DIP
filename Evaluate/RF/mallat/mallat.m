%离散快速正交小波变换——Mallat算法
function [psnr]=mallat(I)
    order = 3; %变换级数为3
    I=rgb2gray(I);
    I=imresize(I,[256,256]);
    wname = 'db2';
    ordata=double(I);
    data=ordata;
    [row,col]=size(data);
    imdata=zeros(size(data,1),size(data,2));
    %分解
    [lo_d,hi_d]=wfilters(wname,'d');
    for i=1:order
        data=decomp(lo_d,hi_d,i,data);
        MIN=min(min(data));
        MAX=max(max(data));
        for j=1:size(data,1)
            for k=1:size(data,2)
                imdata(j,k)=((data(j,k)-MIN)/(MAX-MIN))*255;
            end
        end
        %figure;
        %imshow(uint8(imdata));    
    end

    %计算最后一级分解后能量分布
    energy=zeros(1,4);
    energy=cal_energy(data,order);

    %阈值化处理
    [thr,sorh]=ddencmp('den','wv',ordata);  %获得阈值
    ddata=wthresh(data,sorh,thr);           %阈值化处理
    MIN=min(min(ddata));
    MAX=max(max(ddata));
        for j=1:size(ddata,1)
            for k=1:size(ddata,2)
                imdata(j,k)=((ddata(j,k)-MIN)/(MAX-MIN))*255;
            end
        end
    %figure;    
    %imshow(uint8(imdata));  

    %统计0的个数
    sum=0;
    for i=1:row
        for j=1:col
            if (ddata(i,j)==0)
                sum=sum+1;
            end
        end
    end
    Zero=sum/(row*col);

    %重建
    [lo_r,hi_r]=wfilters(wname,'r');
    redata=zeros(size(data,1),size(data,2));
    data=ddata;
    for i=order:-1:1
        data=reconstrn(lo_r,hi_r,i,data);
        MIN=min(min(data));
        MAX=max(max(data));
        for j=1:size(data,1)
            for k=1:size(data,2)
                redata(j,k)=((data(j,k)-MIN)/(MAX-MIN))*255;
            end
        end
        %figure;
        %imshow(uint8(redata));
    end

    %计算重构后的均值和方差
    [mean,var]=cal_mv(data);

    %峰值信噪比PSNR
    [row,col]=size(data);
    mse=0;
    for i=1:row
        for j=1:col
            mse=mse+(data(i,j)-ordata(i,j))^2;
        end
    end
    mse=mse/(row*col);
    psnr=10*log10(255^2/mse);
end






