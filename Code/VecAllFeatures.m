function fmat = VecAllFeatures(all_ftypes, W, H)

nf = size(all_ftypes, 1);
fmat = zeros(nf, W * H);

for feat = 1:nf
  fmat(feat, :) = VecFeature(all_ftypes(feat, :), W, H);
end
