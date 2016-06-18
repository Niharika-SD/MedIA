
for j= 1:size(existingImageNames,2)

m = S(13,1).Centroid(1);
n = S(13,1).Centroid(2);

RGB =  rgb2gray(imresize(imread(strcat(num2str(j),'.jpg')),[256,256]));
mean1(j) = mean(mean(RGB(m-5:m+5,n-5:n+5)));
col = RGB(m-5:m+5,n-5:n+5);
ci = col(:);
variance(j) = var(ci);
end
figure;
plot(mean1)