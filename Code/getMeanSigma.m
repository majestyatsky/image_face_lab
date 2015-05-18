function [mu, sigma] = getMeanSigma(ii_im, ii_im_sq, L, x, y)

%% Get two boxes
% b_vec1 = VecBoxSum(x, y, L, L, size(ii_im, 1), size(ii_im, 2));
% box_ii_im = b_vec1 * ii_im(:)
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

% b_vec2 = VecBoxSum(x, y, L, L, size(ii_im_sq, 1), size(ii_im_sq, 2));
% box_ii_im_sq = b_vec2 * ii_im_sq(:);

%% Get mu and sigma
mu = box_ii_im / L^2;
sigma = sqrt(abs((box_ii_im_sq - L^2 * mu^2) / (L^2 - 1)));