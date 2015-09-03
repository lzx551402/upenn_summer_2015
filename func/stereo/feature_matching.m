% this code is for keypoints detection and feature matching
% SURF features are extracted here.
% RANSAC is applied here as well, the params for it can be modified if
% needed.
function []=feature_matching(base_name)
%%
I1=rgb2gray(imread(fullfile('bin/',base_name,['u_',base_name,'_l.bmp'])));
I2=rgb2gray(imread(fullfile('bin/',base_name,['u_',base_name,'_r.bmp'])));
points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);
[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);
indexPairs = matchFeatures(f1, f2) ;
matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2(indexPairs(:, 2));
figure; ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'Parent',ax);
legend(ax,'Matched points 1','Matched points 2');
[fMatrix, epipolarInliers, status] = estimateFundamentalMatrix(...
matchedPoints1, matchedPoints2, 'Method', 'RANSAC', ...
'NumTrials', 10000, 'DistanceThreshold', 0.1, 'Confidence', 99.99);

if status ~= 0 || isEpipoleInImage(fMatrix, size(I1)) ...
  || isEpipoleInImage(fMatrix', size(I2))
  error(['Either not enough matching points were found or '...
         'the epipoles are inside the images. You may need to '...
         'inspect and improve the quality of detected features ',...
         'and/or improve the quality of your images.']);
end

inlierPoints1 = matchedPoints1(epipolarInliers, :);
inlierPoints2 = matchedPoints2(epipolarInliers, :);
ml=double(inlierPoints1.Location');
mr=double(inlierPoints2.Location');
figure;
showMatchedFeatures(I1, I2, inlierPoints1, inlierPoints2);
legend('Inlier points in I1', 'Inlier points in I2');
save(fullfile('bin/',base_name,[base_name,'_pairs.mat']),...
    'ml','mr');