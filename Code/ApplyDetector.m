function scs = ApplyDetector(Cparams, ii_ims)
alphas = Cparams.alphas;
chose_f = Cparams.Thetas(:,1);
theta = Cparams.Thetas(:,2);
p = Cparams.Thetas(:,3);
scs = 0;

f = fmat * ii_ims(:); %Feature vector

for i = 1:size(Cparams.alphas)
    scs = scs + alphas(i) * WeakClassifier(f(chose_f(i)),p(i),theta(i));
end

end