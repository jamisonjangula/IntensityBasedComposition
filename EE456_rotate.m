dir = 'F:\coursesUND\EE456\Project\imageData\';
rotdir = 'F:\coursesUND\EE456\Project\rotData\';

for q = 1:6
    ecadF = strcat(dir, 'Ecad', num2str(q),'.tif');
    pmyoF = strcat(dir, 'myosin', num2str(q),'.tif');
    ecad = imread(ecadF);
    pmyo = imread(pmyoF);
    ecadF = strcat(rotdir, 'Ecad', num2str(q),'.tif');
    pmyoF = strcat(rotdir, 'myosin', num2str(q),'.tif');
    
    C = ecad;
    ids = find(C < 0.5*max(max(C)));
    C(ids) = 0;
    C = C > 0;
    X = [];
    Y = [];
    for i = 1:size(C,1)
        for j = 1:size(C,2)
            if (C(i, j))
                Y(end+1) = i;
                X(end+1) = j;
            end
        end
    end
    P = polyfit(X,Y,1);
    yfit = P(1)*X+P(2);
    theta = asind((yfit(end)-yfit(1))/(X(end)-X(1))*.34);
    C = imrotate(img, theta);
    imwrite(imrotate(ecad, theta), ecadF) 
    imwrite(imrotate(pmyo, theta), pmyoF) 
end 