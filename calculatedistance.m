function [output] = calculatedistance(inputArg1)

count = 0;
image = inputArg1;
[r,c] = size(image);

for i=1 : r
    for j=1 : c
        
        if(image(i,j) == 255 && count==0)
            if(image(i,j+1) == 0)
                count=count + 1;
            end
        end
        if(image(i,j) == 0 && count ~=0)
            count=count + 1;
        end
        if(image(i,j) == 255 && count ~=0)
           output = count;
           
        end
    end
end

end

