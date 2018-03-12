ColorSchemes colors;

void setup() {
  size(720, 480);
  pixelDensity(2);
  colors = new ColorSchemes(this);
}

void draw() {
  colors.show();
}