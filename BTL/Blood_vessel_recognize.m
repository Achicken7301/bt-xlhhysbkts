clear all
clc

I = imread('16_test.tif');
if size(I, 3) == 3
    I = rgb2gray(I);
end
figure, imshow(I), title('Anh goc');
%% adjust contrast

% imadjust
% I_adjust_contrast_imadjust = imadjust(I, [89/255, 159/255], [0 1]);
% Avg_Filter = fspecial('average', [9 9]);
% Filtered_Image = imfilter(I_adjust_contrast_imadjust, Avg_Filter,'replicate');
% figure, imshowpair(I_adjust_contrast_imadjust, Filtered_Image, 'montage');
% title('imadjust Image')

% adapthisteq
I_adjust_contrast_adapthisteq = adapthisteq(I);
Avg_Filter = fspecial('average', [10 10]);
Filtered_Image = imfilter(I_adjust_contrast_adapthisteq, Avg_Filter,'replicate');
figure, imshowpair(I_adjust_contrast_adapthisteq, Filtered_Image, 'montage');
title('adapthisteq Image')

%% unsharp

% unsharp imadjust_contrast
% unsharp = imsubtract(Filtered_Image, I_adjust_contrast_imadjust);
% figure, imshowpair(Filtered_Image, unsharp, 'montage');
% title('unsharp Image')


% unsharp adapthisteq_contrast
unsharp = imsubtract(Filtered_Image, I_adjust_contrast_adapthisteq);
figure, imshowpair(Filtered_Image, unsharp, 'montage');
title('unsharp Image')
%% Otsu

% level = Threshold_Level(Substracted_Image);
Binary_Image = im2bw(unsharp, graythresh(unsharp));
% Binary_Image = im2bw(Substracted_Image, level - 0.008);
figure, imshowpair(unsharp, Binary_Image, 'montage');
title('Binary Image')
%% loai bo cac diem

Clean_Image = bwareaopen(Binary_Image, 6);
figure, imshowpair(Binary_Image, Clean_Image, 'montage')
title('Clean Image')
%% lam day bien

% se90 = strel('line', 3, 90);
% se0 = strel('line', 3, 0);
% BWsdil = imdilate(Clean_Image, [se90 se0]);
% figure, imshowpair(Clean_Image, BWsdil, 'montage'), title('Mat na chua bien duoc lam day len');

%% Hien thi len anh goc

BWoutline = bwperim(BWsdil, 8);
Segout = I;
Segout(BWoutline) = 255;
figure, imshow(Segout), title('Te bao duoc xac dinh');


















