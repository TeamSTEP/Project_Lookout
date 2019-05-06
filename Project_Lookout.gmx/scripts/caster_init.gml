//total number of points in the casting procces. 4 means we define 4 points.(obviously.)
//if the origin is center, than -sprite_width(or height)/2 is 0
cast_points = 4;

//first point, top left corner
cast_x[0]= 0;
cast_y[0]= 0;

//second point, top right corner
cast_x[1]= sprite_width;
cast_y[1]= 0;

//third point, down right corner
cast_x[2]= sprite_width;
cast_y[2]= sprite_height;

//fourth point, down left corner
cast_x[3]= 0;
cast_y[3]= sprite_height;
