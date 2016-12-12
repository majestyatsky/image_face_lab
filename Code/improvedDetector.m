function improvedDetector(img_name)

%% Initialize
C = load('Cparams100_80.mat');
Cparams100_80 = C.Cparams100_80;

im_orig = imread(img_name);
min_s = 0.2;
max_s = 1.3;
step_s = 0.006;
scs = min_s:step_s:max_s;
dets = cell(length(scs),1);

%% Get Skin regions
[skin, ~, ~, ~] = getSkinColorModelMasks(im_orig);

%% Do image proccessing
if size(im_orig, 3) == 3
  im = rgb2gray(im_orig);
end
im = double(im);

for i=1:length(scs)
  scs(i)
  im_resized = imresize(im, scs(i));
  skin_resized = imresize(skin, scs(i));
  boxes = ScanImageOverSkin(Cparams100_80, im_resized, skin_resized);
  if (~isempty(boxes))
    boxes = round(boxes / scs(i));
    dets{i} = boxes;
  end
end

dets = vertcat(dets{:}); % flatten into array
fdets = PruneDetections(dets);
DisplayDetections(im_orig, fdets);
