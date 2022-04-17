clear all;
clc;
clear all;
clc;
%% Load file
[FileName, PathName, FilterIndex] = uigetfile('*.*', 'Select the MATLAB code file');
I = imread([PathName FileName]);

if size(I, 3) == 3
    I = rgb2gray(I);
end

J = imbinarize(I, graythresh(I));
figure; imshow(J)
%% Tim duong bien NST
[B, L] = bwboundaries(~J, 'noholes');
imshow(L); hold on

for i = 1:length(B)
    plot(B{i}(:, 2), B{i}(:, 1), 'LineWidth', 3)
    text(B{i}(1, 2), B{i}(1, 1), num2str(i), 'FontSize', 18, 'Color', 'red')
end

%% Get STAT value
STATS = regionprops(L, 'all');
for i = 1:length(STATS)
    vat(i, 1) = STATS(i).Area;
    vat(i, 2) = STATS(i).Perimeter;
    vat(i, 3) = STATS(i).Centroid(1);
    vat(i, 4) = STATS(i).Centroid(2);
end

%% d(n)
for i = 1:length(B)

    for j = 1:length(B{i})
        dn{i, 1}(j, 1) = sqrt((B{i}(j, 2) - vat(i, 3))^2 + (B{i}(j, 1) - vat(i, 4))^2);
    end

end

%% Co, Cf, mp1
for i = 1:length(vat)
    per = vat(i, 2);
    area = vat(i, 1);
    Co(i, 1) = per^2 / area;
    Cf(i, 1) = 1 - 4 * pi * area / per^2;
    mp1(i, 1) = mean(dn{i}(:, 1).^1);
end

%% mf
for i = 1:length(vat)
    tmp = ones(length(dn{i}), 1);
    tmp = tmp .* mp1(i);
    MP(i, 1) = mean((dn{i} - tmp).^1);
    MP(i, 2) = mean((dn{i} - tmp).^2);
    MP(i, 3) = mean((dn{i} - tmp).^3);
    MP(i, 4) = mean((dn{i} - tmp).^4);
end

for i = 1:length(vat)
    F(i, 1) = (MP(i, 2)^(1/2)) / mp1(i);
    F(i, 2) = (MP(i, 3)^(1/3)) / mp1(i);
    F(i, 3) = (MP(i, 4)^(1/4)) / mp1(i);
end

for i = 1:length(vat)
    mf(i, 1) = F(i, 3) - F(i, 1);
end

%% Ve Co, Cf, mf
vat_index = (1:length(vat))';
figure
scatter(vat_index, Co, 'd', 'filled')
title('Co')
legend('Co')
ax = gca;
ax.YGrid = 'on';
figure
scatter(vat_index, Cf, 'd', 'filled')
title('Cf')
legend('Cf')
ax = gca;
ax.YGrid = 'on';
figure
scatter(vat_index, mf, 'd', 'filled')
title('mf')
legend('mf')
ax = gca;
ax.YGrid = 'on';
%% Ve do thi moi lien he giua Co va Cf
figure
plot(sort(Co), sort(Cf))
title('Moi quan he cua Co va Cf')
ylabel('Cf')
xlabel('Co')
%% Save as .csv
data = {'Co', 'Cf', 'mf'};

for i = 1:length(vat)
    data{i + 1, 1} = Co(i);
    data{i + 1, 2} = Cf(i);
    data{i + 1, 3} = mf(i);
end

% Cell array to .csv ...
... https: // www.mathworks.com / matlabcentral / answers / 70018 - how - to - write - cell - array - into - a - csv - file
data = cell2table(data(2:end, :), 'VariableNames', data(1, :));

writetable(data, 'data.csv')
