function I2 = automaticThresholding(I1)
    % get image size
    [r1, c1, g1] = size(I1);
    
    % check grey scale
    if g1 ~= 1
        I1 = rgb2gray(I1);
    end
    h = zeros(1, 256, 'uint32');
    for r = 1: r1
        for c = 1 : c1
            h(I1(r, c) + 1) = h(I1(r, c) + 1) + 1;
        end
    end
    
    maxV = 0;
    maxI = 0;
    total = 0;
    for i = 1 : 256
        total = total + h(i);
    end
    
    for i = 1 : 256
        % background
        sum = 0;
        mSum = 0;
        for j = 1 : i
            sum = sum + h(j);
            mSum = mSum + (h(j) * (j-1));
        end
        meanB = double(mSum) / double(sum);
        weightB = double(sum) / double(total);
        
        % foreground
        sum = 0;
        mSum = 0;
        for j = i + 1 : 256
            sum = sum + h(j);
            mSum = mSum + (h(j) * (j-1));
        end
        meanA = double(mSum) / double(sum);
        weightA = double(sum) / double(total);
        
        % variance between class
        var = weightB * weightA * double(power(meanB - meanA, 2));
        
        % store max variance and index
        if var > maxV
            maxV = var;
            maxI = i;
        end
    end
    
    I2 = zeros(r1, c1, 1, 'uint8');
                
    for r = 1: r1
        for c = 1 : c1
            % background
            if I1(r, c) < maxI
                I2(r, c) = 0;
            else
                I2(r, c) = 255;
            end
        end
    end

end
