
v = VideoReader('img\car3.mp4');

f1 = read(v,30);
f2 = read(v,62);

I1 = rgb2gray(f1);
I2 = rgb2gray(f2);

I3 = subtractImages(I1, I2);
% figure, imshow(I3,'InitialMagnification',100);


I4 = automaticThresholding(I3);
% figure, imshow(I4,'InitialMagnification',100);

morph = Morphology;
I5 = morph.dilation(I5);
I5 = morph.dilation(I5);

figure, imshow(I5,'InitialMagnification',100);

% I3 = labelingAlgorithm(I1);

bof = BinaryObjectFeature;
area = bof.area(I1);
coord = bof.centerOfArea(I1);
% area = bof.horizontalProjection(I1);
% area = bof.vaerticalProjection(I1);

% I3 = cannyEdgeDetection(I1);

% I4 = automaticThresholding(I7);
% figure, imshow(I4,'InitialMagnification',100);

% imwrite(I5, 'img\2xdilation.jpeg');
% imwrite(I4, 'img\otsu.jpeg');

