function undistortion_without_filter (In_Path, Out_Path, Center_x, Center_y, omega)

In_img = imread (In_Path);
In_img = imresize(In_img, [960 1280], 'bilinear');
[Width, Higth, N] = size (In_img);
Out_img = zeros (Width, Higth, N);

scale = 1280 / Higth;
for i = 1 : Width
 	for j = 1 : Higth
		x = i * scale;
		y = j * scale;


		r_u = norm ([(x - Center_x) (y - Center_y)]);
		r_d = atan (2 * r_u * tan (omega / 2)) / omega;
		x = r_d / r_u * (x - Center_x) + Center_x;
 		y = r_d / r_u * (y - Center_y) + Center_y;
 
		x = x / scale;
		y = y / scale;

		x_down = floor (x);
		x_up = ceil (x);
		y_down = floor (y);
		y_up = ceil (y);

		if x_up > Width || x_down < 1 || y_up > Higth || y_down < 1
			continue;
		end

		dx = x - x_down;
		dy = y - y_down;
		w1 = (1 - dx) * (1 - dy);
		w2 = (1 - dx) * dy;
		w3 = dx * (1 - dy);
		w4 = dx * dy;
		Out_img (i, j , :) = In_img (x_down, y_down, :) .* w1 + In_img (x_down, y_up, :) .* w2 ...
			+ In_img (x_up, y_down, :) .* w3 + In_img (x_up, y_up, :) .* w4;
    end
    if mod(i, 100) == 0
        disp (i);
    end
end
Out_img = Out_img ./ 256;
imwrite (Out_img, Out_Path);