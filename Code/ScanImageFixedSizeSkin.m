function dets = ScanImageFixedSizeSkin(Cparams, inpImg)

%% Do image proccessing
if size(inpImg, 3) == 3
    im = rgb2gray(inpImg);
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
if ndims(inpImg) > 2
    [mask1, mask2, mask3]= getSkinColorModelMasks(inpImg);
    mask = mask1 & mask2 & mask3;
    mask = mask(1:end-L,1:end-L);
    Ind = find(mask);
else
    Id = 1:W - L;
    Jd = 1:H - L;
    Ind = sub2ind(size(im) - L, Id, Jd);
end
Ind = Ind';
% Using step 1, can change later
% for x = 1:W - L
%   for y = 1:H - L
for ind = Ind
    [y,x] = ind2sub(size(im)-L,ind);
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
    alphas = Cparams.alphas;
    chose_f = Cparams.Thetas(:,1);
    theta = Cparams.Thetas(:,2);
    p = Cparams.Thetas(:,3);
    
    ii_ims = ii_im(y:y + L - 1, x:x + L - 1);
    
    f = Cparams.fmat(chose_f, :) * ii_ims(:) / sigma;
    %% If feature is Type III add (w * h * mu / sigma)
    ind_III = (Cparams.all_ftypes(chose_f, 1) == 3);
    
    f(ind_III) = f(ind_III) + Cparams.all_ftypes(ind_III, 4) .*...
        Cparams.all_ftypes(ind_III, 5) * mu / sigma;
    
    lab = -1 * ones(length(Cparams.alphas), 1);
    idx = (p .* (f - theta) < 0);
    lab(idx) = lab(idx) + 2;
    scs = sum(alphas .* lab);
    
    if scs > Cparams.thresh
        dets = [dets; x y L L];
    end
end