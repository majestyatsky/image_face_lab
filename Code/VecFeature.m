function ftype_vec = VecFeature(ftype, W, H)
%% Function VecFeature
%  Input: ftype: Type of feature (1, 2, 3, 4) and(x, y, w, h)
%         W, H: Size of the image
%  Output: row vector required to compute the response for the feature defined

x = ftype(2);
y = ftype(3);
w = ftype(4);
h = ftype(5);

switch ftype(1)
  case 1
    %% Type I feature
%     w = W;
%     h1 = floor(H / 2);
%     h2 = H - h1;
    ftype_vec = VecBoxSum(x, y, w, h, W, H) - VecBoxSum(x, y + h, w, h, W, H);
  case 2
    %% Type II feature
%     w1 = floor(W / 2);
%     w2 = W - w1;
%     h = H;
    ftype_vec = - VecBoxSum(x, y, w, h, W, H) + VecBoxSum(x + w, y, w, h, W, H);
  case 3
    %% Type III feature
%     w1 = floor(W / 3);
%     w2 = w1;
%     w3 = W - w1 - w2;
%     h = H;
    ftype_vec = - VecBoxSum(x, y, w, h, W, H)...
      + VecBoxSum(x + w, y, w, h, W, H) - VecBoxSum(x + 2 * w, y, w, h, W, H);
  case 4
    %% Type IV feature
%     w1 = floor(W / 2);
%     w2 = W - w1;
%     h1 = floor(H / 2);
%     h2 = H - h1;
    ftype_vec = - VecBoxSum(x, y, w, h, W, H) + VecBoxSum(x + w, y, w, h, W, H)...
      + VecBoxSum(x, y + h, w, h, W, H) - VecBoxSum(x + w, y + h, w, h, W, H);
  otherwise
    disp('WRONG TYPE');
end