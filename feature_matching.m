%this code is for keypoints detection and feature matching
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
% %setup
% addpath(genpath(pwd));
% run('./func/feature_matching/toolbox/vl_setup');
% vl_setup demo;
% %input pair images
% A_img = fullfile('bin',strcat('u_',base_name,'_l.bmp'));
% B_img = fullfile('bin',strcat('u_',base_name,'_r.bmp'));
% img_a = imread(A_img);
% img_b = imread(B_img);
% Ia = single(rgb2gray(img_a));
% Ib = single(rgb2gray(img_b));
% %%
% [fa, da] = vl_sift(Ia) ;
% [fb, db] = vl_sift(Ib) ;
% [matches_A, scores_A] = vl_ubcmatch(da, db, 1.3);
% [matches_B, scores_B] = vl_ubcmatch(db, da, 1.3);
% [matches,scores] = F_DeleteOutlier (matches_A, matches_B,scores_A,scores_B);
% %%
% P1 = fa (1 : 2, matches(1, :));
% P2 = fb (1 : 2, matches(2, :));
% data = [P1' P2'];
% [beat_points,beat_scores] = F_Ransac (data, scores, 200, 40);
% %%
% [~,index] = sort(beat_scores,'descend');
% [n,~]=size(beat_points);
% if n>=400
%     n=400;
% end
% t=beat_points(index(1:n),:);
% F_Show_line (t, img_a, img_b, strcat('bin/matching_',base_name,'.bmp'));
% %%
% ml=t(:,1:2)';
% mr=t(:,3:4)';
% save(strcat('func/rectification/data/',base_name,'_pairs.mat'),'ml','mr');
% 
