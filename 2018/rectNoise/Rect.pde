class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void show() {
    rect(x, y, w, h);
  }
  void remove() {
  }
}

class NoiseRect extends Rect {
  Pan pan;
  MoogFilter  moog;
  Noise noise;
  int type = 0;
  NoiseRect(float x, float y, float w, float h) {
    super(x, y, w, h);
    noise = new Noise(0.5/subdivisions);

    int type = int(random(3));
    if (type == 0) noise.setTint(Noise.Tint.WHITE);
    if (type == 1) noise.setTint(Noise.Tint.PINK);
    if (type == 2) noise.setTint(Noise.Tint.RED);

    moog = new MoogFilter(random(0, 12000*random(1)*random(1)), random(random(1), 1) );
    pan = new Pan(map(x+w*0.5, 0, width, 0, 1));

    noise.patch(moog).patch(pan).patch(out);
  }

  void remove() {
    noise.unpatch(moog);
    moog.unpatch(pan);
    pan.unpatch(out);

    noise = null;
    moog = null;
    pan = null;
  }

  void show() {
    float values[] = pan.getLastValues();
    for (int i = 0; i < values.length-1; i++) {
      float x1 = x+map(i, 0, values.length, 0, w);
      float x2 = x+map(i+1, 0, values.length, 0, w);
      line(x1, y+(values[i]*0.5+0.5)*h, x2, y+(values[i+1]*0.5+0.5)*h);
      line(x1, y+(values[i]*0.5+0.5)*h, x2, y+(values[i+1]*0.5+0.5)*h);
    }
  }
}
