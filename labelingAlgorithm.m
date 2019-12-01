function ILabel2 = labelingAlgorithm(I1)
    % check if image is binary

    % get image size
    [r1, c1] = size(I1);

    ILabel = zeros(r1, c1, 'uint8');
    count = 1;

    % traverse the image
    for r = 1 : r1
        for c = 1 : c1
            % A ~= 0
            if I1(r, c) ~= 0
                % D_pixel_exists && A == D
                if r-1 > 0 && c-1 > 0 && I1(r, c) == I1(r-1, c-1)
                    % A_Label = D_Label
                    ILabel(r, c) = ILabel(r-1, c-1);
                else
                    % B_pixel_exists && A == B
                    if c-1 > 0 && I1(r, c) == I1(r, c-1)
                        % C_pixel_exists && A == C
                        if r-1 > 0 && I1(r, c) == I1(r-1, c)
                            % B_Label == C_Label
                            if ILabel(r, c-1) == ILabel(r-1, c)
                                % A_Label = B_Label
                                ILabel(r, c) = ILabel(r, c-1);
                            else
                                % A_Label = C_Label
                                ILabel(r, c) = ILabel(r-1, c);
                                % UPDATE
                                if count == 316
                                   x=1; 
                                end
                                for x = 1 : r1
                                    for y = 1 : c1
                                        % if Label(x, y) == B_Label
                                        if ILabel(x, y) ==  ILabel(r, c-1)
                                            % Label(x, y) = C_Label
                                            ILabel(x, y) = ILabel(r-1, c);
                                        end
                                    end
                                end
                            end
                        else
                            % A_Label = B_Label
                            ILabel(r, c) = ILabel(r, c-1);
                        end
                    else
                        % C_pixel_exists && A == C
                        if r-1 > 0 && I1(r, c) == I1(r-1, c)
                            % A_Label = C_Label
                            ILabel(r, c) = ILabel(r-1, c);
                        else
                            % A_Label = count; count++
                            ILabel(r, c) = count;
                            count = count + 1;
                        end
                    end
                end
            end
        end
    end
    
    % sequentially labelled
    ILabel2 = zeros(r1, c1, 'uint8');
    count2 = 1;
    for r = 1 : r1
        for c = 1 : c1
            if ILabel(r, c) ~= 0 && ILabel2(r, c) == 0
                
                for x = 1 : r1
                    for y = 1 : c1
                        if ILabel(x, y) == ILabel(r, c)
                            ILabel2(x, y) = count2;
                        end
                    end
                end
                count2 = count2 + 1;
            end
        end
    end
end
