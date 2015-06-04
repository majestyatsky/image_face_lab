function [Y,Cr,Cb] = myRGB2YCrCb(img)
img = double(img);
R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);
Y  = (0.257*R) + (0.504*G) + (0.098*B) + 16; 
Cr = (0.439*R) - (0.368*G) - (0.071*B) + 128;
Cb = -(0.148*R)- (0.291*G) + (0.439*B) + 128;
end