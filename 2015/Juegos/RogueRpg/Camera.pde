class Camera {
  float x, y;
  float cx, cy;
  float smooth;
  Camera(float x, float y) {
    this.x = cx = x;
    this.y = cy = y;
    smooth = 0.2;
  }
  void update() {
    x += (cx-x)*smooth;
    y += (cy-y)*smooth;
  }
  void setTarget(float nx, float ny) {
    cx = nx;
    cy = ny;
  }
}

