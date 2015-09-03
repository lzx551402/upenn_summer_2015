% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 931.834020759037458 ; 956.180127970759258 ];

%-- Principal point:
cc = [ 974.038234170879946 ; 538.037540834109336 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.347048217275080 ; 0.132572364940900 ; 0.002765537150944 ; 0.002775372268802 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 9.215164040773683 ; 9.458215280238713 ];

%-- Principal point uncertainty:
cc_error = [ 5.079022728548150 ; 4.286507105820432 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.006328678628092 ; 0.006091691829173 ; 0.000895010695855 ; 0.000747881185652 ; 0.000000000000000 ];

%-- Image size:
nx = 1920;
ny = 1080;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 20;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.974679e+00 ; 1.995888e+00 ; -3.505819e-01 ];
Tc_1  = [ 4.883658e+01 ; 5.210269e+01 ; 3.158287e+02 ];
omc_error_1 = [ 4.302872e-03 ; 3.464604e-03 ; 9.615623e-03 ];
Tc_error_1  = [ 1.732306e+00 ; 1.462861e+00 ; 2.920312e+00 ];

%-- Image #2:
omc_2 = [ 1.944451e+00 ; 2.042014e+00 ; -3.002060e-01 ];
Tc_2  = [ 4.937604e+01 ; 4.689634e+01 ; 3.183281e+02 ];
omc_error_2 = [ 4.197712e-03 ; 3.475677e-03 ; 9.331418e-03 ];
Tc_error_2  = [ 1.746774e+00 ; 1.467327e+00 ; 2.966427e+00 ];

%-- Image #3:
omc_3 = [ 2.124328e+00 ; 2.048495e+00 ; -1.597329e-01 ];
Tc_3  = [ 5.382040e+00 ; 1.125093e+01 ; 3.063440e+02 ];
omc_error_3 = [ 4.380687e-03 ; 3.373300e-03 ; 8.456957e-03 ];
Tc_error_3  = [ 1.674555e+00 ; 1.369776e+00 ; 2.958077e+00 ];

%-- Image #4:
omc_4 = [ 2.175106e+00 ; 2.091106e+00 ; -6.981738e-02 ];
Tc_4  = [ -5.469962e+01 ; 3.024238e+01 ; 3.161600e+02 ];
omc_error_4 = [ 4.604604e-03 ; 3.525412e-03 ; 8.660700e-03 ];
Tc_error_4  = [ 1.733987e+00 ; 1.422220e+00 ; 3.171425e+00 ];

%-- Image #5:
omc_5 = [ -2.138072e+00 ; -2.152573e+00 ; -1.465993e-01 ];
Tc_5  = [ -9.700219e+01 ; -3.319275e+01 ; 3.826849e+02 ];
omc_error_5 = [ 4.611042e-03 ; 5.145075e-03 ; 9.872246e-03 ];
Tc_error_5  = [ 2.093567e+00 ; 1.738283e+00 ; 3.952141e+00 ];

%-- Image #6:
omc_6 = [ -2.170065e+00 ; -2.141246e+00 ; -1.441425e-01 ];
Tc_6  = [ -1.488235e+02 ; -7.925409e+00 ; 4.271985e+02 ];
omc_error_6 = [ 4.905494e-03 ; 5.262050e-03 ; 1.060061e-02 ];
Tc_error_6  = [ 2.334752e+00 ; 1.960539e+00 ; 4.488931e+00 ];

%-- Image #7:
omc_7 = [ -2.183622e+00 ; -1.918176e+00 ; 1.197095e-02 ];
Tc_7  = [ -1.105991e+02 ; -5.473964e+01 ; 4.306642e+02 ];
omc_error_7 = [ 5.078157e-03 ; 4.564511e-03 ; 9.962333e-03 ];
Tc_error_7  = [ 2.344412e+00 ; 1.950225e+00 ; 4.349007e+00 ];

%-- Image #8:
omc_8 = [ -2.172877e+00 ; -1.767158e+00 ; 1.781762e-01 ];
Tc_8  = [ -4.074365e+01 ; -9.894770e+01 ; 4.066003e+02 ];
omc_error_8 = [ 5.151391e-03 ; 4.276017e-03 ; 1.026728e-02 ];
Tc_error_8  = [ 2.235952e+00 ; 1.830252e+00 ; 3.894766e+00 ];

%-- Image #9:
omc_9 = [ -2.328246e+00 ; -2.037826e+00 ; 1.199269e-01 ];
Tc_9  = [ -1.062452e+02 ; -6.927898e+01 ; 3.914956e+02 ];
omc_error_9 = [ 5.441282e-03 ; 4.096391e-03 ; 1.122571e-02 ];
Tc_error_9  = [ 2.139113e+00 ; 1.771481e+00 ; 4.009232e+00 ];

%-- Image #10:
omc_10 = [ 2.036682e+00 ; 1.807732e+00 ; -2.210423e-01 ];
Tc_10  = [ -1.568343e+02 ; 3.818373e+01 ; 3.905545e+02 ];
omc_error_10 = [ 5.114140e-03 ; 5.643535e-03 ; 9.406695e-03 ];
Tc_error_10  = [ 2.153950e+00 ; 1.812633e+00 ; 4.003657e+00 ];

%-- Image #11:
omc_11 = [ 2.177413e+00 ; 1.940471e+00 ; -2.415185e-01 ];
Tc_11  = [ -5.470336e+01 ; 1.357497e+01 ; 3.948953e+02 ];
omc_error_11 = [ 5.306311e-03 ; 4.678280e-03 ; 9.828196e-03 ];
Tc_error_11  = [ 2.147073e+00 ; 1.770641e+00 ; 3.851648e+00 ];

%-- Image #12:
omc_12 = [ 2.224926e+00 ; 2.165972e+00 ; -3.818210e-02 ];
Tc_12  = [ -5.816423e+01 ; -4.288491e+00 ; 3.809744e+02 ];
omc_error_12 = [ 5.628339e-03 ; 4.768605e-03 ; 1.109073e-02 ];
Tc_error_12  = [ 2.079917e+00 ; 1.709524e+00 ; 3.851354e+00 ];

%-- Image #13:
omc_13 = [ -2.259447e+00 ; -2.010767e+00 ; 5.740025e-02 ];
Tc_13  = [ -9.185930e+01 ; 1.030088e+01 ; 3.731726e+02 ];
omc_error_13 = [ 4.488836e-03 ; 4.728780e-03 ; 9.071019e-03 ];
Tc_error_13  = [ 2.027582e+00 ; 1.681912e+00 ; 3.735474e+00 ];

%-- Image #14:
omc_14 = [ -2.217133e+00 ; -2.087528e+00 ; 9.449657e-02 ];
Tc_14  = [ -8.133350e+01 ; -4.290026e+01 ; 2.738364e+02 ];
omc_error_14 = [ 3.638450e-03 ; 3.433049e-03 ; 7.402099e-03 ];
Tc_error_14  = [ 1.490667e+00 ; 1.234908e+00 ; 2.782624e+00 ];

%-- Image #15:
omc_15 = [ 2.241149e+00 ; 2.175123e+00 ; 6.681568e-03 ];
Tc_15  = [ -8.726776e+01 ; -8.349204e+01 ; 2.888582e+02 ];
omc_error_15 = [ 3.704106e-03 ; 4.136157e-03 ; 8.849531e-03 ];
Tc_error_15  = [ 1.598977e+00 ; 1.313915e+00 ; 3.037406e+00 ];

%-- Image #16:
omc_16 = [ 2.153789e+00 ; 2.258791e+00 ; 3.637498e-02 ];
Tc_16  = [ -8.492991e+01 ; -9.819669e+01 ; 4.382905e+02 ];
omc_error_16 = [ 5.922576e-03 ; 7.047457e-03 ; 1.420787e-02 ];
Tc_error_16  = [ 2.412387e+00 ; 1.982876e+00 ; 4.534918e+00 ];

%-- Image #17:
omc_17 = [ -2.259576e+00 ; -2.107600e+00 ; 2.356225e-03 ];
Tc_17  = [ -4.945128e+01 ; -1.016963e+02 ; 5.645176e+02 ];
omc_error_17 = [ 1.037001e-02 ; 9.504586e-03 ; 2.182817e-02 ];
Tc_error_17  = [ 3.099576e+00 ; 2.542293e+00 ; 5.809091e+00 ];

%-- Image #18:
omc_18 = [ -2.153414e+00 ; -2.194224e+00 ; 5.053077e-02 ];
Tc_18  = [ -1.412939e+01 ; -6.884221e+01 ; 6.208154e+02 ];
omc_error_18 = [ 1.173302e-02 ; 1.322709e-02 ; 2.687935e-02 ];
Tc_error_18  = [ 3.395285e+00 ; 2.785975e+00 ; 6.388986e+00 ];

%-- Image #19:
omc_19 = [ 1.778205e+00 ; 2.460284e+00 ; -1.321430e-01 ];
Tc_19  = [ -6.466985e+01 ; 5.510714e+01 ; 5.977545e+02 ];
omc_error_19 = [ 1.038606e-02 ; 1.188714e-02 ; 2.121157e-02 ];
Tc_error_19  = [ 3.266529e+00 ; 2.698762e+00 ; 6.157790e+00 ];

%-- Image #20:
omc_20 = [ -2.087720e+00 ; -2.222310e+00 ; 1.396843e-01 ];
Tc_20  = [ -3.343473e+00 ; -4.605449e+00 ; 5.307589e+02 ];
omc_error_20 = [ 7.107453e-03 ; 9.767156e-03 ; 1.773284e-02 ];
Tc_error_20  = [ 2.897334e+00 ; 2.373871e+00 ; 5.285747e+00 ];

