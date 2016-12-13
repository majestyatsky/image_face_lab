function scs = ApplyDetector(Cparams, ii_ims)
%% Function ApplyDetector
%  Applies the trained detector on test images
%  Cparams: parameters set of the classifier (alpha, chosen_f, Theta)
%  ii_ims: test images, size[(image_width * image_height) x num_images]
%  ====================================================================
%  scs: cumulative score of each image's response, size [1 x num_images]

alphas = Cparams.alphas;
chosen_fs = Cparams.Thetas(:, 1);
thetas = Cparams.Thetas(:, 2);
ps = Cparams.Thetas(:, 3);
scs = zeros(1, size(ii_ims, 2));

for img = 1:size(ii_ims, 2)
  for i = 1:length(Cparams.alphas)
    f = Cparams.fmat(chosen_fs(i), :) * ii_ims(:, img); % Feature vector
    scs(img) = scs(img) + alphas(i) * WeakClassifier(f, ps(i), thetas(i));
  end
end
