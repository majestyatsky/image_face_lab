function r = ComputeROC(Cparams, Tdata)
trinds = Tdata.train_inds;
tstinds = setdiff(trinds, 1:size(Tdata.ii_ims,2));

tstScores = ApplyDetector(Cparams, Tdata.ii_ims(:,tstinds));

threshold = min(tstScores):0.3:max(tstScores);
g = Tdata.ys(tstinds);
tps = zeros(length(threshold),1);
fps = zeros(length(threshold),1);
for t=1:length(threshold)
    a = tstScores > threshold(t);
    tps(t) = length(find(a == 1 & g == 1));
    fps(t) = length(find(a == 1 & g == -1));
end

plot(fps,tps);

end