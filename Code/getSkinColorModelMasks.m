function [mask1,mask2,mask3,mask4] = getSkinColorModelMasks(img)
img = im2uint8(img);
% x=linspace(0,1,256);
R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);
% Kovac (rgb)
% mask1 = R > 95 & G > 40 & B > 20;
mask1 = R > 95 & G > 40 & B > 20;
mask1 = mask1 & (max(img,[],3) - min(img,[],3)) > 15;
mask1 = mask1 & abs(R - G) > 15;
mask1 = mask1 & R > G & R > B;
% e1 = (R>95) & (G>40) & (B>20) & ((max(R,max(G,B)) - min(R, min(G,B)))>15) & (abs(R-G)>15) & (R>G) & (R>B);
% e2 = (R>220) & (G>210) & (B>170) & (abs(R-G)<=15) & (R>B) & (G>B);
% mask1 = e1;

%YCrCb
[~,cr,cb] = myRGB2YCrCb(img);
mask2 = (cr < ((1.5862 * cb) + 20));
mask2 = mask2 & (cr > ((0.3448 * cb) + 76));
mask2 = mask2 & (cr > ((-4.5652 * cb) + 234));
mask2 = mask2 & (cr < ((-1.15 * cb) + 301.75));
mask2 = mask2 & (cr < ((-2.2857 * cb) + 432.85));

himg = rgb2hsv(img);
himg = im2uint8(himg);
mask3 = himg(:,:,1) < 25 | himg(:,:,1) > 230;

R = double(R); G = double(G); B = double(B);

mask4 = ((R-G)./(R+G)) > 0;
mask4 = mask4 & ((R-G)./(R+G)) <= 0.5;
mask4 = mask4 & (B./(R+G)) <= 0.5;


end