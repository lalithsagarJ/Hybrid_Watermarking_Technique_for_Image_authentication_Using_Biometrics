%% This function calculates PSNR of orginal image and watermarked image
%  PSNR is used to evaluated robustness of methods
function [PSNR] = PSNR_beta(cover_image,biometric,signature,method,alpha,beta,attacks,params)

PSNR = zeros(length(attacks), length(beta));
for j=1:length(attacks)
    attack = string(attacks(j));
    param = params(j);
    for i=1:length(beta)
        [Final_watermark, extpw, extsig] = watermark(cover_image,biometric,signature,method,alpha,beta(i),attack,param);
        PSNR(j,i) = psnr(extsig,signature);
    end
end
end