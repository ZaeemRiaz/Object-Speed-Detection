
v = VideoReader('img\car3.mp4');

f1 = read(v,30);
f2 = read(v,62);

I1 = rgb2gray(f1);
I2 = rgb2gray(f2);

I3 = subtractImages(I1, I2);

I4 = automaticThresholding(I3);

morph = Morphology;
I5 = morph.dilation(I4);
I6 = morph.dilation(I5);

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

% imwrite(I5, 'img\2xdilation.jpeg');
% imwrite(I4, 'img\otsu.jpeg');

