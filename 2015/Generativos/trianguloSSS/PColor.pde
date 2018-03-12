class PColor {
  int Palette[];

  void newPalette(int... col) {
    Palette = col;
  }

  void addColor(int... col) {
    int aux[] = new int[Palette.length+col.length];
    for (int i = 0; i < Palette.length; i++) {
      aux[i] = Palette[i];
    }
    for (int i = 0; i < col.length; i++) {
      aux[Palette.length+1+i] = col[i];
    }
  }

  void randomPaletta(int c) {
    Palette = new int[c];
    for (int i = 0; i < c; i++) {
      Palette[i] = rgb();
    }
  }  

  int rcol() {
    return Palette[int(random(Palette.length))];
  }

  color rgb() {
    return color(random(256), random(256), random(256));
  }
  color rgba() {
    return color(random(256), random(256), random(256), random(256));
  }
  color comp(color col) {
    return color(255-red(col), 255-green(col), 255-blue(col));
  }
  color h(color c, float v){
    pushStyle();
    colorMode(HSB, 256, 256, 256);
    float h = (hue(c)+v)%256;
    color a = color(h, saturation(c), brightness(c));
    popStyle();
    return a;
  }
  color s(color c, float v){
    pushStyle();
    colorMode(HSB, 256, 256, 256);
    color a = color(hue(c), saturation(c)+v, brightness(c));
    popStyle();
    return a;
  }
  color b(color c, float v){
    pushStyle();
    colorMode(HSB, 256, 256, 256);
    color a = color(hue(c), saturation(c), brightness(c)+v);
    popStyle();
    return a;
  }
  color mod(color c, float m){
     float mr = random(m);
     float mg = random(m);
     float mb = random(m);
     
     float tt = (mr+mg+mb)/m;
     
     println(m, tt);
     return color(red(c)+mr, green(c)+mg, blue(c)+mb);
  }
}
