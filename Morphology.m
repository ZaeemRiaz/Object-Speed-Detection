classdef (ConstructOnLoad = true) Morphology
    methods
        % dilation
        function I2 = dilation(~, I1)
            % get image size
            [r1, c1] = size(I1);
            
            % mask
            M = [0 255 0; 255 255 255; 0 255 0];
            
            
            
            I2 = zeros(r1, c1, 'uint8');
            for r = 2 : r1 -1
                for c = 2 : c1 - 1
                    
                    if I1(r, c) == 255
                        for x = 1 : 3
                            for y = 1 : 3
                                I2(r+x-2, c+y-2) = bitor( I2(r+x-2 , c+y-2), M(x, y));
                            end
                        end
                    end
                        
                    
                end
            end
           
        end
        
        % erosion
        function I2 = erosion(~, I1)
            % get image size
            [r1, c1] = size(I1);
            
            % mask
            M = [0 255 0; 255 255 255; 0 255 0];
            
            
            
            I2 = zeros(r1, c1, 'uint8');
            for r = 2 : r1 -1
                for c = 2 : c1 - 1
                    erode = 0;
                    for x = 1 : 3
                        for y = 1 : 3
                            if I1(r+x-2, c+y-2) ~= M(x, y) && M(x, y) == 255
                                erode = 1;
                            end
                        end
                    end
                    if erode == 0
                        I2(r, c) = I1(r, c);
                    end
                end
            end
           
        end

    end
end