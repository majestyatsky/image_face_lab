function scs = ApplyDetector(Cparams, ii_ims)

alphas = Cparams.alphas;
chose_f = Cparams.Thetas(:,1);
theta = Cparams.Thetas(:,2);
p = Cparams.Thetas(:,3);
scs = 0;

for i = 1:length(Cparams.alphas)
  f = Cparams.fmat(chose_f(i), :) * ii_ims(:); %Feature vector
  scs = scs + alphas(i) * WeakClassifier(f, p(i), theta(i));
end

end