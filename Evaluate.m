function [ eval_COMENTROPY, eval_UCIQE, eval_UIQM ,difinition, smoothness, uniformity, saturation, entropy] = Evaluate( input_M )
    eval_COMENTROPY = COMENTROPY(input_M);
    eval_UCIQE = UCIQE(input_M);
    eval_UIQM = UIQM(input_M);
    [difinition, smoothness, uniformity, saturation, entropy] = getBasicParam(input_M);
end

