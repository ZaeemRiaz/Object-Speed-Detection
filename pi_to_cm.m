function [outputArg1] = pi_to_cm(inputArg1)

image = inputArg1;
[r,c] = size(image);
obj_len_cm = 27;
%converting length from cm to inch%
obj_len_in = obj_len_cm/2.54;
dpi = c/obj_len_in;
%length of 1 pixel%
len = 25.4/dpi;

outputArg1 = len;
%returns the length that a single pixel represents%

end

