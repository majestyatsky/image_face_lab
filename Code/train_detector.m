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
Tdata = load('training_data.mat');
% Cparams100_all = BoostingAlg(Tdata, T);
load('Cparams100.mat')
% for i = 1: length(Cparams.alphas)
%   fpic = MakeFeaturePic(Tdata.all_ftypes(Cparams.Thetas(i, 1), :), 19, 19);
%   figure
%   imagesc(fpic);
% end
% cpic = MakeClassifierPic(Tdata.all_ftypes, Cparams100.Cparams.Thetas(:, 1), Cparams100.Cparams.alphas,...
%   Cparams100.Cparams.Thetas(:, 3), 19, 19);
% figure
% imagesc(cpic)
% colormap(gray)
% 
% sum(abs(dinfo7.alphas' - Cparams.alphas) > eps)
% sum(abs(dinfo7.Thetas(:) - Cparams.Thetas(:)) > eps)

% profile viewer

ComputeROC(Cparams100.Cparams, Tdata)

% im = imread('../TestImages/one_chris.png');
% dets = ScanImageOverScale(Cparams10_all, im, 0.6, 1.3, 0.06);
% 
% fdets = PruneDetections(dets);
% DisplayDetections(im, fdets);