classdef (ConstructOnLoad = true) BinaryObjectFeature
    methods

        % area
        function A = area(~, I1)
            
            % get image size
            [r1, c1] = size(I1);
            
            % get labelled image
            ILabel = labelingAlgorithm(I1);
            
            A = zeros(10, 1, 'uint32');
            for r = 1 : r1
                for c = 1 : c1
                    if ILabel(r, c) ~= 0
                        A(ILabel(r, c)) = A(ILabel(r, c)) + 1;
                    end
                end
            end
            
        end

        % center of area
        function coord1 = centerOfArea(obj, I1)
            % get image size
            [r1, c1] = size(I1);
            
            % get labelled image
            ILabel = labelingAlgorithm(I1);
            coord1 = zeros(10, 2, 'uint32');
            
            % get center of area
            for r = 1 : r1
                for c = 1 : c1
                    if ILabel(r, c) ~= 0
                        coord1(ILabel(r, c), 1) = coord1(ILabel(r, c), 1) + r;
                        coord1(ILabel(r, c), 2) = coord1(ILabel(r, c), 2) + c;
                    end
                end
            end
            
            
            A = obj.area(I1);
            % divide by area
            for k = 1 : 10
                coord1(k, 1) = coord1(k, 1) / A(k);
                coord1(k, 2) = coord1(k, 2) / A(k);
            end
        end

    end
end