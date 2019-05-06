///scr_text_outline(x, y, text, scale, *outline_color);

var x1 = argument[0],
  y1 = argument[1],
  text = argument[2],
  size = argument[3];
  c1 = c_black;

var c2 = draw_get_colour();

if (argument_count >= 4)
{
  c1 = argument[4];
}

draw_set_color(c1);

draw_text_transformed(x1 - 1, y1 - 1, text, size,size,0);
draw_text_transformed(x1, y1 - 1, text, size,size,0);
draw_text_transformed(x1 + 1, y1 - 1, text, size,size,0);
draw_text_transformed(x1 - 1, y1, text, size,size,0);
draw_text_transformed(x1 + 1, y1, text, size,size,0);
draw_text_transformed(x1 - 1, y1 + 1, text, size,size,0);
draw_text_transformed(x1, y1 + 1, text, size,size,0);
draw_text_transformed(x1 + 1, y1 + 1, text, size,size,0);

draw_set_color(c2);

draw_text_transformed(x1, y1, text, size, size, 0);
