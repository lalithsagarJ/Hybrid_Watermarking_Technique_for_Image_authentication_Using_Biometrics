%% This function applies DWT-DCT-SVD watermarking method

function [Final_watermark, extpw, extsig] = dwt_dct_svd(cover_image,biometric,signature,alpha,beta,attack,param)
%% Embedding
%%Signature into Biometric
[BLL, BLH, BHL, BHH] = dwt2(biometric, 'haar');
J = dct2(BLL);
[BU, BS, BV] = svd(J, 'econ');
save(fullfile(tempdir, 'BS.mat'), 'BS', '-mat');    %save

% Apply SVD to Signature
[SU, SS, SV] = svd(double(signature), 'econ');
save(fullfile(tempdir, 'SU.mat'), 'SU', '-mat');    %save
save(fullfile(tempdir, 'SV.mat'), 'SV', '-mat');    %save

New_BS = BS + alpha.*SS;
MBS = BU * New_BS * BV';
New_LL = idct2(MBS);

Processed_watermark = idwt2(New_LL, BLH, BHL, BHH, 'haar');
Processed_watermark = uint8(Processed_watermark);

imwrite(Processed_watermark,'Pwatermark.png');

%% embed pwatermark into cover image

[CLL, CLH, CHL, CHH] = dwt2(cover_image, 'haar');
DLL = dct2(CLL);
[cU, cS, cV] = svd(DLL, 'econ');
save(fullfile(tempdir, 'cS.mat'), 'cS', '-mat');    %save

[pwU, pwS, pwV] = svd(double(Processed_watermark),'econ');
save(fullfile(tempdir, 'pwU.mat'), 'pwU', '-mat');  %save
save(fullfile(tempdir, 'pwV.mat'), 'pwV', '-mat');  %save
HSw = cS + beta.*pwS;
H = cU * HSw * cV';
CLL_new = idct2(H) ;

Final_watermark = idwt2(CLL_new, CLH, CHL, CHH, 'haar');
Final_watermark = uint8(Final_watermark);
imwrite(Final_watermark,'FinalWatermarked.png');


%% Attacks
Final_watermark = Attacks(Final_watermark,attack,param);

%% Watermark Extraction

[extpw, extsig]= extraction(alpha,beta,Final_watermark);
end
