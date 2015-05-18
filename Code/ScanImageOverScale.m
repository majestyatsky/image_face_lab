function dets = ScanImageOverScale(Cparams, im, min_s, max_s, step_s)
scs = min_s:step_s:max_s;
dets = cell(length(scs),1);

for i=1:length(scs)
    a = imresize(im,scs(i));
    boxes = ScanImageFixedSize(Cparams, a);
    boxes(:,1) = round(boxes(:,1)/scs(i));
    boxes(:,2) = round(boxes(:,2)/scs(i));
    boxes(:,3) = round(boxes(:,3)/scs(i));
    boxes(:,4) = round(boxes(:,4)/scs(i));
    dets{i} = boxes;
end

dets = vertcat(a{:}); % flatten into array

end