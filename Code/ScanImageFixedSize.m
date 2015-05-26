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
% testing git
%% Search the image
[H, W] = size(im);
dets = cell((W - L) * (H - L), 1);
face = 0;
ind_III = (Cparams.all_ftypes(Cparams.Thetas(:,1), 1) == 3);
quantity = Cparams.all_ftypes(ind_III, 4) .* Cparams.all_ftypes(ind_III, 5);
% Using step 1, can change later
for x = 1:W - L
  for y = 1:H - L
    %% GET MEAN AND SIGMA
    %% Get two boxes
    box_ii_im = ii_im(y + L - 1, x + L - 1);
    box_ii_im_sq = ii_im_sq(y + L - 1, x + L - 1);
    if x ~= 1
      box_ii_im = box_ii_im - ii_im(y + L - 1, x - 1);
      box_ii_im_sq = box_ii_im_sq - ii_im_sq(y + L - 1, x - 1);
    end
    if y ~= 1
      box_ii_im = box_ii_im - ii_im(y - 1, x + L - 1);
      box_ii_im_sq = box_ii_im_sq - ii_im_sq(y - 1, x + L - 1);
    end
    if x ~= 1 && y ~= 1
      box_ii_im = box_ii_im + ii_im(y - 1, x - 1);
      box_ii_im_sq = box_ii_im_sq + ii_im_sq(y - 1, x - 1);
    end
    mu = box_ii_im / L^2;
    sigma = sqrt(abs((box_ii_im_sq - L^2 * mu^2) / (L^2 - 1)));
    
    %% APPLY ADAPTED DETECTOR
    ii_ims = ii_im(y:y + L - 1, x:x + L - 1);
    
    f = Cparams.fmat(Cparams.Thetas(:,1), :) * ii_ims(:) / sigma;
    %% If feature is Type III add (w * h * mu / sigma)
    f(ind_III) = f(ind_III) + quantity * mu / sigma;

    lab = -1 * ones(length(Cparams.alphas), 1);
    idx = (Cparams.Thetas(:,3) .* (f - Cparams.Thetas(:,2)) < 0);
    lab(idx) = lab(idx) + 2;
    scs = sum(Cparams.alphas .* lab);
    
    if scs > Cparams.thresh
      face = face + 1;
      dets{face} = [x y L L];
    end
  end
end
dets = vertcat(dets{:});