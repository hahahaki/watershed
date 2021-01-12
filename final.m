
clear all
rgb = imread('fiber2.jpg');%��ȡԭͼ��
I = rgb2gray(rgb);%ת��Ϊ�Ҷ�ͼ��
count=imhist(I);
bw = imbinarize(I, graythresh(I)-0.52);%ת��Ϊ��ֵͼ��%
imshow(bw)
%% ��ˮ��任����ʾ
D = bwdist(~bw);%�����ɫ����ÿһ�����ص㵽���ɫ������������
D=-D;%ȡ��
D(~bw)=Inf;%����ɫ��������ֵ���ó������
DL = watershed(D);%��ˮ��任
DL=(DL~=0);%����ͨ�����������Ϊ��ɫ
DL(~bw)=0;%��������Ϊ��ɫ
sID = regionprops(logical(DL),bw,'PixelIdxList','EquivDiameter');%��ȡÿһ����ͨ��Ĵ�С�Ͷ�Ӧ��λ��
for i=1:1:size(sID,1)
   if(sID(i).EquivDiameter<20)%ѡȡС����ֵ����ͨ��
       DL(sID(i).PixelIdxList)=0;%��ѡ������ͨ��ȡ0����ɺ�ɫ
   end
end
imshow(DL)%��ʾ��ֵͼ��
%showMaskAsOverlay(0.4, DL, [1,1,1],[],0);
rgb = label2rgb(DL,'jet',[.5 .5 .5]);%ת���ɲ�ɫͼ��
figure
imshow(rgb)