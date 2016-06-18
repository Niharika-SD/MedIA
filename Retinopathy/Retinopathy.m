close all
clear all
A = imread('DRIVE.jpg');
B = A(:,:,2);
figure;imshow(B,[]);
mask =(B>=50);
figure;imshow(mask);
B1 = double(B).*mask;
[m,n] = size(B);
% figure;imshow(B);
C = FrangiFilter2D(double(B1),[]);
% D =imerode(C,ones(5,5));
% E =imdilate(D,ones(5,5));
% 
% figure;imshow(E);
% mask = reshape((E>0),[m,n]);
% figure;imshow(mask)
% mask_inv =1-mask;
% figure;imshow(mask_inv)
% C_1(~mask_inv) = 0;
% figure;imshow(C_1)

GT = double(imread('GT.jpg'))/255;
figure;imshow(GT,[]);

EV = Evaluate(im2bw(GT),im2bw(C));
thresh = EV(6);

BW = im2bw(C,thresh);
figure;imshow(BW,[]);
figure;imshow(imclose(BW,ones(2,2)),[])
