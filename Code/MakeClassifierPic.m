function cpic = MakeClassifierPic(all_ftypes, chosen_f, alphas, ps, W, H)
%% Function MakeClassifierPic:
%  Input: all_ftype: vector of feature type
%         chosen_f: vector of positive integers that correspond to the
%         features used in the classifier
%         alphas: vector of weights associated with each feature/weak
%         classifier
%         ps: vector of parities
%         W: width of the classifier image
%         H: height of the classifier image

%  Output: cpic: image representing classifier

cpic = zeros(H,W);
w = alphas .* ps;

for i = 1:length(chosen_f)
  cpic = cpic + w(i) * MakeFeaturePic(all_ftypes(chosen_f(i), :), W, H);
end

end