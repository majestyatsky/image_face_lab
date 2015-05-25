function dets = ScanImageOverScale(Cparams, im, min_s, max_s, step_s)
scs = min_s:step_s:max_s;
dets = cell(length(scs),1);

for i=1:length(scs)
  scs(i)
  a = imresize(im,scs(i));
  boxes = ScanImageFixedSize(Cparams, a);
  if (~isempty(boxes))
    boxes = round(boxes / scs(i));
    %       boxes(:,1) = round(boxes(:,1)/scs(i));
    %       boxes(:,2) = round(boxes(:,2)/scs(i));
    %       boxes(:,3) = round(boxes(:,3)/scs(i));
    %       boxes(:,4) = round(boxes(:,4)/scs(i));
    dets{i} = boxes;
  end
end

dets = vertcat(dets{:}); % flatten into array

end