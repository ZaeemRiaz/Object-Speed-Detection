
I1 = imread('img\car4.jpeg');
I2 = imread('img\car5.jpeg');




I1 = rgb2gray(I1);
I2 = rgb2gray(I2);

% figure, imshow(I1,'InitialMagnification',100);

I3 = subtractImages(I1, I2);
I5 = subtractImages(I2, I1);


figure, imshow(I3,'InitialMagnification',100);
figure, imshow(I5,'InitialMagnification',100);



% I4 = automaticThresholding(I3);


% figure, imshow(I4,'InitialMagnification',100);

% imwrite(I3, 'img\sub.jpeg');
% imwrite(I4, 'img\otsu.jpeg');