function total_energy=energy_algorithm(A)
    [image_width,image_height,~] = size(A);      
    ff=uint32(0);
    for w=1:(image_width -1)
        for h=1:(image_height-1)
            h1=uint32(A(w+1,h));
            h2=uint32(A(w,h));
            h3=uint32(A(w,h+1));
            ff=uint32((h1-h2)*(h1-h2)+(h3-h2)*(h3-h2))+ uint32(ff);
        end
    end
    total_energy=ff;