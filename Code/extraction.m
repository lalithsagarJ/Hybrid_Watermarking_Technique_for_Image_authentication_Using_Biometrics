function [Expw, EXS] = extraction(alpha,beta,Final_watermark)
FileData = load(fullfile(tempdir, 'cS.mat'));
cS = FileData.cS;
FileData = load(fullfile(tempdir, 'pwU.mat'));
pwU = FileData.pwU;
FileData = load(fullfile(tempdir, 'pwV.mat'));
pwV = FileData.pwV;
FileData = load(fullfile(tempdir, 'BS.mat'));
BS = FileData.BS;
FileData = load(fullfile(tempdir, 'SU.mat'));
SU = FileData.SU;
FileData = load(fullfile(tempdir, 'SV.mat'));
SV = FileData.SV;

%% Extraction of Pwatermark from Final Watermark

[fLL, fLH, fHL, fHH] = dwt2(Final_watermark, 'haar');
dfLL = dct2(fLL);
[fU, fS, fV] = svd(dfLL);

Pw_s = (fS - cS)./beta;
w_hat = pwU * Pw_s * pwV';

Expw = uint8(w_hat);
imwrite(Expw,'Extracted_pw.png');

%% Extraction of Signature from Pwatermark
[pLL, pLH, pHL, pHH] = dwt2(Expw, 'haar');
Pw = dct2(pLL);
[ESU, ESS, ESV] = svd(Pw);
SS = (ESS - BS)./alpha;     %%

ExSS = SU*SS*SV';
EXS = uint8(ExSS);
imwrite(EXS,'ExSig.png');

% %% Display
% figure()
% subplot(1,2,1);imshow(Expw);title('Ext processes watermark');
% subplot(1,2,2);imshow(EXS);title('Extracted signature');