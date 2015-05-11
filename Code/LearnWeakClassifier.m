function [theta, p, err] = LearnWeakClassifier(ws, fs, ys)

%% Function LearnWeakClassifier:
%  Input: ws: vector of weights associated with each training image
%         fs: vector of value of a particular feature extracted from each
%         training image/ Feature response vector
%         ys: vector of the labels associted with each training image

%  Output: theta: threshold value
%          p: parity value
%          err: associated error

n = length(fs);

%%Computing weighted mean of positive and negative examples
denominator_P = ws * (1 + ys');
denominator_N = ws * (1 - ys');
nominator_P = sum(ws .* fs .* (1 + ys));
nominator_N = sum(ws .* fs .* (1 - ys));
mu_P = nominator_P / denominator_P;
mu_N = nominator_N / denominator_N;

%Setting theta
theta = 0.5 * (mu_P + mu_N);

%%Computing error associated with the two possible parity values
err_N = 0;
err_P = 0;
for i = 1:n
    err_N = err_N + (ws(i) * abs(ys(i) - WeakClassifier(fs(i), -1, theta)));
    err_P = err_P + (ws(i) * abs(ys(i) - WeakClassifier(fs(i), 1, theta)));
end

err_N = 0.5 * err_N;
err_P = 0.5 * err_P;

if err_N > err_P
    err = err_P;
    p = 1;
else
    err = err_N;
    p = -1;
end
    
end