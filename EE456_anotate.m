% A = imread('F:\coursesUND\EE456\Project\Ecad.tif');
% A = A(1:300,:); % bottom of image is empty, remove to save space
% B = imread('F:\coursesUND\EE456\Project\myosin.tif');
% B = B(1:300,:);

rotdir = 'F:\coursesUND\EE456\Project\rotData\';
DVdir = 'F:\coursesUND\EE456\Project\DVdata\';
targetDir = 'F:\coursesUND\EE456\Project\target.tif';

vdist = 20;
hdist = 100;
target = imread(targetDir);
figure;
for q = 1:6
%     close all
    ecadF = strcat(rotdir, 'Ecad', num2str(q),'.tif');
    pmyoF = strcat(rotdir, 'myosin', num2str(q),'.tif');
    ecad = imread(ecadF);
    pmyo = imread(pmyoF);
    ecadF = strcat(DVdir, 'Ecad', num2str(q),'.tif');
    pmyoF = strcat(DVdir, 'myosin', num2str(q),'.tif');
    
    A = ecad;
    B = pmyo;
    hmin = 0;
    vmin = 0;
    dmin = 255;
    for i = 1:size(A,2)-hdist
        for j = 1:size(A,1)-vdist
            test = A(j:j+vdist,i:i+hdist);
            d = mean(mean(abs(int8(test)-int8(target))));
            if (d < dmin)
                dmin = d;
                vmin = j;
                hmin = i;
            end
        end
    end
   
    sigma = 8;
    gaus_img = imgaussfilt(A,sigma);
    level = graythresh(gaus_img);
    BW = imbinarize(gaus_img,level);
    BW = bwpropfilt(BW,'Area',1);
    
%     figure;
%     imshowpair(gaus_img,BW,'montage');  % gassian blur
%     gaus = 'F:\coursesUND\EE456\Project\Gaussian\gaus';
%     saveas(gcf, strcat(gaus, num2str(q),'.svg'), 'svg');
    
    A(:,hmin + round(hdist/2)-1:hmin + round(hdist/2)+1) =  255;
    B(:,hmin + round(hdist/2)-1:hmin + round(hdist/2)+1) =  255;
    BW = uint8(BW);
    B_roi = BW.*B;
    
%     subplot(2,3,q)
%     imshow(A);
%     hold on
%     plot([hmin, hmin + hdist], [vmin + vdist, vmin + vdist], 'r-', 'linewidth', 2)
%     plot([hmin, hmin + hdist], [vmin, vmin], 'r-', 'linewidth', 2)
%     plot([hmin + hdist, hmin + hdist], [vmin, vmin + vdist], 'r-', 'linewidth', 2)
%     plot([hmin, hmin], [vmin, vmin + vdist], 'r-', 'linewidth', 2)
%     title('sample 1')
%     mask = 'F:\coursesUND\EE456\Project\Masked\mask';
%     imwrite(B_roi, strcat(mask, num2str(q),'.png'))
%     figure();
%     imshowpair(B,B_roi,'montage');  % masked pmyosin
%     saveas(gcf, strcat(mask, num2str(q),'.svg'), 'svg'); 
    
    dorsal = B_roi(:,1:hmin-2);
    BWdorsal = BW(:,1:hmin-2);

    ventral = B_roi(:,hmin+2:end);
    BWventral = BW(:,hmin+2:end);
    numbersD = zeros(1,256);
    numbersV = zeros(1,256);

    countD = sum(sum(BWdorsal > 0));
    AverageD = sum(sum(dorsal))/countD;
    % custom histogram
    for i = 1:size(dorsal,2)
        for j = 1:size(dorsal,1)
            if (BWdorsal(j,i) > 0)
                numbersD(dorsal(j,i)+1) = numbersD(dorsal(j,i)+1)+1;
            end
        end
    end

    countV = sum(sum(BWventral > 0));
    AverageV = sum(sum(ventral))/countV;
    for i = 1:size(ventral,2)
        for j = 1:size(ventral,1)
            if (BWventral(j,i) > 0)
                numbersV(ventral(j,i)+1) = numbersV(ventral(j,i)+1)+1;
            end
        end
    end
%     figure;
%     subplot(2,3,q)
%     bar(0:255,numbersD);
%     hold on
%     b1 = bar(0:255,numbersV);
%     b1.FaceAlpha = 0.5;
%     xlim([0 255])
%     xlabel('Intensity Value')
%     ylabel('Pixel Count')
%     legend('Dorsal','Ventral')
%     graphs = 'F:\coursesUND\EE456\Project\Histograms\hist';
%     saveas(gcf, strcat(graphs, num2str(q),'.png'), 'png');
%     saveas(gcf, strcat(graphs, num2str(q),'.svg'), 'svg');
%     figure;
%     imshowpair(BWdorsal.*dorsal,BWventral.*ventral,'montage');
end
% legend('Dorsal','Ventral')
% saveas(gcf, strcat(mask, 'All.svg'), 'svg');
% saveas(gcf, strcat(mask, 'ALL.png'), 'png');