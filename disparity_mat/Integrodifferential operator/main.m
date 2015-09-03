function [ciL,ciR] = main(in,para_L,para_R)

[ciL]=thresh(in,para_L(1),para_L(2),para_L(3),para_L(4));
[ciR]=thresh(in,para_R(1),para_R(2),para_R(3),para_R(4));
drawellipse(in,ciL,ciR);
end