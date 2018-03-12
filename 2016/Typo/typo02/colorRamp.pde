class Color {
  color col;
  float pos;
  boolean solid;
  Color (int col, float pos, boolean solid) {
    this.col = color(col);
    this.pos = pos;
    this.solid = solid;
  }
  Color (int col, float pos) {
    this(col, pos, false);
  }
}

class ColorRamp {
  ArrayList<Color> colors;
  ColorRamp () {
    colors = new ArrayList<Color>();
  }

  void addColor(int c, float p, boolean s) {
    p = constrain(p, 0, 1);
    int ind = 0;
    for (int i = 0; i < colors.size (); i++) {
      ind = i;
      if (p >= colors.get(i).pos) {
        break;
      }
    }
    colors.add(ind, new Color(c, p, s));
  }

  void addColor(int c, float p) {
    addColor(c, p, false);
  }

  color getColor() {
    return getColor(random(1));
  }

  color getColor(float p) {
    p = constrain(p, 0, 1);
    color col = color(0);

    if (colors.size() > 0) {
      col = colors.get(colors.size()-1).col;
    } 


    for (int i = 1; i < colors.size (); i++) {
      if (p >= colors.get(i).pos) {
        Color ant = colors.get(i-1);
        Color act = colors.get(i);
        if (ant.solid) col = ant.col;
        else col = lerpColor(ant.col, act.col, map(p, ant.pos, act.pos, 0, 1));
        break;
      }
    }
    return col;
  }

  void show(float x, float y, float w, float h) {
    for (int i = 0; i < w; i++) {
      stroke(getColor(i*1./w));
      line(x+i, y, x+i, y+h);
    }
  }
}

