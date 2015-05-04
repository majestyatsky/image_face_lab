function SaveTrainingData(all_ftypes, train_inds, s_fn)

fdata = LoadImDataDir('TrainingImages\FACES');
nfdata = LoadImDataDir('TrainingImages\NFACES');

ii_ims = [fdata nfdata];
ys = [ones(1,size(fdata,2)) -ones(1,size(nfdata,2))];

%fmat = VecAllFeatures(all_ftypes, ii_ims(:,train_inds))
%save(s_fn,'ii_ims','ys','fmat','all_ftypes','W','H');

end