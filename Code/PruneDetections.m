function fdets = PruneDetections(dets)
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
    fdets(C(i), :) = fdets(C(i), :) + dets(i, :); %Adding the coordinates of the bounding boxes of the same face
    m(C(i)) = m(C(i)) + 1; %Counting number of bounding boxes for a single face
  end
  
  fdets = int32(fdets ./ (m * ones(1, 4))); %Averaging the coordinates of the bounding boxes of the same face
  
end