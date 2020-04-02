function [difinition, smoothness, uniformity, saturation, entropy] = getBasicParam(I)
    difinition=getDifinition(I);
    smoothness=getSmoothness(I);
    uniformity=getUniformity(I);
    saturation=getSaturation(I);
    entropy=getEntropy(I);
end
%% definition 清晰度
function difinition=getDifinition(I)
    difinition=0;
    I=rgb2gray(I);
    [m,n]=size(I);
    for i=1:m-1
        for j=1:n-1
            difinition=difinition+double(abs(I(i,j)-I(i+1,j))*abs(I(i,j)-I(i,j+1)));
        end
    end
end
%% smoothness 平滑度
function smoothness=getSmoothness(I)
    I=rgb2gray(I);
    m=mean(mean(I));
    var=sqrt(mean(mean((I-m).^2)));
    smoothness=1-1/(1+var/255);
end
%% uniformity 一致性
function uniformity=getUniformity(I)
    I1 = I(:,:,1);
    [p,~]=imhist(I1);
    p=p/sum(p);%姣忎釜鐏板害鍊肩殑姒傜巼
    uniformity=sum(p.^2);
end
%% saturation 饱和度?
function saturation=getSaturation(I)
    saturation=0;
    I_gray=rgb2gray(I);
    [m,n,d]=size(I);
    for i=1:m
        for j=1:n
            for k=1:d
                saturation=saturation+double(abs(I(i,j,k)-I_gray(i,j)));
            end
        end
    end
end
%% entropy 信息熵?
function entropy=getEntropy(I)
    I1 = I(:,:,1);
    [p,~]=imhist(I1);
    p=p/sum(p);%姣忎釜鐏板害鍊肩殑姒傜巼
    entropy=0;
    for i=1:256
        if p(i)~=0
            entropy=entropy+p(i)*log(p(i))/log(2);
        end
    end
    entropy=-entropy;
end