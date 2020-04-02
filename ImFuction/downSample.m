function [ img_d ] = downSample( img_s, dowmFreq )
    %下采样图像，dowmFreq为下采样倍数
    Freq = sqrt(dowmFreq);
    [wid,hei]=size(img_s);
    img_d=zeros(floor(wid/Freq)+1,floor(hei/Freq)+1);
    i1=1;
    j1=1;
    for i=1:Freq:wid
        for j=1:Freq:hei
            img_d(i1,j1)=img_s(i,j);
            j1=j1+1;
        end
        i1=i1+1;
        j1=1;
    end
    img_d = uint8(img_d);
end

