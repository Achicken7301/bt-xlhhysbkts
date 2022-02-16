function BW=Thresh_holding(I,option,thresh_hold1,thresh_hold2) 
    switch nargin
    case 1
        option="Auto thresholding";
    case 2
        if(option~="Auto thresholding ")
                s = sprintf('Missing Input! Please add level with slider');
                questdlg(s,...
                'Error',...
                'OK','OK');
        end
    case 3
        if(isa(option,"double"))
            thresh_hold2=thresh_hold1;
            thresh_hold1=option;
            option="Multi level"
        end
        if option=="Multi level"
                s = sprintf('Missing Input! Please add level with slider');
                questdlg(s,...
                'Error',...
                'OK','OK');
        end        
    end
    if(~exist("thresh_hold1","var"))
        thresh_hold1=1;
    end
    if(~exist("thresh_hold2","var"))
        thresh_hold2=1;
    end
    thresh_hold1=thresh_hold1/255;  
    thresh_hold2=thresh_hold2/255;
    if(option=="Multi Level")
        if(thresh_hold1>thresh_hold2)
            temp=thresh_hold2;
            thresh_hold2=thresh_hold1;
            thresh_hold1=temp;
        end
    end
    switch(option)
        case"One Level"
            BW = imbinarize(I,thresh_hold1);
        case "Multi Level"
            BW1=imbinarize(I,thresh_hold1);
            BW2=imbinarize(I,thresh_hold2);
            BW=I.*uint8(xor(BW1,BW2));
        case "Auto thresholding "
            BW = imbinarize(I,graythresh(I));%Otsu method
    end
end