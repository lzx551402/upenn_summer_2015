% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1035.548452946937232 ; 1061.480731101275524 ];

%-- Principal point:
cc = [ 973.437823332759535 ; 490.858897480512780 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.309703532027707 ; 0.102668452454382 ; 0.000440364934502 ; -0.008857302494798 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 17.242775099675061 ; 17.431463219631777 ];

%-- Principal point uncertainty:
cc_error = [ 9.429427807324387 ; 7.018770802257015 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.009404768148415 ; 0.006799867050478 ; 0.001182856724623 ; 0.001494222741902 ; 0.000000000000000 ];

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
omc_1 = [ 1.969502e+00 ; 1.967570e+00 ; -3.373939e-01 ];
Tc_1  = [ 1.350461e+02 ; 6.398332e+01 ; 3.560505e+02 ];
omc_error_1 = [ 7.461650e-03 ; 5.675357e-03 ; 1.530565e-02 ];
Tc_error_1  = [ 3.228718e+00 ; 2.510173e+00 ; 5.240880e+00 ];

%-- Image #2:
omc_2 = [ 1.943526e+00 ; 2.016563e+00 ; -2.803177e-01 ];
Tc_2  = [ 1.366469e+02 ; 5.854506e+01 ; 3.592801e+02 ];
omc_error_2 = [ 7.220060e-03 ; 5.720229e-03 ; 1.489250e-02 ];
Tc_error_2  = [ 3.271751e+00 ; 2.522138e+00 ; 5.378726e+00 ];

%-- Image #3:
omc_3 = [ 2.122081e+00 ; 2.028336e+00 ; -1.421507e-01 ];
Tc_3  = [ 9.283612e+01 ; 2.423513e+01 ; 3.472137e+02 ];
omc_error_3 = [ 7.407650e-03 ; 5.160855e-03 ; 1.371512e-02 ];
Tc_error_3  = [ 3.187773e+00 ; 2.353138e+00 ; 5.450973e+00 ];

%-- Image #4:
omc_4 = [ 2.185174e+00 ; 2.081258e+00 ; -3.855236e-02 ];
Tc_4  = [ 3.285783e+01 ; 4.395412e+01 ; 3.590330e+02 ];
omc_error_4 = [ 7.260313e-03 ; 4.517546e-03 ; 1.290797e-02 ];
Tc_error_4  = [ 3.289081e+00 ; 2.404573e+00 ; 5.839224e+00 ];

%-- Image #5:
omc_5 = [ -2.144229e+00 ; -2.158681e+00 ; -2.168417e-01 ];
Tc_5  = [ -1.047710e+01 ; -2.020131e+01 ; 4.266640e+02 ];
omc_error_5 = [ 5.122236e-03 ; 7.323421e-03 ; 1.349499e-02 ];
Tc_error_5  = [ 3.903153e+00 ; 2.825122e+00 ; 7.236906e+00 ];

%-- Image #6:
omc_6 = [ -2.163930e+00 ; -2.126945e+00 ; -1.685314e-01 ];
Tc_6  = [ -6.250829e+01 ; 4.965474e+00 ; 4.804852e+02 ];
omc_error_6 = [ 5.971789e-03 ; 7.764435e-03 ; 1.601148e-02 ];
Tc_error_6  = [ 4.381081e+00 ; 3.182344e+00 ; 8.270766e+00 ];

%-- Image #7:
omc_7 = [ -2.189549e+00 ; -1.916365e+00 ; 4.578029e-03 ];
Tc_7  = [ -2.460648e+01 ; -4.177286e+01 ; 4.829351e+02 ];
omc_error_7 = [ 7.629229e-03 ; 8.272090e-03 ; 1.761321e-02 ];
Tc_error_7  = [ 4.415786e+00 ; 3.196932e+00 ; 7.940248e+00 ];

%-- Image #8:
omc_8 = [ -2.174208e+00 ; -1.760253e+00 ; 1.591227e-01 ];
Tc_8  = [ 4.458921e+01 ; -8.578881e+01 ; 4.563027e+02 ];
omc_error_8 = [ 8.894782e-03 ; 9.661306e-03 ; 1.850925e-02 ];
Tc_error_8  = [ 4.214909e+00 ; 3.070330e+00 ; 7.080929e+00 ];

%-- Image #9:
omc_9 = [ -2.361196e+00 ; -2.060549e+00 ; 1.270058e-01 ];
Tc_9  = [ -1.980669e+01 ; -5.610880e+01 ; 4.383924e+02 ];
omc_error_9 = [ 8.369203e-03 ; 7.830901e-03 ; 1.690811e-02 ];
Tc_error_9  = [ 3.979243e+00 ; 2.887361e+00 ; 7.342762e+00 ];

%-- Image #10:
omc_10 = [ 2.044046e+00 ; 1.804407e+00 ; -2.116888e-01 ];
Tc_10  = [ -7.006188e+01 ; 5.193085e+01 ; 4.405140e+02 ];
omc_error_10 = [ 7.595267e-03 ; 7.250988e-03 ; 1.239282e-02 ];
Tc_error_10  = [ 4.038745e+00 ; 2.932736e+00 ; 6.878905e+00 ];

%-- Image #11:
omc_11 = [ 2.175640e+00 ; 1.922907e+00 ; -2.040076e-01 ];
Tc_11  = [ 3.170785e+01 ; 2.719558e+01 ; 4.427818e+02 ];
omc_error_11 = [ 7.965291e-03 ; 6.095792e-03 ; 1.259325e-02 ];
Tc_error_11  = [ 4.005178e+00 ; 2.942094e+00 ; 6.860734e+00 ];

%-- Image #12:
omc_12 = [ 2.222786e+00 ; 2.153559e+00 ; 2.136625e-02 ];
Tc_12  = [ 2.771447e+01 ; 9.142182e+00 ; 4.261155e+02 ];
omc_error_12 = [ 7.577373e-03 ; 5.223020e-03 ; 1.358060e-02 ];
Tc_error_12  = [ 3.881060e+00 ; 2.826921e+00 ; 7.083129e+00 ];

%-- Image #13:
omc_13 = [ -2.260134e+00 ; -2.001545e+00 ; 1.677952e-02 ];
Tc_13  = [ -5.263204e+00 ; 2.375967e+01 ; 4.185022e+02 ];
omc_error_13 = [ 5.607403e-03 ; 7.259983e-03 ; 1.442055e-02 ];
Tc_error_13  = [ 3.832804e+00 ; 2.756059e+00 ; 6.914926e+00 ];

%-- Image #14:
omc_14 = [ -2.232666e+00 ; -2.094869e+00 ; 4.793939e-02 ];
Tc_14  = [ 5.597044e+00 ; -2.923386e+01 ; 3.062516e+02 ];
omc_error_14 = [ 5.042238e-03 ; 6.302332e-03 ; 1.184421e-02 ];
Tc_error_14  = [ 2.794137e+00 ; 2.020244e+00 ; 5.079600e+00 ];

%-- Image #15:
omc_15 = [ 2.221098e+00 ; 2.143992e+00 ; 4.651228e-02 ];
Tc_15  = [ -5.360002e-01 ; -6.981100e+01 ; 3.237626e+02 ];
omc_error_15 = [ 6.825334e-03 ; 5.674355e-03 ; 1.075338e-02 ];
Tc_error_15  = [ 2.966382e+00 ; 2.135397e+00 ; 5.473977e+00 ];

%-- Image #16:
omc_16 = [ 2.136481e+00 ; 2.229789e+00 ; 6.569762e-02 ];
Tc_16  = [ 8.203253e-01 ; -8.529454e+01 ; 4.911305e+02 ];
omc_error_16 = [ 8.172796e-03 ; 8.058643e-03 ; 1.539619e-02 ];
Tc_error_16  = [ 4.488055e+00 ; 3.250988e+00 ; 8.335023e+00 ];

%-- Image #17:
omc_17 = [ -2.297601e+00 ; -2.137584e+00 ; 8.211166e-03 ];
Tc_17  = [ 3.568625e+01 ; -8.955262e+01 ; 6.328349e+02 ];
omc_error_17 = [ 1.088165e-02 ; 1.093418e-02 ; 2.255967e-02 ];
Tc_error_17  = [ 5.769482e+00 ; 4.198536e+00 ; 1.073630e+01 ];

%-- Image #18:
omc_18 = [ -2.185197e+00 ; -2.219296e+00 ; 6.395978e-03 ];
Tc_18  = [ 6.946426e+01 ; -5.599598e+01 ; 6.928642e+02 ];
omc_error_18 = [ 1.080971e-02 ; 1.288753e-02 ; 2.520146e-02 ];
Tc_error_18  = [ 6.301473e+00 ; 4.597449e+00 ; 1.176270e+01 ];

%-- Image #19:
omc_19 = [ 1.802039e+00 ; 2.473621e+00 ; -7.906806e-02 ];
Tc_19  = [ 2.006670e+01 ; 6.742927e+01 ; 6.697493e+02 ];
omc_error_19 = [ 1.117921e-02 ; 1.165799e-02 ; 2.373909e-02 ];
Tc_error_19  = [ 6.107500e+00 ; 4.469278e+00 ; 1.126648e+01 ];

%-- Image #20:
omc_20 = [ -2.104082e+00 ; -2.231929e+00 ; 1.377198e-01 ];
Tc_20  = [ 8.281782e+01 ; 8.179225e+00 ; 5.987651e+02 ];
omc_error_20 = [ 8.495625e-03 ; 1.248262e-02 ; 2.337531e-02 ];
Tc_error_20  = [ 5.473109e+00 ; 3.983451e+00 ; 1.004177e+01 ];

