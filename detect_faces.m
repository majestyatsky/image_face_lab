function [] = detect_faces(image_path)

addpath('Code/')
load('Cparams_100.mat');

image = imread(image_path);
tic
dets = ScanImageOverScale1(Cparams_100, image, 0.6, 1.3, 0.06);
toc

fdets = PruneDetections(dets);
DisplayDetections(image, fdets)