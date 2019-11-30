function I3 = cannyEdgeDetection(I1)

    % get image size
    [r1, c1, g1] = size(I1);
    
    % check if grey scale
    if g1 ~= 1
        I1 = rgb2gray(I1);
    end
    
    % ==================== gaussian filter ====================
    
    % filter
    gf = [0.003765 	0.015019 0.023792 0.015019 0.003765; 0.015019 0.059912 0.094907 0.059912 0.015019; 0.023792 0.094907 0.150342 0.094907 0.023792; 0.015019 0.059912 0.094907 0.059912 0.015019; 0.003765 0.015019 0.023792 0.015019 0.003765];
    
    % zero pad image
    I2 = zeros(r1 + 4, c1 + 4, 'uint8');
    for r = 1 : r1
        for c = 1 : c1
            I2(r+2, c+2) = I1(r, c);
        end
    end
    
    % create buffer for filtered image
    I3 = zeros(r1, c1, 'uint8');

    % traverse image
    for r = 1 : r1
        for c = 1 : c1
            % traverse mask and get average
            ret = (0.00);
            for x = 1 : 5
                for y = 1 : 5
                    ret = ret + (I2(r+x-1, c+y-1) * gf(x, y));
                end
            end
            % save result
            I3(r, c) = ret;
        end
    end
    
    % ==================== gradient calculation ====================
    
    % zero pad image
    I4 = zeros(r1 + 2, c1 + 2, g1, 'uint8');
    for r = 1 : r1
        for c = 1 : c1
            I4(r+1, c+1) = I3(r, c);
        end
    end
    
    % masks
    vm = [-1 -2 -1; 0 0 0; 1 2 1];
    hm = [-1 0 1; -2 0 2; -1 0 1];
    
    % create buffer for magnitude and angle
    M = zeros(r1, c1, 'uint8');
    A = zeros(r1, c1, 'int16');
    
    % traverse image
    for r = 1 : r1
        for c = 1 : c1
            % traverse mask and get average
            ve = int16(0);
            he = int16(0);
            for x = 1 : 3
                for y = 1 : 3
                    ve = ve + (int16(I4(r+x-1, c+y-1)) * int16(vm(x, y)));
                    he = he + (int16(I4(r+x-1, c+y-1)) * int16(hm(x, y)));
                end
            end
            % calc and save magnitude and angle
            M(r, c) = sqrt(double(uint32(ve)^2 + uint32(he)^2));
            A(r, c) = round( rad2deg(atan(double(ve) / double(he))) / 45) * 45;
        end
    end
    
    % ==================== non-maxima supression ====================
    
    M1 = zeros(r1, c1, 'uint8');
    
    % traverse image but exclude borders
    for r = 2 : r1-1
        for c = 2 : c1-1
            % check pixels in angle direction for comparison
            switch A(r, c)
                case 0
                    if M(r, c) >= M(r, c-1) && M(r, c) >= M(r, c+1)
                        M1(r, c) = M(r, c);
                    end
                case 45
                    if M(r, c) >= M(r-1, c-1) && M(r, c) >= M(r+1, c+1)
                        M1(r, c) = M(r, c);
                    end
                case 90
                    if M(r, c) >= M(r-1, c) && M(r, c) >= M(r+1, c)
                        M1(r, c) = M(r, c);
                    end
                case -45
                    if M(r, c) >= M(r+1, c-1) && M(r, c) >= M(r-1, c+1)
                        M1(r, c) = M(r, c);
                    end
                case -90
                    if M(r, c) >= M(r-1, c) && M(r, c) >= M(r+1, c)
                        M1(r, c) = M(r, c);
                    end
            end
        end
    end
    
    % ==================== double threshold ====================
    highRatio = 0.09;
    lowRatio = 0.05;
    highThreshold = max(max(M1)) * highRatio;
    lowThreshold = highThreshold * lowRatio;
    
    % ==================== hysteresis ====================
    % traverse image but exclude borders
    for r = 2 : r1-1
        for c = 2 : c1-1
            if M1(r, c) > highThreshold
                % high threshold
                M1(r, c) = 255;
            elseif M1(r, c) < lowThreshold
                % low threshold
                M1(r, c) = 0;
            else
                % check if strong pixel nearby
                strong = false;
                for x = 1 : 3
                    for y = 1 : 3
                        if M1(r+x-2, c+y-2) > highThreshold
                            strong = true;
                        end
                    end
                end
                if strong == true
                    % strong pixel nearby
                    M1(r, c) = 255;
                else
                    % no strong pixel nearby
                    M1(r, c) = 0;
                end
            end
        end
    end
    I3 = M1;
    
end
