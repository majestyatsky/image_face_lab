function dets = ScanImageFixedSize(Cparams, im)

%% Do image proccessing
if size(im, 3) == 3
  im = rgb2gray(im);
end
im = double(im);
im = (im / max(max(im)));
im_square = im .* im;

temp = integralImage(im);
ii_im = temp(2:end, 2:end);
temp = integralImage(im_square);
ii_im_sq = temp(2:end, 2:end);

%% REMEMBER TO USE APPLYDETECTORADAPTED
L = 19;

%% Search the image
[H, W] = size(im);
dets = [];
% Using step 1, can change later
for x = 1:W - L 
  for y = 1:H - L 
    [mu, sigma] = getMeanSigma(ii_im, ii_im_sq, L, x, y);
    %% Get Box
    score = ApplyDetectorAdapted(Cparams, ii_im(y:y + L - 1, x:x + L - 1), mu, sigma);
%     score
    if score > Cparams.thresh
      dets = [dets; x y L L];
    end
  end
end