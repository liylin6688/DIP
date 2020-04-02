function total_fangcha=fangcha_algorithm(A)
    [image_width,image_height,~] = size(A);     
    ff2=uint32(0);
    tt1=uint32(0);
    Aver_val=0;
    
    for w=1:image_width
        for h=1:image_height
            tt1=uint32(A(w,h)) + uint32(tt1);
        end
    end
    Aver_val=tt1/(image_width *image_height);
    for w=1:(image_width)
        for h=1:(image_height)
            h2=uint32(A(w,h));
            ff2=uint32(h2)+ uint32(ff2)- uint32(Aver_val);
        end
    end
    total_fangcha=ff2;
   