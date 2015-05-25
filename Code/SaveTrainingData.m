function SaveTrainingData(all_ftypes, train_inds, s_fn, fmat)

fdata = LoadImDataDir('../TrainingImages/FACES');
nfdata = LoadImDataDir('../TrainingImages/NFACES');

ii_ims = [fdata nfdata];
ys = [ones(1,size(fdata,2)) -ones(1,size(nfdata,2))];

W = 19;
H = 19;
if (isempty(fmat))
  fmat = VecAllFeatures(all_ftypes, W, H);
end
if (train_inds ~= 0)
  % Use some faces
  ii_ims = ii_ims(:, train_inds);
  ys = ys(train_inds);
else
  % Use all faces
  train_inds = [1:size(ii_ims, 2)];
end


save(s_fn, 'ii_ims', 'ys', 'fmat', 'all_ftypes', 'W', 'H', 'train_inds');

end