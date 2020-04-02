clear
clc

%读取视频，逐帧解析成图片后保存在目录下文件夹内
video=VideoReader('Rocks.mp4');
frame_number=video.NumberOfFrames;
scale=4;%缩放尺度
[m n d]=size(read(video,1));
array_img=zeros(frame_number,m/scale,n/scale,d);
for i=1:frame_number
    img=read(video,i);
    imgname=strcat('C:\Users\71405\Desktop\回收站\计算机视觉\SIFT\sift2\frames\img_',num2str(i,'%04d'),'.jpg');
    imwrite(img,imgname,'jpg');
    array_img(i,:,:,:)=imresize(img,[m/scale,n/scale]);
end

%示例将矩阵中的图片显示（array_img(i,:,:,:)仍为四维矩阵（1*160*360*3） 用reshape转成160*360*3就可以了 ）
for i=1:frame_number
    pause(0.01) 
    a=reshape(array_img(i,:,:,:),[m/scale,n/scale,d]);
    a=uint8(a);
    imshow(a)
end
save('data.mat')

