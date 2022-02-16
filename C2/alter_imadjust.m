function new_image = alter_imadjust( src, min, max, new_min, new_max )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% The same as J = imadjust(I,[low_in; high_in],[low_out; high_out])
% [low_in high_in] = [min max]
% [low_out high_out] = [new_min new_max]

% Where is this fomula comming from?
% https://en.wikipedia.org/w/index.php?title=Normalization_(image_processing)&oldid=1063488317

I = imread(src);
new_image = (I - min)*((new_max - new_min)/(max - min)) + new_min;

if size(new_image, 3) == 3
    new_image = rgb2gray(new_image);
end
end