class ColorRamp {
  IntList colors;
  FloatList values;
  ColorRamp() {
    colors = new IntList();
    values = new FloatList();
  }

  void addColor(int col, float val) {
    colors.append(col);
    values.append(val);
  }

  int getColor(float c) {
    c %= 1;
    float v1 = 0;
    float v2 = 0;
    int c1 = colors.get(0);
    int c2 = colors.get(0);
    for (int i = 1; i < colors.size(); i++) {
      c1 = colors.get(i-1);
      c2 = colors.get(i+0);
      v1 = values.get(i-1);
      v2 = values.get(i+0);
      if (values.get(i) > c) {
        v1 = lerp(v1, v2, c);
        break;
      }
    }
    return lerpColor(c1, c2, v1);
  }
}
