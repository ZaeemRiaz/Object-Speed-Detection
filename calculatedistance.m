function [output] = calculateDistance(inputArg1,i1,i2)

% count = 0;
image = inputArg1;
% [r,c] = size(image);
% 
% for i=1 : r
%     for j=1 : c
%         
%         if(image(i,j) == 255 && count==0)
%             if(image(i,j+1) == 0)
%                 count=count + 1;
%             end
%         end
%         if(image(i,j) == 0 && count ~=0)
%             count=count + 1;
%         end
%         if(image(i,j) == 255 && count ~=0)
%            output = count;
%            
%         end
%     end
% end


c1 = i1;

c2 = i2;

res = c2 - c1;

if(res<0)
    res = res*-1;
end

output = res;



end

