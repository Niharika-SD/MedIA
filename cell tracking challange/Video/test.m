%% cell tracking assignment
clear all;
close all;
clc;
obj = VideoReader('parttrack.mp4');
video = obj.read();
video1(:,:,:,:)=video(:,:,:,151:390);
[x,y,z,t]=size(video1);
%implay(video1);
for i=1:t
    vidgray(:,:,i)=rgb2gray(video1(:,:,:,i));
end
%implay(vidgray);
%% difference image
for i=1:t-1
    diff(:,:,i)=vidgray(:,:,i+1)-vidgray(:,:,i);
end
%figure;implay(diff);
diff=cast(diff,'double');
%% integration of difference images
hotspot=sum(diff,3);
figure;imshow(hotspot,[]);title('integration of difference image');
hotspot=cast(hotspot,'uint8');
%%
%disk2=strel('disk',5);
%hotspot2=imclose(hotspot,disk2);
%hotspot2=imfill(hotspot, 'holes');
%hotspot2=imfill(im2bw(hotspot), [197,114],8);
%figure;imshow(hotspot2,[]);
%% erode operation
disk1=strel('disk',4);
hotspot_erode=imerode(hotspot,disk1);
figure;imshow(hotspot_erode,[]);title('erode operation on integrated image')
thresh1=graythresh(uint8(hotspot));
figure;im2bw(uint8(hotspot_erode),thresh1);
%% open operation
disk1=strel('disk',5);
hotspot_open=imopen(hotspot,disk1);
figure;imshow(hotspot_open,[]);title('open operation on integrated image')
hotspot=cast(hotspot,'uint8');
thresh1=graythresh(uint8(hotspot));
hotspotBW=im2bw(uint8(hotspot_open),thresh1);
figure;imshow(hotspotBW,[]);title('thresholded image on opend image')
%%
labeledImage = bwlabeln(hotspotBW, 4);
figure;imshow((labeledImage),[]);
%%
 celldata = regionprops(hotspotBW, 'Centroid'); 
 centroids = cat(1, celldata.Centroid);
figure;imshow(hotspotBW);title('centroids');
hold on
plot(centroids(:,1),centroids(:,2), 'b*')
hold off
%%
CC = bwconncomp(hotspot,4);
S = regionprops(CC,'Centroid');
%%
disk=strel('disk',5);
openhotspot=imopen(hotspot,disk);
figure;imshow(openhotspot);
erodehotspot=imerode(hotspot,disk);
figure;imshow(erodehotspot);
%%
thres=graythresh(hotspot);
thresimg=im2bw(hotspot,thres);
figure;imshow(thresimg);
