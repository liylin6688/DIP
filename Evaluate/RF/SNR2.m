function snr = SNR2(img_ref, img_in )
    % º∆À„‘Î…˘±»
    % img_ref :original signal
    % img_in:noisy signal
    % snr=10*log10(sigma2(I2)/sigma2(I2-I1))

    [~,~,nchannel]=size(I);
    snr=0;
    I=double(img_ref);
    In=double(img_in);
    if nchannel==1
        Ps=sum(sum((I-mean(mean(I))).^2));%signal power
        Pn=sum(sum((I-In).^2));%noise power
        snr=10*log10(Ps/Pn);
    elseif nchannel==3
        for i=1:3
            Ps=sum(sum((I(:,:,i)-mean(mean(I(:,:,i)))).^2));%signal power
            Pn=sum(sum((I(:,:,i)-In(:,:,i)).^2));%noise power
            snr=snr+10*log10(Ps/Pn);
        end
        snr=snr/3;
    end