function total_Benner=Benner_algorithm(A)
    [image_width,image_height,~] = size(A);
    ff5=0 ;
    for w=2:(image_width-2)
        for h=2:(image_height-1)
            h1=uint32(A(w,h));
            h2=uint32(A(w+2,h));
            ff5=uint32((h1-h2)^2)+ uint32(ff5);

        end
    end
    total_Benner=ff5;