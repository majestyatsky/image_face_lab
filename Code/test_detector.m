clc
clear all
close all
%
% profile clear
% profile on

test_images = dir('../TestImages/');
Cparams100 = load('Cparams100.mat');
Cparams100 = Cparams100.Cparams100.Cparams;

% for im = 1:length(test_images)
% im = 4;
% if (~test_images(im).isdir)
% im_name = test_images(im).name;
%   im = imread(['../TestImages/' im_name]);
im = imread('../TestImages/Student4.jpg');
%   Cparams100.thresh = 5;
dets = ScanImageOverScale(Cparams100, im, 0.02, 0.4, 0.006);

fdets = PruneDetections(dets);
DisplayDetections(im, fdets);

% end
% end

% profile viewer