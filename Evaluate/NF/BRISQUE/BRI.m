function [brisque]=BRI(I)
     %I = rgb2gray(I);
     brisque = (100 - brisquescore(I))/100  %score [0-1]
    
%     brisque=brisquescore(I);
end
