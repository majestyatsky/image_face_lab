function DisplayDetections(im, dets)
n_faces = size(dets, 1);
figure();
imshow(im);
hold on;
for i = 1:n_faces
    x = dets(i,1);
    y = dets(i,2);
    w = dets(i,3);
    h = dets(i,4);
    rectangle('Position',[x,y,w,h], 'LineWidth', 1, 'EdgeColor','r');
end