class ScrollH {
  float x, y, width, height, max, min, val;
  
  ScrollH(float nx, float ny, float nw, float nh, float nmin, float nmax, float nvar) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    max = nmax;
    min = nmin;
    val = nvar;
  }

  void act() {
    if (mousePressed) {
      if ( mouseX >= x + height/2 - 8 && mouseX <= x + width - height/2 + 8) {
        if ( mouseY >= y  && mouseY <= y + height)
          val = min + (max-min) * ((mouseX- height/2 - x )/(width - height));
        if (val < min) {
          val = min;
        }
        else if (val > max) {
          val = max;
        }
      }
    } 
    draw();
  }

  void draw() {
    fill(120);
    rect(x, y, width, height);

    fill(150);
    float pos = x + ((width-height) * (val-min)/(max-min));
    rect(pos, y, height, height);
  }
}
