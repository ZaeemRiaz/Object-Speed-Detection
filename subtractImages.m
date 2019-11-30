function I3 = subtractImages(I1, I2)
    % I1, I2	Images
            
    % get image size
    [r1, c1, g1] = size(I1);
    [r2, c2, g2] = size(I2);

    % create buffer for return image
    I3 = zeros(r1, c1, g1, 'uint8');

    % check if dimensions of images are same
    if r1 == r2 && c1 == c2 && g1 == g2 == 1

        for r = 1 : r1
            for c = 1 : c1
%                 if I1(r, c, 1) - I2(r, c, 1) > 0
%                     I3(r, c, 1) = I1(r, c, 1) - I2(r, c, 1);
%                 else
%                     I3(r, c, 1) = I2(r, c, 1) - I1(r, c, 1);
%                 end
                I3(r, c, 1) = I1(r, c, 1) - I2(r, c, 1);
                
            end
        end

    end

end