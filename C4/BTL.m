%% load images
im = 'H:\My Drive\Khang\BK\212\AS3055 - xlhhysbkts\bt-xlhhysbkts\C4\Sample data _ Chapter 04/karyotype.jpg';
im = imread(im);

%% Dat nguong cho anh
J = imbinarize(im, graythresh(im));

%% Tim tat ca duong bien cua cac NST
[B, L] = bwboundaries(~J, 'noholes');
imshow(L); hold on
for i=1:length(B)
    plot(B{i}(:,2),B{i}(:,1),'LineWidth',3)
    text(B{i}(1,2),B{i}(1,1),num2str(i),'FontSize',18,'Color','red')
end

