load('data.mat')
thresold=0.5;
I1=reshape(array_img(1,:,:,:),[m/scale,n/scale,d]);
rotate=0;
for item=1:frame_number

    I1=reshape(array_img(1,:,:,:),[m/scale,n/scale,d]);
    I2=reshape(array_img(item,:,:,:),[m/scale,n/scale,d]);
    I1=uint8(I1);
    I2=uint8(I2);
    [des1,loc1] = getFeatures(I1);
    [des2,loc2] = getFeatures(I2);
    matched = match(des1,des2);
    drawMatched(matched,I1,I2,loc1,loc2);
    %在这里 loc1和loc2分别是1和2图的所有特征点的坐标  matched是loc1和loc2中特征点相同的映射  例如 如果
    %matched(i)=j  如果j不为0  则loc1(i)于loc2(j)匹配 否则在图2无匹配结果
    %大体思路：  确定映射关系后，在图一任取不重复的x个由任意两个有映射关系的点组成的直线 在图二求对应的直线 然后分别求
    %两个直线的斜率之差theta 最后求出平均theta 即为旋转角度 把图二逆时针转回去就可以（旋转后的图像更大一些） [只求中间部分的点的合集]
    %比例缩放的旋转角度不变
    %平移：  假设相机移动为匀速直线运动 对旋转后的每一条直线 求出在每一帧中的中心点 根据中心点 第一帧和第一帧  得出中心点的运动方程
    %最后得出总图像的平均运动方程 根据每一帧实际运动偏移和方程的中心点位置 对这一帧进行相反的平移即可


    num=0;
    for i=1:length(matched)
        if matched(i)~=0
            num=num+1;
        end
    end
    theta=zeros(1,num*(num-1)/2);
    k=1;
    for i=1:length(loc1)
        if matched(i)~=0
            for j=1:length(loc1)
                if matched(j)~=0 && i~=j %找两个有映射且不同的点
                    
                    theta(k)=(loc1(i,1)-loc1(j,1))/(loc1(i,2)-loc1(j,2)) - (loc2(matched(i),1)-loc2(matched(j),1))/(loc2(matched(i),2)-loc2(matched(j),2));
                    if theta(k)>thresold || theta(k)<-thresold
                        theta(k)=0;
                    end
                    k=k+1;
                end
            end
        end
    end
    theta(isnan(theta))=0; %把theta中存在NaN的数值替换成0
    rotate_theta=-mean(theta);
    rotate=atan(rotate_theta)*180/pi
    readname=strcat('C:\Users\71405\Desktop\回收站\计算机视觉\SIFT\sift2\frames\img_',num2str(item,'%04d'),'.jpg');
    I=imread(readname);
    B=imrotate(I,rotate);
    gcfname=strcat('C:\Users\71405\Desktop\回收站\计算机视觉\SIFT\sift2\rotate2\gcf_',num2str(item,'%04d'),'.jpg');
    imgname=strcat('C:\Users\71405\Desktop\回收站\计算机视觉\SIFT\sift2\rotate2\img_',num2str(item,'%04d'),'.jpg');
    drawMatched(matched,I1,I2,loc1,loc2);
    imwrite(B,imgname,'jpg');
    
    saveas(gcf,gcfname);
    close
end

