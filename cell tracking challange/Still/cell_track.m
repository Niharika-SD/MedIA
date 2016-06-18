close all;
clear all;
allFiles = dir('cell_track');
existingImageNames = { allFiles.name };
existingImageNames([1,2]) = [];
resizedImage = zeros(size(existingImageNames,2),256,256);
for i = 1 : size(existingImageNames,2)
   inputImage1 = strcat('cell_track/',existingImageNames{i});
   inputImage = im2double(imread(inputImage1));
   resizedImage(i,:,:) = imresize(inputImage(:,:,2),[256,256]);
   imwrite(imresize(inputImage,[256,256]),strcat(num2str(i),'.bmp'));
end
%%

diff = [];
for i = 1 : size(existingImageNames,2)-1
      diff(i,:,:) = abs(resizedImage(i,:,:) - resizedImage(i+1,:,:)); 
end
%%
b = zeros(256,256);
for i = 1 : size(existingImageNames,2)-1
      a = (permute(diff(i,:,:),[2 3 1]));
      b = b+a;
end

c = mat2gray(b);
figure;imshow(b,[]);
level = graythresh(c);

d = im2bw(c,0.1);
e = imerode(d,ones(3));
figure; imshow(e);
CC = bwconncomp(e);

S = regionprops(CC,'Centroid');

figure;imshow(imresize(inputImage,[256,256]));
hold on;

for j = 1 : size(existingImageNames,2)
  RGB =  imread(strcat(num2str(i),'.bmp'));
for i = 1: size(S,1)
    m = S(i,1).Centroid;
    RGB = insertMarker(RGB,m,'circle','size',10,'color','red');
end
a = strcat(num2str(j),'.jpg');
imwrite(RGB,a);
end
% implay(RGB)

%figure;imshow(imerode(L,ones(3)));