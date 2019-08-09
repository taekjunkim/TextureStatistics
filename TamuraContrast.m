function ContrastIndex = TamuraContrast(imgMtx)
%%% compute tamura feature - coarseness
%%% CoarseIndex = TamuraCoarse(imgMtx,pixSize);
%%% imgMtx: input image. Square, grayscale, resolution of pixSize x pixSize
%%% Taekjun Kim, 1-21-2016

if max(max(imgMtx))<=1, imgMtx = imgMtx*255; end

[counts,graylevels] = imhist(uint8(imgMtx));
gValues = [];
for n=1:length(graylevels)
   if counts(n)>0
      gValues = [gValues ones(1,counts(n))*graylevels(n)];
   end
end
ContrastIndex = std(gValues)/(kurtosis(gValues)^(1/4));


