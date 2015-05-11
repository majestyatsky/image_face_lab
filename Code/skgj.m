for i = 1:10
  fpic = MakeFeaturePic(Tdata.all_ftypes(Cparams.Thetas(i, 1), :), 19, 19);
  figure
  imagesc(fpic);
end



cpic = MakeClassifierPic(Tdata.all_ftypes, Cparams.Thetas(:, 1), Cparams.alphas,...
  Cparams.Thetas(:, 3), 19, 19);
figure
imagesc(cpic)