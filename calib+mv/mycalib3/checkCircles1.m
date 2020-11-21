

%参考
%https://www.mathworks.com/help/releases/R2019b/vision/examples/measuring-planar-objects-with-a-calibrated-camera.html
clc
clear all
close all
load("cameraParams.mat");
showExtrinsics(cameraParams)
imOrig = imread("checkBoard1.JPG");


[im, newOrigin] = undistortImage(imOrig, cameraParams, 'OutputView', 'full');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[imagePoints, boardSize] = detectCheckerboardPoints(im);

% Adjust the imagePoints so that they are expressed in the coordinate system
% used in the original image, before it was undistorted.  This adjustment
% makes it compatible with the cameraParameters object computed for the original image.
imagePoints = imagePoints + newOrigin; % adds newOrigin to every row of imagePoints

% Compute rotation and translation of the camera.
[R, t] = extrinsics(imagePoints, cameraParams.WorldPoints, cameraParams);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert the image to the HSV color space.
%使用APP工具获得二值化的图

close all
imOrig = imread("checkCircles1.JPG");
[im, newOrigin] = undistortImage(imOrig, cameraParams, 'OutputView', 'full');
figure; imshow(im);
title('Undistorted Image');
[BW,maskedRGBImage] = createMask1(im);%这是自动生成的函数
se = strel('disk',5);
BW = imopen(BW,se); 



figure,imshow(BW)

se = strel('disk',20);
BW = imclose(BW,se); 

figure,imshow(BW)
imwrite(BW,'test.jpg')



%regionprops
blobAnalysis = vision.BlobAnalysis('AreaOutputPort', true,...
    'CentroidOutputPort', true,...
    'BoundingBoxOutputPort', true,...
    'MajorAxisLengthOutputPort', true,...
    'MinorAxisLengthOutputPort',true,...
    'EccentricityOutputPort',true,...
    'PerimeterOutputPort' , true,...
    'EquivalentDiameterSquaredOutputPort' , true,...
    'Connectivity',8, ...
    'MinimumBlobArea', floor(pi*100*100), 'ExcludeBorderBlobs', true);
[areas,Centro, boxes,MajorAxis,MinorAxis,Eccent,Perimeter,DiameterSquared] = step(blobAnalysis, BW);


% Reduce the size of the image for display.


% Insert labels for the coins.
% imDetectedCoins = insertObjectAnnotation(im, 'rectangle',  boxes, 'penny');
% figure; imshow(imDetectedCoins);
% title('Detected Coins');
areas = areas(1:2,:);

MajorAxis = MajorAxis(1:2,:);
MinorAxis = MinorAxis(1:2,:);
viscircles(Centro(1:2,:), MajorAxis/2,'EdgeColor','b');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
box1 = Centro(1, :)+newOrigin;
imagePoints1 = [ box1;box1(1)+ MajorAxis(1),box1(2)+MajorAxis(1)];
worldPoints1 = pointsToWorld(cameraParams,R,t,imagePoints1);
d = worldPoints1(2, :) - worldPoints1(1, :);
diameterInMillimeters = hypot(d(1), d(2));
fprintf('diameter1 = %0.2f mm\n', diameterInMillimeters);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
box1 = Centro(2, :)+newOrigin;
imagePoints1 = [ box1;box1(1)+ MajorAxis(2),box1(2)+MajorAxis(2)];
worldPoints1 =  pointsToWorld(cameraParams,R,t,imagePoints1);
d = worldPoints1(2, :) - worldPoints1(1, :);
diameterInMillimeters = hypot(d(1), d(2));
fprintf('diameter2 = %0.2f mm\n', diameterInMillimeters);

