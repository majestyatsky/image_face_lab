function dets = ScanImageOverScale(Cparams, im, min_s, max_s, step_s)
%% Scale input image and apply face detector, to detect faces of different
%  sizes.
Cparams.fmat = sparse(Cparams.fmat);
dets = [];
temp_dets = [];

%% Implement a multiscale search
for scale=min_s:step_s:max_s
  scaled = imresize(im, scale);
  temp_dets = ScanImageFixedSize(Cparams, scaled);
  if (~isempty(temp_dets))
    temp_dets = floor(temp_dets / scale);
    dets = [dets; temp_dets];    
    temp_dets = [];
  end
end