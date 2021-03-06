clc
clear global
close all
 
Image = imread('16_test.tif');
% Resized_Image = imresize(Test_Image, 0.15);
Resized_Image = Image;
if size(Resized_Image, 3) == 3
    Resized_Image = rgb2gray(Resized_Image);
end

imshow(Resized_Image);

%% adjust contrast adapthisteq

% adapthisteq
I_adjust_contrast_adapthisteq = adapthisteq(Resized_Image);
figure;imshowpair(Resized_Image, I_adjust_contrast_adapthisteq, 'montage');
title('Adjust contrast with adapthisteq');
%% adjust contrast histeq

% % histeq
% I_adjust_contrast_adapthisteq = histeq(Resized_Image);
% imshowpair(Resized_Image, I_adjust_contrast_adapthisteq, 'montage');
%% imsharpen

% i_sharpen = imsharpen(I_adjust_contrast_adapthisteq);
% figure;imshowpair(I_adjust_contrast_adapthisteq, i_sharpen, 'montage');
% title('imsharpen');
%% average filter

% Avg_Filter = fspecial('average', [9 9]);
% Filtered_Image = imfilter(I_adjust_contrast_adapthisteq, Avg_Filter,'replicate');
% figure, imshowpair(I_adjust_contrast_adapthisteq, Filtered_Image, 'montage');
% title('average filter')

%% or gauss filter

Filtered_Image = imgaussfilt(I_adjust_contrast_adapthisteq, 2);
figure, imshowpair(I_adjust_contrast_adapthisteq, Filtered_Image, 'montage');
% figure, imshowpair(i_sharpen, Filtered_Image, 'montage');
title('gauss filter')
%% unsharp

unsharp = imsubtract(Filtered_Image, I_adjust_contrast_adapthisteq);

figure, imshow(unsharp);
title('unsharp Image')
%% Mask overlay

% higher_contrast_overlay_unsharp = imoverlay(I, unsharp, 'r');
% imshow(higher_contrast_overlay_unsharp);
%% Otsu

% level = Threshold_Level(Substracted_Image);
Binary_Image = im2bw(unsharp, graythresh(unsharp));
% Binary_Image = im2bw(Substracted_Image, level - 0.008);
figure, imshowpair(unsharp, Binary_Image, 'montage');
title('Binary Image')
%% loai bo cac diem

Clean_Image = bwareaopen(Binary_Image, 12);
% figure, imshowpair(Binary_Image, Clean_Image, 'montage');
figure, imshow(Clean_Image);
title('Clean Image')
%% Show blood vessel in original image.

regconize = Resized_Image + im2uint8(Clean_Image);
imshowpair(Resized_Image, regconize, 'montage');