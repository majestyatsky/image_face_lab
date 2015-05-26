clc
clear all
close all
%
% profile clear
% profile on

load('Cparams100_80.mat');
% Cparams100 = Cparams100.Cparams;

% im = imread('../TestImages/one_chris.png');
% Cparams.thresh = 1.9;
% tic
% dets = ScanImageFixedSize(Cparams, im);
% toc
% % tic
% % dets = ScanImageOverScale1(Cparams100, im, 0.02, 0.4, 0.006);
% % toc
% DisplayDetections(im, dets);
% fdets = PruneDetections(dets);
% DisplayDetections(im, fdets);



im = imread('../TestImages/akash.jpg');
im = imresize(im, 0.2);
% Cparams.thresh = 3;
tic
dets = ScanImageOverScale1(Cparams100_80, im, 0.2, 0.8, 0.06);
toc
DisplayDetections(im, dets);
fdets = PruneDetections(dets);
DisplayDetections(im, fdets);
