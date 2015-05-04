function fpic = MakeFeaturePic(ftype, W, H)

%% Function MakeFeaturePic:
%  Create an image representing feature
%  Input: ftype: vector of feature type
%         W: width of the feature image
%         H: height of the feature image
%  Output: fpic: image representing feature

fpic = zeros(H,W);
type = ftype(1);
x = ftype(2);
y = ftype(3);
w = ftype(4);
h = ftype(5);

switch type
    case 1
        fpic(x:x+w,y:y+h) = -1;
        fpic(x:x+w,y+h+1:y+2*h) = 1;
        
    case 2
        fpic(x:x+w,y:y+h) = 1;
        fpic(x+w+1:x+2*w,y:y+h) = -1;
        
    case 3
        fpic(x:x+w,y:y+h) = 1;
        fpic(x+w+1:x+2*w,y:y+h) = -1;
        fpic(x+2*w:x+3*w,y:y+h) = 1;
        
    case 4
        fpic(x:x+w,y:y+h) = 1;
        fpic(x:x+w,y+h+1:y+2*h) = -1;
        fpic(x+w+1:x+2*w,y:y+h) = -1;
        fpic(x+w+1:x+2*w,y+h+1:y+2*h) = 1;
        
end
        fpic = fpic';
end