function [ img_Mout ]  =  HE( img_Min )
    I = img_Min;
    I1 = I(:,:,1);%��ȡRͨ��
    I2 = I(:,:,2);%��ȡGͨ��
    I3 = I(:,:,3);%��ȡBͨ��
    I1 = test(I1);%ֱ��ͼ���⻯
    I2 = test(I2);%ֱ��ͼ���⻯
    I3 = test(I3);%ֱ��ͼ���⻯
    img_Mout = cat(3,I1,I2,I3); %�ϲ�
end

function m = test(I)
    J = I;
    [w,l] = size(I);%ȷ�������С
    area = w * l;
    a = zeros(1,256);
    b = zeros(1,256);
    for i = 1:w %��¼ÿ���Ҷȵĸ���
         for j = 1:l
             m = I(i,j) + 1;
             a(1,m) = a(1,m) + 1;
         end
    end
    for i = 1:256 %���⻯
         sum = 0;
         for j = 1:i
            sum = sum + a(1,j);
         end
         b(1,i) = sum * 255/area;
    end
    for i = 1:w %�þ��⻯������ݴ���ԭλ�õ�����
         for j = 1:l
            m = J(i,j) + 1;
            J(i,j) = b(1,m);
         end
    end
    m = J;
end

