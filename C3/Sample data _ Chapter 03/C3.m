I=imread('CT.BMP');
J=watershed(I);
H=fspecial('gaussian',300,1);
K=filter2(H,I); %sau khi ?ã làm m?
K=uint8(K);
imshow(I)
improfile
figure;imshow(K)
improfile
Iw=watershed(I);
Kw=watershed(K);
figure;imshow(Iw);
figure;imshow(Kw);