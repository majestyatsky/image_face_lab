function t = ComputeROC(Cparams, Tdata)
%% Calculate scores for a number of testing images
%  Find a good threshold to use to divide the scores into face-nonface
%  Produce ROC curve


facesDir = '../TrainingImages/FACES/';
nonfacesDir = '../TrainingImages/NFACES/';
face_ii = LoadImDataDir(facesDir);
disp('Face images loaded')
nonface_ii = LoadImDataDir(nonfacesDir);
disp('non-face images loaded')

all_images = [face_ii, nonface_ii];
total_im = size(all_images, 2);
face_im = size(face_ii, 2);

labels = ones(1, total_im);
labels(face_im + 1:end) = -1;

tr_inds = Tdata.train_inds;
total_inds = 1:total_im;
tst_inds = setdiff(total_inds, tr_inds);

test_ii_ims = all_images(:, tst_inds);
test_labels = labels(tst_inds);

tstScores = ApplyDetector(Cparams, test_ii_ims);
disp('Score obtained')

threshold = min(tstScores):0.15:max(tstScores);

tpr = zeros(length(threshold), 1);
fpr = zeros(length(threshold), 1);
for t = 1:length(threshold)
    a = tstScores > threshold(t);
    tp = sum(a == 1 & test_labels == 1);
    fp = sum(a == 1 & test_labels == -1);
    tn = sum(a == 0 & test_labels == -1);
    fn = sum(a == 0 & test_labels == 1);
    tpr(t) = tp / (tp + fn);
    fpr(t) = fp / (tn + fp);
end
figure
plot(fpr, tpr);
xlabel('fpr');
ylabel('tpr');
title('ROC curve')

id = find(tpr >= 0.7, 1, 'last');
t = threshold(id)