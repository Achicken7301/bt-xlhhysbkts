% (I - f1)/(f2 - f1)
close all; % Class all figures

% [file_X, folder] = uigetfile({'*.dcm; *.png; *.jpg'}, 'MultiSelect', 'on');
% file = [folder file_X];

a = 'H:\My Drive\Khang\BK\212\AS3055 - xlhhysbkts\bt-xlhhbkts\sample data _ chapter 02\lung.bmp';
I = imread(a);
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
figure; 
subplot(2,1,1); imshow(im_adjust);
subplot(2,1,2); imhist(im_adjust); title('imadjust');

abc = alter_imadjust(a, 52, 210, 0, 255);
figure; 
subplot(2,1,1); imshow(abc);
subplot(2,1,2); imhist(abc); title('alter_imadjust');
