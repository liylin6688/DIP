%% False coloring
% ����ɫͼ��ת��Ϊ�Ҷ�ͼ����һ��������Ĺ��̣��Ҷ�ͼ��Ҳ�����ܱ任Ϊԭ���Ĳ�ɫͼ�񡣶�ĳЩ������Ҫ���Ҷ�ͼ��ת��Ϊ��ɫͼ��α��ɫ������Ҫ�ǰѺڰ׵ĻҶ�ͼ����߶ನ��ͼ��ת��Ϊ��ɫͼ��ļ������̡���Ŀ�������ͼ�����ݵĿɱ�ʶ�ȡ�
% α��ɫͼ��ĺ����ǣ�ÿ�����ص���ɫ������ÿ����ɫ��������ֱֵ�Ӿ��������ǰ�����ֵ������ɫ���ұ�(�������õ�)�ı�����ڵ�ַ��ȥ����һ����ʾͼ��ʱʹ�õ�R��G��Bǿ��ֵ���ò��ҳ���R��G��Bǿ��ֵ�����Ĳ�ɫ��Ϊα��ɫ��
img_name = 'img.png';
source = imread(img_name);
gray = rgb2gray(source);
% FalseRGB = label2rgb(gray2ind(gray, 255),jet(255));
% subplot(131);imshow(source);title('ԭ��ɫ')
% subplot(132);imshow(gray);title('�Ҷ�ͼ')
% subplot(133);imshow(FalseRGB);title('α��ɫ')

%% Full color processing
%Ҫ����ȫ��ɫͼ������Ҫ�Բ�ɫ��ÿ��ͨ���ֱ���Ȼ�������һ����������ֵ�˲�Ϊ�����Բ�ɫͼ����д���
% img_name = 'img.png';
% source = imread(img_name);
% for i = 1:3
%     img_noise(:, :, i) = imnoise(source(:, :, i), 'salt & pepper', 0.02);
%     img_recover(:, :, i) = medfilt2(img_noise(:, :, i));
% end
% subplot(131);imshow(source);title('ԭͼ')
% subplot(132);imshow(img_noise);title('����ͼ')
% subplot(133);imshow(img_recover);title('�˲�ͼ')

