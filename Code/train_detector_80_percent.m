clc
clear all
close all

%% Get training data
load('fmat.mat')
load('all_ftypes.mat')

SaveTrainingData80PerCent(all_ftypes, 'training_data_80.mat', fmat);


%% Train Classifier

% profile clear
% profile on

T = 100;
Tdata = load('training_data_80.mat');
% tic
% Cparams100_80 = BoostingAlg(Tdata, T);
% toc
% load('Cparams100.mat')
% for i = 1: length(Cparams.alphas)
%   fpic = MakeFeaturePic(Tdata.all_ftypes(Cparams.Thetas(i, 1), :), 19, 19);
%   figure
%   imagesc(fpic);
% end
cpic = MakeClassifierPic(Tdata.all_ftypes, Cparams100_80.Thetas(:, 1), Cparams100_80.alphas,...
  Cparams100_80.Thetas(:, 3), 19, 19);
figure
imagesc(cpic)
% colormap(gray)
% 
% sum(abs(dinfo7.alphas' - Cparams.alphas) > eps)
% sum(abs(dinfo7.Thetas(:) - Cparams.Thetas(:)) > eps)

% profile viewer

ComputeROC(Cparams100_80, Tdata)

% im = imread('../TestImages/one_chris.png');
% dets = ScanImageOverScale(Cparams10_all, im, 0.6, 1.3, 0.06);
% 
% fdets = PruneDetections(dets);
% DisplayDetections(im, fdets);