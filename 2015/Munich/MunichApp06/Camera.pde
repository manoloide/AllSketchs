class Camera {
  float rx, ry, x, y;
  Camera(float x, float y) {
    this.x = x; 
    this.y = y;
  }
  void update() {
    rx = x-width/2;
    ry = y-height/2;
    translate(rx, ry);
  }
}

