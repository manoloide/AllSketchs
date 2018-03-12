class Camera {
  float x, y;
  void update() {
    //limitMove();
    translate(int(x), int(y));
  }

  void limitMove() {
    x += (width/2.-mouseX)/width*2;
    y += (height/2.-mouseY)/height*2;
  }
}
