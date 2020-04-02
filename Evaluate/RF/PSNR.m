function [ PSNR, MSE ] = PSNR( img_ref, img_in )     
    %   img_ref is a high reference quality image
    %   img_in is the denoise image
    %   pnsr_result is the PSNR of the denoise image
    width = size(img_ref,2);
    heigh = size(img_ref,1);
    if( width ~= size(img_in,2) || heigh ~= size(img_in,1) )
        disp('Please check whether the input image and reference image have same size');
        return
    end
    [a,b]=size(img_ref);
    XX=double(img_ref) - double(img_in);
    MSE = sum(sum( XX.^2 ))/(a*b);
    PSNR = 10*log10( 255*255 / MSE );
end

