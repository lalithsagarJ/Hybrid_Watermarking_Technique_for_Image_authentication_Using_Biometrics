%% This function plots normlized correlation vs alpha
function [NC] = NC_alpha(cover_image,biometric,signature,method,alpha,beta,attacks,params)

NC = zeros(length(attacks), length(alpha));
for j=1:length(attacks)
    attack = string(attacks(j));
    param = params(j);
    for i=1:length(alpha)
        
        [FW,extpw,extsig] = watermark(cover_image,biometric,signature,method,alpha(i),beta,attack,param);
        NC(j,i) = nc(biometric,extpw);
    end
end
end