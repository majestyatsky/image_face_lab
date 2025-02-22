function [ ii_ims ] = LoadImDataDir( dirname, varargin )
%% Loads the images from directory 'dirname'.
%  Return the integral images converted into a column vector.
%  ii_ims size [(image_width * image_height) x num_of_imgs]
%  If varargin is given, then the first ni = varargin(1) images are loaded

fs = dir([dirname filesep '*.bmp']);

if ~isempty(varargin)
  ni = varargin{1};
else
  ni = size(fs, 1);
end

ii_ims = zeros(19 * 19, ni);
for i = 1:ni
  [~, tmp] = LoadIm([dirname filesep fs(i).name]);
  ii_ims(:, i)= tmp(:);
end