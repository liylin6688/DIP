function total_YYL=YYL_algorithm(A)
    [image_width,image_height,~] = size(A); 
           total_YYL=0;
            for w=2:(image_width-1)                
                 for h=2:(image_height-1)                      
                    h1=uint32(A(w,h)); 
                    h2=uint32(A(w+1,h));                     
                    h3=uint32(A(w-1,h));
                    h4=uint32(A(w,h+1));
                    h5=uint32(A(w,h-1));
                    h6=uint32(A(w+1,h+1));
                    h7=uint32(A(w+1,h-1));
                    h8=uint32(A(w-1,h-1));
                    h9=uint32(A(w-1,h+1));                      
                    fir_pic(w-1,h-1)=(h1+h2+h3+h4+h5+h6+h7+h8+h9)/9;                    
                 end                  
            end    
               
          pointcount=0;
          rgbcount=0;                      
            for w=1:(image_width-3)                
                 for h=1:(image_height-3)                      
                    h1=uint32(fir_pic(w,h)); 
                    h2=uint32(fir_pic(w+1,h));
                    h3=uint32(fir_pic(w,h+1));
                    if abs(h1-h2)>10
                        pointcount= pointcount+1;
                        rgbcount=rgbcount+abs(h1-h2)*5;
                    end
                    if abs(h1-h3)>10
                        pointcount= pointcount+1;
                        rgbcount=rgbcount+abs(h1-h2)*5;
                    end                  
                 end 
            end        
            
                if pointcount>0
                   total_YYL=round(rgbcount/pointcount)*30;                      
                end
                if total_YYL<41
                   total_YYL=1;                      
                end    
                
                
                
                