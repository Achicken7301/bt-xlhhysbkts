%%
addpath('H:\My Drive\Khang\BK\212\AS3055 - xlhhysbkts\Sample data _ Chapter 04');
addpath('H:\My Drive\Khang\BK\212\AS3055 - xlhhysbkts\Sample data _ Chapter 03');
addpath('H:\My Drive\Khang\BK\212\AS3055 - xlhhysbkts\BTL');

%% Doc anh vào
I = imread('anhCoMachMau.jpg');
if size(I, 3) == 3
    I = rgb2gray(I);
end

figure, imshow(I), title('Anh goc');

%% L?y biên
[BWs, nguong] = edge(I, 'sobel'); %l?y giá tr? ng??ng t? ??ng
heso = .5;
BWs = edge(I,'sobel', nguong*heso); %gi?m giátr? ng??ng t???ng ?i 1/2 ?? l?y nhi?u biên h?n
figure, imshow(BWs), title('Mat na chua bien');

%% Làm dày biên lên bang ky thuat “Dilate”
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
figure, imshow(BWsdil), title('Mat na chua bien duoc lam day len');

%% Làm day cac lo trong
BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill), title('Làm day cac lo trong');

%% bo di cac thanh phan sat o bien
BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('bo di cac thanh phan sat o bien');

%% Làm muot biên
seD = strel('diamond',1); %seD = strel('square',3);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal), title('Làm muot biên');

%% Ve duong bien mau trang va hien thi anh len ket qua
BWoutline = bwperim(BWfinal);
Segout = I;
Segout(BWoutline) = 255;
figure, imshow(Segout), title('Te bao duoc xac dinh');

%% region growing
I = im2double(imread('live.jpg'));
x=168; y=158;
J = regiongrowing(I,x,y,0.2); 
figure, imshow(I+J);
