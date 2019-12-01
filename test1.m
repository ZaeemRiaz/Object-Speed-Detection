
v = VideoReader('img\car7.mp4');

f1 = read(v,52);
f2 = read(v,63);

% I1 = rgb2gray(f1);
% I2 = rgb2gray(f2);

% figure, imshow(I1,'InitialMagnification',100);
% figure, imshow(I2,'InitialMagnification',100);

Ir = subtractImages(f1(:,:,1), f2(:,:,1));
Ig = subtractImages(f1(:,:,2), f2(:,:,2));
Ib = subtractImages(f1(:,:,3), f2(:,:,3));

I3 = imadd(imadd(Ir, Ig), Ib);
% I3 = subtractImages(I1, I2);
% figure, imshow(I3,'InitialMagnification',100);

I4 = automaticThresholding(I3);
% figure, imshow(I4,'InitialMagnification',100);

morph = Morphology;
I5 = morph.erosion(I4);
I5 = morph.dilation(I5);
I6 = morph.dilation(I5);

figure, imshow(I6,'InitialMagnification',100);

bof = BinaryObjectFeature;
area = bof.area(I6);
coord = bof.centerOfArea(I6);

% get index for 2 largest objects
maxI = 0;
maxV = 0;
smaxI = 0;
smaxV = 0;
for x = 1 : size(area)
    if area(x) > maxV
        smaxV = maxV;
        smaxI = maxI;
        maxV = area(x);
        maxI = x;
    else
        if area(x) > smaxV
            smaxV = area(x);
            smaxI = x;
        end
    end
end

x1 = coord(maxI, 1);
y1 = coord(maxI, 2);
x2 = coord(smaxI, 1);
y2 = coord(smaxI, 2);

% imwrite(I4, 'img\grey.jpeg');
% imwrite(Id, 'img\color.jpeg');

