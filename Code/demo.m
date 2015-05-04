clc
clear all
close all

%% Debug Point Program 1
% dinfo1 = load('/home/thomai/Dropbox/KTH/2nd Semester/2nd term/Image Based Recognition & Classification/image_face_lab/DebugInfo/debuginfo1.mat');
% eps = 10^(-6);
% 
[im, ii_im] = LoadIm('/home/thomai/Dropbox/KTH/2nd Semester/2nd term/Image Based Recognition & Classification/image_face_lab/TrainingImages/FACES/face00001.bmp');
% 
% s1 = sum(abs(dinfo1.im(:) - im(:)) > eps);
% s2 = sum(abs(dinfo1.ii_im(:) - ii_im(:)) > eps);
% 
% figure
% miN = min(min(im));
% maX = max(max(im));
% imshow((im - miN) / (maX - miN))
% 
% figure
% miN = min(min(ii_im));
% maX = max(max(ii_im));
% imshow((ii_im - miN) / (maX - miN))

%% Debug Point Program 2
x = 2;
y = 3;
w = 4;
h = 5;

b_vec = VecBoxSum(x, y, w, h, 19, 19);
A1 = b_vec * ii_im(:);
A2 = sum(sum(im(y:y + h - 1, x:x + w - 1)));