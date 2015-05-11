function SaveTrainingData(all_ftypes, train_inds, s_fn)

fdata = LoadImDataDir('../TrainingImages/FACES');
nfdata = LoadImDataDir('../TrainingImages/NFACES');

ii_ims = [fdata nfdata];
ys = [ones(1,size(fdata,2)) -ones(1,size(nfdata,2))];

W = 19;
H = 19;
fmat = VecAllFeatures(all_ftypes, W, H);
ii_ims = ii_ims(:, train_inds);
ys = ys(train_inds);
save(s_fn, 'ii_ims', 'ys', 'fmat', 'all_ftypes', 'W', 'H', 'train_inds');

end