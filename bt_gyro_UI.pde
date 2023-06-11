color cube;
color x, y, z;
color zo;
color fit, f8;
color home, end;

void setup() {
  //orientation(PORTRAIT);
  size(720, 1280, P3D);
  
  cube = color(#C0C0C0);
  x = color(#C0C0C0);
  y = color(#C0C0C0);
  z = color(#C0C0C0);
  zo = color(#C0C0C0);
  fit = color(#C0C0C0);
  f8 = color(#C0C0C0);
  home = color(#C0C0C0);
  end = color(#C0C0C0);
}

void draw() {
  background(#C0C0C0);

  drawUI();
}
