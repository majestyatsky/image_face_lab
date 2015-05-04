 function [im, ii_im] = LoadIm(im_fname)
 
%% Function LoadIm:
%  Input: im_fname: image name (prefferably absolute path)
%  Output: im: Normalized Image
%          ii_im: Integral Image

%% Load Image
im = imread(im_fname);
im = double(im);

%% Normalize
mu = mean(im(:));
sigma = std(im(:));
im = im - mu;
if sigma ~= 0
  im = im / sigma;
end

%% Calculate Integral Image
temp = integralImage(im);
ii_im = temp(2:end, 2:end);