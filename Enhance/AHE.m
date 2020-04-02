function [ img_Mout ]  =  AHE( img_Min )
    I1 = img_Min;
    n = 100;
    channelCount = size(I1 ,3);
    for l = 1:channelCount
        I = I1(:,:,l);
        r = floor((n - 1)/2);
        minI = min(min(I));
        maxI = max(max(I));
        step = (maxI - minI) / (256 - 1);
        H = zeros(256,1);
        [height width] = size(I);
        out = zeros(height, width);
        area = 0;
        for j=1:height
            % Find height of addition/subtraction boxes.
            lowj = max(1, j - r);
            highj = min(height, j + r);
            % Iterate over width.  Extra padding dependent on window size.
            for i=(-r+1):(width+r+1)
                % Find the line that is no longer part of our window.
                subi = i - r - 1;
                % Add new line to window.
                addi = i + r;
                % Remove pixels on the left edge.
                if ( subi >= 1 )
                    % Create histogram, don't scale.
                    for jj = lowj:highj
                        idx = floor(I(jj, subi) / step) + 1;
                        H(idx) = H(idx) - 1;
                    end
                    % Modify histogram size (for later scaling).
                    area = area - (highj - lowj + 1);
                end
                % Add pixels on the right edge.
                if ( addi <= width )
                    % Create histogram, don't scale.
                    for jj = lowj:highj
                        idx = floor(I(jj, addi) / step) + 1;
                        H(idx) = H(idx) + 1;
                    end
                    % Modify histogram size (for later scaling).
                    area = area + (highj - lowj + 1);
                end
                if ( i >= 1 && i <= width )
                    % Update pixel value.
                    idx = floor(I(j, i) / step) + 1;
                    val = 0;
                    % Determine CDF value on the fly from PDF.
                    for k=1:(idx-1)
                        val = val + H(k);
                    end
                    % Convert to true CDF value.
                    val = (val / area) * (256 - 1);
                    out(j, i) = val;
                end
            end

        end
        out1(:,:,l) = out;
    end
    % Scale to viewable range.
    img_Mout = out1 / 256 ;
end

