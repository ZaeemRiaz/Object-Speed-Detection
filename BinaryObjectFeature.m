classdef (ConstructOnLoad = true) BinaryObjectFeature
    methods

        % area
        function A1 = area(~, I1)
            
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
            j = 1;
            A1 = zeros(2, 1, 'uint32');
            for i = 1 : 10
                if A(i) ~= 0
                    A1(j) = A(i);
                    j = j + 1;
                end
            end
        end

        % center of area
        function coord = centerOfArea(obj, I1)
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
            
            % get the 2 objects first
            j = 1;
            coord = zeros(2, 2, 'uint32');
            for i = 1 : 10
                if coord1(i, 1) ~= 0 && coord1(i, 2) ~= 0 
                    coord(j, 1) = coord1(i, 1);
                    coord(j, 2) = coord1(i, 2);
                    j = j + 1;
                end
            end
            
            A = obj.area(I1);
            % divide by area
            for k = 1 : 2
                coord(k, 1) = coord(k, 1) / A(k);
                coord(k, 2) = coord(k, 2) / A(k);
            end
        end

        % horizontal projection
        function P = horizontalProjection(~, I1)
            % get image size
            [r1, c1] = size(I1);
            
            % get labelled image
            ILabel = labelingAlgorithm(I1);
            P1 = zeros(10, r1, 'uint32');
            
            % get projection of image
            for r = 1 : r1
                for c = 1 : c1
                    if ILabel(r, c) ~= 0
                        P1(ILabel(r, c), r) = P1(ILabel(r, c), r) + 1;
                    end
                end
            end
            
            % get the 2 objects first with projection of objects at first
            j = 1;
            P = zeros(2, r1, 'uint32');
            for i = 1 : 10
                empty = true;
                s = 0;
                l = 0;
                for r = 1 : r1
                    if P1(i, r) ~= 0
                        empty = false;
                        % find start of projection
                        if s == 0
                            s = r;
                        end
                        % find length of projection
                        l = l + 1;
                    end
                end
                if empty == false
                    for r = 1 : l
                        P(j, r) = P1(i, s+r-1);
                    end
                    j = j + 1;
                end
            end
        end

        % vertical Projection
        function P = vaerticalProjection(~, I1)
            % get image size
            [r1, c1] = size(I1);
            
            % get labelled image
            ILabel = labelingAlgorithm(I1);
            P1 = zeros(10, r1, 'uint32');
            
            % get projection of image
            for r = 1 : r1
                for c = 1 : c1
                    if ILabel(r, c) ~= 0
                        P1(ILabel(r, c), c) = P1(ILabel(r, c), c) + 1;
                    end
                end
            end
            
            % get the 2 objects first with projection of objects at first
            j = 1;
            P = zeros(2, c1, 'uint32');
            for i = 1 : 10
                empty = true;
                s = 0;
                l = 0;
                for c = 1 : c1
                    if P1(i, c) ~= 0
                        empty = false;
                        % find start of projection
                        if s == 0
                            s = c;
                        end
                        % find length of projection
                        l = l + 1;
                    end
                end
                if empty == false
                    for c = 1 : l
                        P(j, c) = P1(i, s+c-1);
                    end
                    j = j + 1;
                end
            end
        end
    end
end