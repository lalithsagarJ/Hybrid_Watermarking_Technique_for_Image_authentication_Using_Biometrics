%% This function apply watermarking based on different methods
%  inputs: orginal image, watermark image, watermarking method, applied 
%  attack
%  Output: watermarked image, extracted watermark image considering attacks

function [Final_watermark, extpw, extsig] = watermark(cover_image,biometric,signature,method,alpha,beta,attack,param)
switch method
    case 'DWT-SVD'
        [Final_watermark, extpw, extsig] = ddwt_svd(cover_image,watermark_logo,alpha,beta,attack,param);
    case 'DWT-HD-SVD'
        [watermarked_image, extracted_watermark] = dwt_hd_svd(cover_image,watermark_logo,alpha,attack,param);
    case 'DWT-DCT-SVD'
        [Final_watermark, extpw, extsig] = dwt_dct_svd(cover_image,biometric,signature,alpha,beta,attack,param);
    case 'RDWT-SVD'
        [watermarked_image, extracted_watermark] = lwt_svd(cover_image,watermark_logo,alpha,attack,param);
    otherwise
        errordlg('Please specify a method!');
end
end
