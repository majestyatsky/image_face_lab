function fdets = PruneDetections(dets)
%% Find and remove all detections that overlap for over rho% of their area

fdets = [];

if (~isempty(dets))
  %% Find overlapping detections
  nd = size(dets, 1);
  D = zeros(nd, nd);
  intsecAB = rectint(dets, dets);
  areas = diag(intsecAB);
  rho = 0.8;
  
  for i = 1:nd
    for j = 1:nd
      ABint = intsecAB(i,j);
      ABuni = areas(i) + areas(j) - ABint;
      if(ABint / ABuni) > rho
        D(i, j) = 1;
      end
    end
  end
  
  %% Find the connected components
  D = sparse(D);
  [S, C] = graphconncomp(D);
  
  fdets = zeros(S, 4);
  m = zeros(S, 1);
  
  for i=1:nd
    % Adding the coordinates of the bounding boxes of the same face
    fdets(C(i), :) = fdets(C(i), :) + dets(i, :);
    % Counting number of bounding boxes for a single face
    m(C(i)) = m(C(i)) + 1;
  end
  
  fdets = int32(fdets ./ (m * ones(1, 4))); %Averaging the coordinates of the bounding boxes of the same face
  
end