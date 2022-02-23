%% load file
[filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
if isequal(filename,0) || isequal(pathname,0)%help uigetfile
   disp('User pressed cancel')
else
    filename = [pathname filename];
    im = imread(filename);
%  Check if RGB
   if size(im, 3) == 3
        im = rgb2gray(im);
   end
end
%% one level
oneLevel = imbinarize(im, 50/255);
%% hien thanh tren slider
slider_value = 2;
y = [0:10];
x = ones(1, length(y));
z = x.*slider_value;
object = plot(z, y);
% kiem tra neu object = empty thi ve~ duong`
% con object =/= empty thi dieu chinh gia tri XData cua object
% if (isempty(object))
%     plot(y, z);
% else
%     set(object, 'XData', z);
% end
hold on;
imhist(im);
%% two level
th1 = imbinarize(im, 20/255);
th2 = imbinarize(im, 150/255);
twoLevel = im.*uint8(xor(th1, th2));
imshow(twoLevel);
%% Auto level