function ComputeROC(Cparams, Tdata)

trinds = Tdata.train_inds;

tstinds = setdiff(1:size(Tdata.ii_ims, 2), trinds);

num_of_img = length(tstinds);
tstScores = zeros(num_of_img, 1);

for i = 1:num_of_img
  tstScores(i) = ApplyDetector(Cparams, Tdata.ii_ims(:, tstinds(i)));
end

threshold = min(tstScores):0.15:max(tstScores);

g = Tdata.ys(tstinds);
tps = zeros(length(threshold),1);
fps = zeros(length(threshold),1);
for t=1:length(threshold)
    a = tstScores > threshold(t);
    tps(t) = length(find(a == 1 & g' == 1));
    fps(t) = length(find(a == 1 & g' == -1));
end

plot(fps / max(fps), tps / max(tps));

id = find(tps / max(tps) >= 0.7, 1, 'last');

% tps / max(tps)
threshold(id)
% id

end