class  LutFilter {
  boolean loaded;
  String src;
  PVector lut[][][];
  LutFilter(String src) {
    loaded = false;
    load(src);
  }

  void load(String src) {
    this.src = src; 
    lut = new PVector[32][32][32];

    String lines[] = loadStrings(src);

    if (lines != null) {
      for (int i = 0; i < 32*32*32; i++) {
        int x = i%32;
        int y = (i/32)%32;
        int z = (i/32)/32;
        String val[] = split(lines[i+5], " ");
        lut[x][y][z] = new PVector(float(val[0]), float(val[1]), float(val[2]));
      }

      loaded = true;
    }
  }
  void apply() {
    image(apply(g.get()), 0, 0);
  }
  void apply(float intensity) {
    image(apply(g.get(), intensity), 0, 0);
  }
  PImage apply(PImage ori) {
    return apply(ori, 1);
  }
  PImage apply(PImage ori, float intensity) {
    pushStyle();
    colorMode(RGB);
    ori.loadPixels();
    for (int j = 0; j < height; j++) {
      for (int i = 0; i < width; i++) {
        color col = ori.get(i, j);

        int lutPos[] = new int[3];
        for (int m = 0; m < 3; m++) {
          if (m == 0) lutPos[m] = int(red(col)) / 8;
          if (m == 1) lutPos[m] = int(green(col)) / 8;
          if (m == 2) lutPos[m] = int(blue(col)) / 8;
          if (lutPos[m]==31) {
            lutPos[m]=30;
          }
        }

        PVector start = lut[lutPos[0]][lutPos[1]][lutPos[2]];
        PVector end = lut[lutPos[0]+1][lutPos[1]+1][lutPos[2]+1]; 

        float ar = (int(red(col)) % 8) / 8.0f;
        float ag = (int(green(col)) % 8) / 8.0f;
        float ab = (int(blue(col)) % 8) / 8.0f;
        float r = (start.x + ar * (end.x - start.x)) * 255;
        float g = (start.y + ag * (end.y - start.y)) * 255;
        float b = (start.z + ab * (end.z - start.z)) * 255;

        col = lerpColor(col, color(r, g, b), intensity);

        ori.set(i, j, col);
      }
    }
    ori.updatePixels();
    popStyle();

    return ori;
  }
}

