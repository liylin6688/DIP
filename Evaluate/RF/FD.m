function fd_out=FD(I1,I2)
    fd1=cal_hash(I1,I2);
    fd2=cal_SVD(I1,I2);
    fd3=cal_colormom(I1,I2);
    fd4=cal_gcm(I1,I2);
    fd5=cal_Laws(I1,I2);
    fd6=cal_property(I1,I2);
    fd7=cal_sift(I1,I2);
    fd8=cal_Moravec(I1,I2);
    fd={fd1,fd2,fd3,fd4,fd5,fd6{1},fd6{2},fd6{3},fd6{4},fd6{5},fd7,fd8};
    w=[0.0121,0.0263,0.1003,0.1127,0.036,0.057,0.052,0.063,0.089,0.022,0.2556,0.1440];
    fd_out=0;
    for i=1:12
        fd_out=w(i)*fd{i}+fd_out;
    end
    fd_out=1-fd_out;
end
function mse=MSE(I1,I2)    
    D = I1-I2;
    [m,n]=size(D);
    mse=sum(D(:).^2)/(m*n);
end
function matrix=normalization2(matrix) %归一化到0~1
maxi=max(max(matrix));
mini=min(min(matrix));
for i=1:size(matrix,1)
    for j=1:size(matrix,2)
        matrix(i,j)=(matrix(i,j)-mini)/(maxi-mini);
    end
end
end
%% hash    
function fd=cal_hash(I1,I2)
    string1=gethash(I1);
    string2=gethash(I2);
    [m,n]=size(string1);
    length=m*n;
    mask=zeros(8,8);
    fd=0;
    for i=1:8
        for j=1:8
            if i<=2 || i>=7 || j<=2 || j>=7
                mask(i,j)=0.2;
            elseif i<=3 || i>=6 || j<=3 || j>=6
                    mask(i,j)=0.4;
                else 
                    mask(i,j)=1;
            end
        end
    end
    mask=reshape(mask,[1,64]);     
    index=0;
    for i=1:length
        index=index+1;
        if index>=65
            index=index-64;
        end
        if string1(i)~=string2(i)
            fd=fd+mask(index);
        end
    end
    disp('Hash Value:');
    disp(fd);
end
    

function [string]=gethash(I)
    I=imresize(I,[8,8]);
    [m,n,d]=size(I);
    I=I/4;
    m3=zeros(1,3);
    if d==3
        for i=1:d
            m3(i)=mean(mean(I(:,:,d)));
        end
    else
        m=mean(mean(I));
    end
    string=zeros(1,64*d);
    if d==1
        for i=1:8
            for j=1:8
                if I(i,j)>=m
                    string(8*(i-1)+j)=1;
                else
                    string(8*(i-1)+j)=0;
                end
            end
        end
    else
        for deep=1:3
            for i=1:8
                for j=1:8
                    if I(i,j,deep)>=m3(deep)
                         string(64*(deep-1)+8*(i-1)+j)=1;
                    else
                         string(64*(deep-1)+8*(i-1)+j)=0;
                    end
                end
            end
        end
    end
end
%% svd
function fd=cal_SVD(I1,I2)
    [M,N,~]=size(I1);
    [U1,S1,V1]=svd(double(rgb2gray(I1)));
    [U2,S2,V2]=svd(double(rgb2gray(I2)));%奇异值分解后求每个奇异值不同的加权值
    fd=0;
    for i=1:min(M,N)
        fd=fd+abs(S1(i,i)-S2(i,i))*(S1(i,i)+S2(i,i))/(sum(sum(S1))+sum(sum(S2)));
    end
    fd=fd/(max(sum(sum(S1)),sum(sum(S1))));
    disp('Singular Value Using SVD:');
    disp(fd);    
end
%% colormoment
function fd=cal_colormom(I1,I2)%0 最好 1最差
    w=zeros(1,9);
    colormom1=getcolormom(I1);
    colormom2=getcolormom(I2);
    fd=0;
    for i=1:9
        w(i)=max(colormom1(i),colormom2(i));
        fd=fd+abs(colormom1(i)-colormom2(i))/(9*w(i));
    end
    disp('Difference in Color Moment:');
    disp(fd);    
end
function colormom=getcolormom(I)
    I_r=I(:,:,1);
    I_g=I(:,:,2);
    I_b=I(:,:,3);
    colormom=zeros(1,9);
    colormom(1)=mean(mean(I_r));
    colormom(2)=sqrt(mean(mean((I_r-colormom(1)).^2)));
    colormom(3)=(mean(mean(((I_r-colormom(1))/colormom(2)).^3)))^(1/3);
    colormom(4)=mean(mean(I_g));
    colormom(5)=sqrt(mean(mean((I_g-colormom(4)).^2)));
    colormom(6)=(mean(mean(((I_g-colormom(4))/colormom(5)).^3)))^(1/3);
    colormom(7)=mean(mean(I_b));
    colormom(8)=sqrt(mean(mean((I_b-colormom(7)).^2)));
    colormom(9)=(mean(mean(((I_b-colormom(7))/colormom(8)).^3)))^(1/3);
end
%% gray co-matrix
function fd=cal_gcm(I1,I2)
    gcm1=graycomatrix(rgb2gray(I1));
    gcm1=normalization2(gcm1);
    gcm2=graycomatrix(rgb2gray(I2));
    gcm2=normalization2(gcm2);
    fd=MSE(gcm1,gcm2);
end
%% Laws
function fd=cal_Laws(I1,I2)
    fd=0;
    for i=1:5
        for j=1:5
        Laws=getLaws(i,j);
        I1_conv=conv2(rgb2gray(I1),Laws);
        I1_conv=normalization2(I1_conv);
        I2_conv=conv2(rgb2gray(I2),Laws);
        I2_conv=normalization2(I2_conv);
        fd=fd+MSE(I1_conv,I2_conv);
        end
    end
    fd=fd/25;
    disp('Difference in all-kinds Laws Conv:');
    disp(fd);    
end
function Laws=getLaws(i,j)%第i和第j个
    L=[1,4,6,4,1];
    E=[-1,-2,0,2,1];
    S=[-1,0,2,0,1];
    R=[1,-4,6,-4,1];
    W=[-1,2,0,-2,1];
    matrix=[L;E;S;R;W];
    Laws=matrix(i,:)'*matrix(j,:);
end
%% definition
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
%% smoothness
function smoothness=getSmoothness(I)
    I=rgb2gray(I);
    m=mean(mean(I));
    var=sqrt(mean(mean((I-m).^2)));
    smoothness=1-1/(1+var/255);
end
%% uniformity
function uniformity=getUniformity(I)
    [p,~]=imhist(I);
    p=p/sum(p);%每个灰度值的概率
    uniformity=sum(p.^2);
end
%% saturation 
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
%% entropy
function entropy=getEntropy(I)
    [p,~]=imhist(I);
    p=p/sum(p);%每个灰度值的概率
    entropy=0;
    for i=1:256
        if p(i)~=0
            entropy=entropy+p(i)*log(p(i))/log(2);
        end
    end
    entropy=-entropy;
end
%% Property
function fd=cal_property(I1,I2)
    difinition1=getDifinition(I1);
    smoothness1=getSmoothness(I1);
    uniformity1=getUniformity(I1);
    saturation1=getSaturation(I1);
    entropy1=getEntropy(I1);
    difinition2=getDifinition(I2);
    smoothness2=getSmoothness(I2);
    uniformity2=getUniformity(I2);
    saturation2=getSaturation(I2);
    entropy2=getEntropy(I2);
    property1={difinition1,smoothness1,uniformity1,saturation1,entropy1};
    property2={difinition2,smoothness2,uniformity2,saturation2,entropy2};
    disp('the Property of I1 in Difinition,Smoothness,Uniformity,Saturation and Entropy is as:');
    disp(property1);
    disp('the Property of I2 in Difinition,Smoothness,Uniformity,Saturation and Entropy is as:');
    disp(property2);
    fd=cell(5,1);
    for i=1:5
        fd{i}=abs(property2{i}-property1{i})/max(property2{i},property1{i});
    end
    disp('the Difference in Difinition,Smoothness,Uniformity,Saturation and Entropy is:');
    disp(fd);
end
%% sift
function fd=cal_sift(I1,I2)
    addpath('sift2')
    scale=1;
    [M,N]=size(I1);
    I1_s=imresize(I1,[M/scale,N/scale]);
    I2_s=imresize(I2,[M/scale,N/scale]);
    [des1,~] = getFeatures(I1_s);
    [des2,~] = getFeatures(I2_s);
    matched = match(des1,des2);
    [mx,my]=size(matched);
    count=0;
    for i=1:my
        if matched(i)~=0 
            count=count+1;
        end
    end
    fd=1-2*count/(size(des1,1)+size(des2,1));
    disp('Features matched:');
    disp(fd);   
end
%% Moravec
function fd=cal_Moravec(I1,I2)
    MO1=getMoravec(I1);
    I1_gray=rgb2gray(I1);
    MO2=getMoravec(I2);
    I2_gray=rgb2gray(I2);
    thresold_MO=0.2;
    thresold_ditance=3;
    MO1_mask=MO1>thresold_MO;
    MO2_mask=MO2>thresold_MO;
    num1=sum(sum(MO1_mask==1));
    num2=sum(sum(MO2_mask==1));
    [M,N]=size(MO1_mask);
    % range for all pixels that  I1 and I2's mask is 1 ,
    % and distance of gray image is less than thresold
    num_matched=0;
    for i=1:M
        for j=1:N 
            if MO1_mask(i,j)==1 && MO2_mask(i,j)==1 && abs(I1_gray(i,j)-I2_gray(i,j))<=thresold_ditance
                num_matched=num_matched+1;
            end
        end
    end
    fd=1-2*num_matched/(num1+num2); 
    disp('Interest matched in global threshold 0.2:');
    disp(fd);
end
function MO=getMoravec(I)
    I=rgb2gray(I);
    [m,n,~]=size(I);
    MO=zeros(m,n);
    for i=2:m-1
        for j=2:n-1
            for k=i-1:i+1
                for l=j-1:j+1
                    MO(i,j)=MO(i,j)+0.125*double(abs(I(k,l)-I(i,j)));
                end
            end
        end
    end
    MO=normalization2(MO);
end
            


