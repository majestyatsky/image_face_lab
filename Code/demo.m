clc
clear all
close all

% %% Debug Point Program 1
% % dinfo1 = load('/home/thomai/Dropbox/KTH/2nd Semester/2nd term/Image Based Recognition & Classification/image_face_lab/DebugInfo/debuginfo1.mat');
% eps = 10^(-6);
% % 
% [im, ii_im] = LoadIm('../TrainingImages/FACES/face00001.bmp');
% % 
% % s1 = sum(abs(dinfo1.im(:) - im(:)) > eps);
% % s2 = sum(abs(dinfo1.ii_im(:) - ii_im(:)) > eps);
% % 
% % figure
% % miN = min(min(im));
% % maX = max(max(im));
% % imshow((im - miN) / (maX - miN))
% % 
% % figure
% % miN = min(min(ii_im));
% % maX = max(max(ii_im));
% % imshow((ii_im - miN) / (maX - miN))
% 
% %% Debug Point Program 2
% % x = 2;
% % y = 3;
% % w = 4;
% % h = 5;
% % 
% % b_vec = VecBoxSum(x, y, w, h, 19, 19);
% % A1 = b_vec * ii_im(:);
% % A2 = sum(sum(im(y:y + h - 1, x:x + w - 1)));
% 
% %% Debug Point Program 3
% x = 2;
% y = 4;
% w = 3;
% h = 5;
% ftype_vec = VecFeature([4, x, y, w, h], 19, 19);
% A1 = ftype_vec * ii_im(:);
% % b0 = sum(sum(im(y:y+h-1, x:x+w-1)));
% % b1 = sum(sum(im(y+h:y+2*h-1, x:x+w-1)));
% % b0 = sum(sum(im(y:y+h-1, x:x+w-1)));
% % b1 = sum(sum(im(y:y+h-1, x+w:x+2*w-1)));
% % b0 = sum(sum(im(y:y+h-1, x:x+w-1)));
% % b1 = sum(sum(im(y:y+h-1, x+w:x+2*w-1)));
% % b2 = sum(sum(im(y:y+h-1, x+2*w:x+3*w-1)));
% % b0 = sum(sum(im(y:y+h-1, x:x+w-1)));
% % b1 = sum(sum(im(y+h:y+2*h-1, x:x+w-1)));
% % b2 = sum(sum(im(y:y+h-1, x+w:x+2*w-1)));
% % b3 = sum(sum(im(y+h:y+2*h-1, x+w:x+2*w-1)));
% % A2 = - b0 + b1 + b2 - b3;
% % dinfo2 = load('../DebugInfo/debuginfo2.mat');
% % fs = dinfo2.fs; W=19; H=19;
% % abs(fs(1) - VecFeature(dinfo2.ftypes(1, :), W, H)* ii_im(:)) > eps
% % abs(fs(2) - VecFeature(dinfo2.ftypes(2, :), W, H)* ii_im(:)) > eps
% % abs(fs(3) - VecFeature(dinfo2.ftypes(3, :), W, H)* ii_im(:)) > eps
% % abs(fs(4) - VecFeature(dinfo2.ftypes(4, :), W, H)* ii_im(:)) > eps
% 
% %% Debug Point Program 4
% res = EnumAllFeatures(19, 19);
% 
% %% Debug Point Program 5
% dinfo3 = load('../DebugInfo/debuginfo3.mat');
% fmat = VecAllFeatures(dinfo3.all_ftypes, 19, 19);
% sum(abs(dinfo3.fs - fmat * ii_im(:)) > eps);
% 
% %% Debug Point Program 6
% % test = LoadImDataDir('../TrainingImages/FACES', 100);
% dinfo4 = load('../DebugInfo/debuginfo4.mat');
% ni = dinfo4.ni;
% ii_ims = LoadImDataDir('../TrainingImages/FACES', ni);
% fmat = VecAllFeatures(dinfo4.all_ftypes, 19, 19);
% 
% sum(sum(dinfo4.fmat - fmat)) > eps
% sum(sum(dinfo4.ii_ims - ii_ims)) > eps
% sum(sum(dinfo4.fs - fmat * ii_ims)) > eps
% 
% %% Debug Point Program 7
% dinfo5 = load('../DebugInfo/debuginfo5.mat');
% train_inds = dinfo5.train_inds;
% all_ftypes = dinfo5.all_ftypes;
% SaveTrainingData(all_ftypes, train_inds, 'training_data.mat');

% %% Debug Point Program 8
% load('training_data.mat')
% fs = fmat(12028, :) * ii_ims;
% ws = ones(1, length(fs)) / length(fs);
% [theta, p, err] = LearnWeakClassifier(ws, fs, ys);
% a = fs(ys == 1);
% h = histogram(a, 'Normalization', 'probability');
% f = figure;
% plot(h.BinEdges(1:end-1), h.Values)
% figure
% a = fs(ys == -1);
% h = histogram(a, 'Normalization', 'probability');
% figure(f)
% hold on
% plot(h.BinEdges(1:end-1), h.Values)
% y = 0:max(h.Values) / 50:max(h.Values);
% x = ones(1, length(y)) * theta;
% plot(x, y)

%% Debug Point Program 9
fpic = MakeFeaturePic([1, 3, 3, 5, 5], 19, 19);
imagesc(fpic)