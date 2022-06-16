%% This function calculates the Structural Similarity Index (SSIM) for different alphas
%  SSIM compares the similarity of watermarked image and orginal image

function [SSIM] = SSIM_alpha(cover_image,biometric,signature,method,alpha,beta,attacks,params)

SSIM = zeros(length(attacks), length(alpha));
for j=1:length(attacks)
    attack = string(attacks(j));
    param = params(j);
    for i=1:length(alpha)
        [Final_watermark, extpw, extsig] = watermark(cover_image,biometric,signature,method,alpha(i),beta,attack,param);
        SSIM(j,i) = ssim(extpw,biometric);
    end
end
end