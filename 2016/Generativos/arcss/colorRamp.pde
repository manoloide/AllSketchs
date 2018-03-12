class Color {
  color col;
  float pos;
  Color (int col, float pos) {
    this.col = col;
    this.pos = pos;
  }
}

class ColorRamp {
  ArrayList<Color> colors;
  ColorRamp () {
    colors = new ArrayList<Color>();
  }

  void addColor(int c, float p) {
    p = constrain(p, 0, 1);
    int ind = 0;
    for (int i = 0; i < colors.size (); i++) {
      ind = i;
      if (p >= colors.get(i).pos) {
        break;
      }
    }
    colors.add(ind, new Color(c, p));
  }

  color getColor(float p) {
    p = constrain(p, 0, 1);
    color col = color(0);

    if (colors.size() > 0) col = colors.get(0).col;

    for (int i = 1; i < colors.size (); i++) {
      if (p >= colors.get(i).pos) {
        col = lerpColor(colors.get(i-1).col, colors.get(i).col, map(p, colors.get(i-1).pos, colors.get(i).pos, 0, 1));
        break;
      }
    }
    return col;
  }

  void show(float x, float y, float w, float h) {
    for (int i = 0; i < w; i++) {
      stroke(getColor(i*1./w));
      line(x, y+i, x+w, y+i);
    }
  }
}

