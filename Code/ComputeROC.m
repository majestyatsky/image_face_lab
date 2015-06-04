function t = ComputeROC(Cparams, Tdata)

facesDir = '../TrainingImages/FACES/';
nonfacesDir = '../TrainingImages/NFACES/';
face_ii = LoadImDataDir(facesDir);
1
nonface_ii = LoadImDataDir(nonfacesDir);
2
all_images = [face_ii, nonface_ii];

total_im = size(all_images, 2);
face_im = size(face_ii, 2);
targets = ones(1, total_im);

targets(face_im + 1:end) = -1;

trinds = Tdata.train_inds;
total_inds = 1:total_im;

tstinds = setdiff(total_inds, trinds);

num_of_img = length(tstinds);
tstScores = zeros(num_of_img, 1);

for i = 1:num_of_img
  tstScores(i) = ApplyDetector(Cparams, all_images(:, tstinds(i)));
end

threshold = min(tstScores):0.15:max(tstScores);

g = targets(tstinds);
tps = zeros(length(threshold),1);
fps = zeros(length(threshold),1);
for t=1:length(threshold)
    a = tstScores > threshold(t);
    tps(t) = length(find(a == 1 & g' == 1));
    fps(t) = length(find(a == 1 & g' == -1));
end
figure
plot(fps / max(fps), tps / max(tps));
xlabel('fps');
ylabel('tpr');
title('ROC curve')

id = find(tps / max(tps) >= 0.7, 1, 'last');

t = threshold(id);

end