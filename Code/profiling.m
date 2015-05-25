clc
clear all
close all

%% Train Classifier
profile clear
profile on


T = 10;
Tdata = load('training_data.mat');
Cparams = BoostingAlg(Tdata, T);
for i = 1: length(Cparams.alphas)
  fpic = MakeFeaturePic(Tdata.all_ftypes(Cparams.Thetas(i, 1), :), 19, 19);
  figure
  imagesc(fpic);
end
cpic = MakeClassifierPic(Tdata.all_ftypes, Cparams.Thetas(:, 1), Cparams.alphas,...
  Cparams.Thetas(:, 3), 19, 19);
figure
imagesc(cpic)

% sum(abs(dinfo7.alphas' - Cparams.alphas) > eps)
% sum(abs(dinfo7.Thetas(:) - Cparams.Thetas(:)) > eps)

profile viewer

%% Get threshold from ROC curve
Tdata = load('training_data.mat');
Cparams100 = load('Cparams100.mat');
ComputeROC(Cparams100.Cparams, Tdata)