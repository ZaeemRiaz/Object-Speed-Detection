
I1 = imread('img\car4.jpeg');
I2 = imread('img\car5.jpeg');


% I3 = labelingAlgorithm(I1);

% bof = BinaryObjectFeature;
% area = bof.area(I1);
% area = bof.centerOfArea(I1);
% area = bof.horizontalProjection(I1);
% area = bof.vaerticalProjection(I1);

% I3 = cannyEdgeDetection(I1);



I1 = rgb2gray(I1);
I2 = rgb2gray(I2);

% figure, imshow(I1,'InitialMagnification',100);

I3 = subtractImages(I1, I2);



I4 = automaticThresholding(I7);
figure, imshow(I4,'InitialMagnification',100);

% imwrite(I3, 'img\sub.jpeg');
% imwrite(I4, 'img\otsu.jpeg');

