%% Bai 2
% (I - f1)/(f2 - f1)
close all; % Class all figures

[file_X, folder] = uigetfile({'*.dcm; *.png; *.jpg'}, 'MultiSelect', 'on');
file = [folder file_X];
I = imread(file);

% a = 'H:\My Drive\Khang\BK\212\AS3055 - xlhhysbkts\sample data _ chapter 02\BW.png';
% I = imread(a);


[row, col]= size(I);
if size(I, 3) == 3
    I = rgb2gray(I);
end
% figure; imshow(I);
% figure; imhist(I);
% hist(217:256) = 0;
% [Low_in High_in] = [50/255 217/255]

t_in = 52;
t_out = 210;

im_adjust = imadjust(I, [t_in/255 t_out/255], [0 1]);
imtool(im_adjust);
% subplot(2,1,1); 
% subplot(2,1,2); imhist(im_adjust); title('imadjust');
%% Bai 3
[file_X, folder] = uigetfile({'*.*'}, 'MultiSelect', 'on');
file = [folder file_X];
I = imread(file);
if size(I, 3) == 3
    I = rgb2gray(I);
end
I = im2double(I);
% I = rgb2lab(I);
%% Loc Gauss
blurred = imgaussfilt(I, 5);
imshowpair(I, blurred, 'montage');
%% unsharp
unsharp = I - blurred;
imshow(unsharp);
%% adapthisteq
hco = adapthisteq(I);
imshowpair(I, hco, 'montage');
%% higher contrast original Bai 2
hco = imadjust(I, [93/255 132/255], [0 1]);
imshowpair(I, hco, 'montage');
%% sharpened final image

sharpened = hco + unsharp + I;
delta_value = hco - I;
% sharpened = delta_value + unsharp + I;
imshowpair(I, sharpened, 'montage');