
clear all
rgb = imread('fiber2.jpg');%读取原图像
I = rgb2gray(rgb);%转化为灰度图像
count=imhist(I);
bw = imbinarize(I, graythresh(I)-0.52);%转化为二值图像%
imshow(bw)
%% 分水岭变换并显示
D = bwdist(~bw);%计算白色区域每一个像素点到达黑色区域的最近距离
D=-D;%取反
D(~bw)=Inf;%将黑色区域像素值设置成无穷大
DL = watershed(D);%分水岭变换
DL=(DL~=0);%把联通块的区域设置为白色
DL(~bw)=0;%背景设置为黑色
sID = regionprops(logical(DL),bw,'PixelIdxList','EquivDiameter');%获取每一个联通块的大小和对应的位置
for i=1:1:size(sID,1)
   if(sID(i).EquivDiameter<20)%选取小于阈值的联通块
       DL(sID(i).PixelIdxList)=0;%将选定的联通块取0，变成黑色
   end
end
imshow(DL)%显示二值图像
%showMaskAsOverlay(0.4, DL, [1,1,1],[],0);
rgb = label2rgb(DL,'jet',[.5 .5 .5]);%转换成彩色图像
figure
imshow(rgb)