function SaveTrainingData80PerCent(all_ftypes, s_fn, fmat)

fdata = LoadImDataDir('../TrainingImages/FACES');
1
nfdata = LoadImDataDir('../TrainingImages/NFACES');
2
ii_ims = [fdata nfdata];
ys = [ones(1,size(fdata,2)) -ones(1,size(nfdata,2))];
num_of_im = length(ys);

W = 19;
H = 19;
if (isempty(fmat))
  fmat = VecAllFeatures(all_ftypes, W, H);
end

% Calculate train_inds
K = 5;
Indices = crossvalind('Kfold', num_of_im, K);
test_ind = (Indices == 5);
temp = 1:num_of_im;
train_inds = temp(~test_ind);
ys = ys(~test_ind);
ii_ims = ii_ims(:, ~test_ind);

save(s_fn, 'ii_ims', 'ys', 'fmat', 'all_ftypes', 'W', 'H', 'train_inds');