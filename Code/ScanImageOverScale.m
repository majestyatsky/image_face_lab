function dets = ScanImageOverScale(Cparams, im, min_s, max_s, step_s)
Cparams.fmat = sparse(Cparams.fmat);
dets = [];
temp_dets = [];
%% Implement a multiscale search
for scale=min_s:step_s:max_s
  scale
  scaled = imresize(im, scale);
  temp_dets = ScanImageFixedSize(Cparams, scaled);
  if (~isempty(temp_dets))
    temp_dets = floor(temp_dets / scale);
    dets = [dets; temp_dets];    
    temp_dets = [];
  end
end