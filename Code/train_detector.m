clc
clear all
close all

%% Get training data
load('fmat.mat')
load('all_ftypes.mat')

SaveTrainingData(all_ftypes, 0, 'training_data_all.mat', fmat);


%% Train Classifier
clc
clear all
close all
% profile clear
% profile on

T = 100;
Tdata = load('training_data_all.mat');
Cparams100_all = BoostingAlg(Tdata, T);
% for i = 1: length(Cparams.alphas)
%   fpic = MakeFeaturePic(Tdata.all_ftypes(Cparams.Thetas(i, 1), :), 19, 19);
%   figure
%   imagesc(fpic);
% end
% cpic = MakeClassifierPic(Tdata.all_ftypes, Cparams.Thetas(:, 1), Cparams.alphas,...
%   Cparams.Thetas(:, 3), 19, 19);
% figure
% imagesc(cpic)

% sum(abs(dinfo7.alphas' - Cparams.alphas) > eps)
% sum(abs(dinfo7.Thetas(:) - Cparams.Thetas(:)) > eps)

% profile viewer

Cparams100_all.thresh = ComputeROC(Cparams100_all, Tdata)

% im = imread('../TestImages/one_chris.png');
% dets = ScanImageOverScale(Cparams10_all, im, 0.6, 1.3, 0.06);
% 
% fdets = PruneDetections(dets);
% DisplayDetections(im, fdets);