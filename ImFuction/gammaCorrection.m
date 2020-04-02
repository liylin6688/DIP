function s = gammaCorrection(r, a, gamma)
     r=im2double(r);                
     s = a * (r .^ gamma);
end