class Camera {
  float x, y, dx, dy, rx, ry;
  Camera(float x, float y) {
    this.x = dx = x; 
    this.y = dy = y;
  }
  
  void update() {

    if (textView.select != null) {
      dx = width/2-100;
    } else {
      dx = width/2;
    }

    x += (dx-x)*0.1;
    y += (dy-y)*0.1;

    rx = x-width/2; 
    ry = y-height/2;
    translate(rx, ry);
  }
}

