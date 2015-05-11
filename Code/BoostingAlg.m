function Cparams = BoostingAlg(Tdata, T)

disp('Initiate AdaBoost')

alphas = zeros(1, T);
Thetas = zeros(T, 3);

[numFeats, ~] = size(Tdata.fmat);
% numFeats
m = sum(Tdata.ys == -1);
n = length(Tdata.ys);
%% Initialize weight
w = zeros(1, n);
w(Tdata.ys == 1) = 1 / (2 * (n - m));
w(Tdata.ys == -1) = 1 / (2 * m);

%% Calculate features
fs = Tdata.fmat * Tdata.ii_ims;


%% Train weak classifiers
for t = 1:T
  disp(['Train weak classifier ' num2str(t)])
  % Normalize weights
  w = w / sum(w);
  theta = zeros(1, numFeats);
  p = zeros(1, numFeats);
  err = zeros(1, numFeats);
  
  for feat = 1: numFeats
    [theta(feat), p(feat), err(feat)] =...
      LearnWeakClassifier(w, fs(feat, :), Tdata.ys);
  end
  [minErr, bestFeat] = min(err);
  Thetas(t, 1) = bestFeat;
  Thetas(t, 2) = theta(bestFeat);
  Thetas(t, 3) = p(bestFeat);
  
  alphas(t) = 0.5 * log((1 - minErr) / minErr);

  for im = 1:n
    lab = WeakClassifier(fs(Thetas(t, 1), im), Thetas(t, 3), Thetas(t, 2));
    w(im) = w(im) * exp(-alphas(t) * Tdata.ys(im) * lab);
  end
  
end

Cparams = struct('alphas', alphas, 'Thetas', Thetas, 'fmat',...
  Tdata.fmat, 'all_ftypes', Tdata.all_ftypes);