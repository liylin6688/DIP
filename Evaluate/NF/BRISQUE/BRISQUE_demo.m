% ========================================================================
% SSIM demo, Version 1.0
% Copyright(c) 2013 Jincao Yin
% All Rights Reserved.
%
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is hereby
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
%----------------------------------------------------------------------
%
% This is an implementation of the algorithm for calculating the
% Structural SIMilarity (SSIM) index between two images
%
% Please refer to the following paper and the website with suggested usage
%
% Z. Wang, A. C. Bovik, H. R. Sheikh, and E. P. Simoncelli, "Image
% quality assessment: From error visibility to structural similarity,"
% IEEE Transactios on Image Processing, vol. 13, no. 4, pp. 600-612,
% Apr. 2004.
%
% http://www.ece.uwaterloo.ca/~z70wang/research/ssim/
%
% Note: This program is different from ssim_index.m, where no automatic
% downsampling is performed. (downsampling was done in the above paper
% and was described as suggested usage in the above website.)
%
% Kindly report any suggestions or corrections to zhouwang@ieee.org
%========================================================================
clear all
clc
pub_path = '../../database/';

tid2008_db = 'tid2008/';
IVC_DB = 'IVC_SubQualityDB/';
a57_db = 'a57_db/images/';
CSIQ_DB = 'CSIQ_DB/';
LIVE_db = 'LIVE_db/';
toyama_db = 'toyama_db/';

k=menu('please choose a database' , 'tid2008_db' , 'IVC_DB' , 'a57_db' , 'CSIQ_DB' , 'LIVE_db' , 'toyama_db','×Ô¶¨Òå');
switch k
    case 1
        num = input('pelease choose a photo num range from 1 to 25:');
        while(num >25 || num < 1) 
            disp('photo num can not greater than 25 or less than 1,input again');
            num = input('pelease choose a photo num range from 1 to 25:');
        end
        if(num > 9)
            img1_path = [pub_path tid2008_db 'reference_images/I' int2str(num) '.BMP'];
            img2_path = [pub_path tid2008_db 'distorted_images/I' int2str(num) '_01_1.bmp'];
        else 
            img1_path = [pub_path tid2008_db 'reference_images/I0' int2str(num) '.BMP'];
            img2_path = [pub_path tid2008_db 'distorted_images/I0' int2str(num) '_01_1.bmp'];
        end
    case 2
        img1_path = [pub_path tid2008_db 'reference_images/I01.BMP'];
        img2_path = [pub_path tid2008_db 'distorted_images/I01_01_4.bmp'];
    case 3
        img1_path = [pub_path tid2008_db 'reference_images/I01.BMP'];
        img2_path = [pub_path tid2008_db 'distorted_images/I01_01_4.bmp'];
    case 4
        img1_path = [pub_path tid2008_db 'reference_images/I01.BMP'];
        img2_path = [pub_path tid2008_db 'distorted_images/I01_01_4.bmp'];
    case 5
        img1_path = [pub_path tid2008_db 'reference_images/I01.BMP'];
        img2_path = [pub_path tid2008_db 'distorted_images/I01_01_4.bmp'];
    case 6
        img1_path = [pub_path tid2008_db 'reference_images/I01.BMP'];
        img2_path = [pub_path tid2008_db 'distorted_images/I01_01_2.bmp'];
    case 7
        img1_path = 'testimage1.bmp';
        img2_path = 'testimage2.bmp';
end

img1 = imread(img1_path);
img2 = imread(img2_path);

if isrgb(img1)
    img1 = rgb2gray(img1);
end

if isrgb(img2)
    img2 = rgb2gray(img2);
end

quality = (100 - brisquescore(img2) )/100  %score [0-1]
%quality = biqi(img2)
