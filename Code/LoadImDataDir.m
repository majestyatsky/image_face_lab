function [ ii_ims ] = LoadImDataDir( dirname, varargin )

fs = dir([dirname filesep '*.bmp']);
if ~isempty(varargin)
    ni = varargin{1};
else
    ni = size(fs,1);
end

ii_ims = zeros(19*19,ni);
for i=1:ni
    [~,tmp] = LoadIm([dirname filesep fs(i).name]);
    ii_ims(:,i)= tmp(:);
end

end

