function scs = ApplyDetectorAdapted(Cparams, ii_ims, mu, sigma)

alphas = Cparams.alphas;
chose_f = Cparams.Thetas(:, 1);
theta = Cparams.Thetas(:, 2);
p = Cparams.Thetas(:, 3);
scs = 0;

for i = 1:length(Cparams.alphas)
  f = Cparams.fmat(chose_f(i), :) * ii_ims(:) / sigma; % Feature vector
  %% If feature is Type II add wh / mu
  if (Cparams.all_ftypes(chose_f(i), 1) == 3)
    f = f + Cparams.all_ftypes(chose_f(i), 4) *...
      Cparams.all_ftypes(chose_f(i), 5) * mu / sigma;
  end
  scs = scs + alphas(i) * WeakClassifier(f, p(i), theta(i));
end
