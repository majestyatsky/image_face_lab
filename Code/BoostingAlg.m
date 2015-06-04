function Cparams = BoostingAlg(Tdata, T)
disp('Initiate AdaBoost')

alphas = zeros(T, 1);
Thetas = zeros(T, 3);

[numFeats, ~] = size(Tdata.fmat);

m = sum(Tdata.ys == -1);
n = length(Tdata.ys);
%% Initialize weight
w = zeros(n, 1);
w(Tdata.ys == 1) = 1 / (2 * (n - m));
w(Tdata.ys == -1) = 1 / (2 * m);

%% Calculate features
Tdata.fmat = sparse(Tdata.fmat);
Tdata.ys = Tdata.ys';
fs = Tdata.fmat * Tdata.ii_ims;

%% Train weak classifiers
val_P = (1 + Tdata.ys);
val_N = (1 - Tdata.ys);
theta = zeros(numFeats, 1);
p = zeros(numFeats, 1);
err = zeros(numFeats, 1);

for t = 1:T
  t
  % Normalize weights
  w = w / sum(w);

  for feat = 1: numFeats
    %     disp(['feature: ' num2str(feat)])
    %% Learn weak classifier
    % Computing weighted mean of positive and negative examples
    denominator_P = sum(w .* val_P);
    denominator_N = sum(w .* val_N);
    nominator_P = sum(w .* fs(feat, :)' .* val_P);
    nominator_N = sum(w .* fs(feat, :)' .* val_N);
    mu_P = nominator_P / denominator_P;
    mu_N = nominator_N / denominator_N;
    
    %Setting theta
    theta(feat) = 0.5 * (mu_P + mu_N);
    
    % Computing error associated with the two possible parity values
    indx = (fs(feat, :) > theta(feat));
    err_N = sum(w(indx) .* abs(Tdata.ys(indx) - 1)); % p = -1
    err_P = sum(w(indx) .* abs(Tdata.ys(indx) + 1)); % p = 1
%     indx = (fs(feat, :) <= theta(feat));
    err_N = 0.5 * (err_N + sum(w(~indx) .* abs(Tdata.ys(~indx) + 1))); % p = -1
    err_P = 0.5 * (err_P + sum(w(~indx) .* abs(Tdata.ys(~indx) - 1))); % p = 1
    
    if err_N > err_P
      err(feat) = err_P;
      p(feat) = 1;
    else
      err(feat) = err_N;
      p(feat) = -1;
    end
    %% Learned Weak Classifier
  end
  
  [minErr, bestFeat] = min(err);
  Thetas(t, 1) = bestFeat;
  Thetas(t, 2) = theta(bestFeat);
  Thetas(t, 3) = p(bestFeat);
  
  alphas(t) = 0.5 * log((1 - minErr) / minErr);
  
  idx = (Thetas(t, 3) * (fs(Thetas(t, 1), :) - Thetas(t, 2)) < 0);
  lab = -1 * ones(1, n);
  lab(idx) = lab(idx) + 2;
  
  w = w .* exp(-alphas(t) * Tdata.ys .* lab');
end

Cparams = struct('alphas', alphas, 'Thetas', Thetas, 'fmat',...
  Tdata.fmat, 'all_ftypes', Tdata.all_ftypes);