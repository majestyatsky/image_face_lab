function dets = ScanImageOverScale1(Cparams, im, min_s, max_s, step_s)
%% Scale input image and apply face detector, to detect faces of different
%  sizes. Using parfor for  time efficiency
scs = min_s:step_s:max_s;
dets = cell(length(scs), 1);

parfor i=1:length(scs)
  a = imresize(im, scs(i));
  boxes = ScanImageFixedSize(Cparams, a);
  if (~isempty(boxes))
    boxes = round(boxes / scs(i));
    dets{i} = boxes;
  end
end

dets = vertcat(dets{:}); % flatten into array
