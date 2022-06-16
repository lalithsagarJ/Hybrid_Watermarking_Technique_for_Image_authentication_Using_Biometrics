%% This function plots normlized correlation vs beta
function [NC] = sigNC_beta(cover_image,biometric,signature,method,alpha,beta,attacks,params)

NC = zeros(length(attacks), length(beta));
for j=1:length(attacks)
    attack = string(attacks(j));
    param = params(j);
    for i=1:length(beta)
        
        [FW,extpw,extsig] = watermark(cover_image,biometric,signature,method,alpha,beta(i),attack,param);
        NC(j,i) = nc(signature,extsig);
    end
end
end