clc
clear all
close all
%
% profile clear
% profile on

load('Cparams100.mat');
Cparams100 = Cparams100.Cparams;

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



im = imread('../TestImages/IMG_0196.jpg');
% im = imresize(im,0.2);
% im = rot90(im);
% Cparams100.thresh = 3;
tic
dets = ScanImageOverScale1(Cparams100, im, 0.2, 0.6, 0.06);
toc
DisplayDetections(im, dets);
fdets = PruneDetections(dets);
DisplayDetections(im, fdets);
