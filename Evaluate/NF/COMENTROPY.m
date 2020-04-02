function total_shang = COMENTROPY(A)
    [image_width,image_height,~] = size(A);
    ff3=0 ;
    h1=double(0);
    h2=double(0);
    for w=1:image_width
        for h=1:image_height
            h1=A(w,h);
            if h1>0
                h2=-double(h1)*log(abs(double(h1)));
                ff3=double(h2)+ double(ff3);
            end
        end
    end
    total_shang=ff3;
            
            