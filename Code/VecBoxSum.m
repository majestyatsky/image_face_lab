function b_vec = VecBoxSum(x, y, w, h, W, H)
%% Function VecBoxSum:
%  Input: x, y: coordinates of the top left corner of the rectangular
%         w, h: width and height of rectangular
%         W, H: width and height if the integral image
%  Output: b_vec: row vector with 4 non-zero elements, such that:
%                 b_vec * ii_im(:) results in the sum of the pixels
%                 intensities of the rectangular
%  NOTE: notation used as in: https://computersciencesource.wordpress.com/2010/09/03/computer-vision-the-integral-image/
%  A = [x, y];
%  B = [x + w, y];
%  C = [x, y + h];
%  D = [x + w, y + h];
%  Summed area is: A + D - B -C, where A = ii_im(A) etc.

b_vec = zeros(1, W * H);

%% Convert 2d coordinates to 1d
% If the rectangular exceeds the image boundaries,
% then we reshape it to the end of the image.
if x + w - 1 > W
  w = W - x + 1;
end
if y + h - 1 > H
  h = H - y + 1;
end

b_vec(sub2ind([H, W], y + h - 1, x + w - 1)) = 1; % +D
% If either x and/or y are 1, then A and B and/or C are zero,
% so we ignore them
if x ~= 1
  b_vec(sub2ind([H, W], y + h - 1, x - 1)) = -1;    % -C
end
if y ~= 1
  b_vec(sub2ind([H, W], y - 1, x + w - 1)) = -1;    % -B
end
if x ~= 1 && y ~= 1
  b_vec(sub2ind([H, W], y - 1, x - 1)) = 1;         % +A
end





