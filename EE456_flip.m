dir = 'F:\coursesUND\EE456\Project\imageData\';
for i = 2:6
   ecadF = strcat(dir, 'Ecad', num2str(i),'.tif');
   pmyoF = strcat(dir, 'myosin', num2str(i),'.tif');
   ecad = imread(ecadF);
   pmyo = imread(pmyoF);
   ecad = ecad(:,end:-1:1);
   imwrite((ecad), ecadF) 
   pmyo = pmyo(:,end:-1:1);
   imwrite((pmyo), pmyoF) 
end

A = imread('F:\coursesUND\EE456\Project\Ecad.tif');
A = A(1:300,:); % bottom of image is empty, remove to save space
B = imread('F:\coursesUND\EE456\Project\myosin.tif');
B = B(1:300,:);

figure;
subplot(1,2,1)
imshow(A)
title('E-Cadherin Expression')
xlabel('Dorsal -> Ventral')
subplot(1,2,2)
imshow(B)
title('P-Myosin II Expression')
xlabel('Dorsal -> Ventral')

sigma = 8;
gaus_img = imgaussfilt(A,sigma);

vstart = 10;
vdist = 20;
hstart = 260;
hdist = 100;

figure;
target = A(vstart:vstart+vdist,hstart:hstart+hdist);
imshow(target);
imwrite(target, "F:\coursesUND\EE456\Project\target.tif")