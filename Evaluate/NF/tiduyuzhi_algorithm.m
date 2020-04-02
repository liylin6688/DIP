function total_tiduyuzhi=tiduyuzhi_algorithm(A)
    [image_width,image_height,~] = size(A); 
    ff4=uint32(0) ;
    for w=2:(image_width-1)
        for h=2:(image_height-1)
            h1=uint32(A(w,h));
            h2=uint32(A(w+1,h));
            h3=uint32(A(w-1,h));
            h4=uint32(A(w,h+1));
            h5=uint32(A(w,h-1));
            ff4=uint32(h2+h3+h4+h5-4*h1)+ uint32(ff4);
        end
    end
    total_tiduyuzhi=ff4;