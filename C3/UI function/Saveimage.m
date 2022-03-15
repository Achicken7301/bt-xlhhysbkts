function Saveimage(image)
try
    [fullFileName, folder] = uiputfile('.png');      % Set defailt name
    imwrite(image, fullFileName);           % Save iamge
    s = sprintf('Your image in the folder: %1$s', folder);
    questdlg(s,...
        'Save Image Successfully',...
        'OK','OK');
catch
    s = sprintf('Image not found!');
    questdlg(s,...
        'Error',...
        'OK','OK');
end
end