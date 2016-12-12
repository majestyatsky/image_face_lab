function SaveTrainingData(all_ftypes, train_inds, s_fn, varargin)
%% Read and create data needed for training.
%  fdata/nfdata: face and non-face integral images
%  ys: labels for the images: 1 face, -1 non-face
%  fmat: all possible features for the images
%  train_inds: indices of images used for training
%  ================================================
%  Save data to file s_fn

fdata = LoadImDataDir('../TrainingImages/FACES');
nfdata = LoadImDataDir('../TrainingImages/NFACES');

ii_ims = [fdata nfdata];
ys = [ones(1, size(fdata, 2)), - ones(1, size(nfdata, 2))];

W = 19;
H = 19;
if (isempty(varargin))
  fmat = VecAllFeatures(all_ftypes, W, H);
else
  fmat = varargin;
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
