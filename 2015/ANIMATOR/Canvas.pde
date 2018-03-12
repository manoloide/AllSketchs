class Canvas {
  int x, y, w, h;
  int zoom;
  PImage surface;
  PGraphics frame;
  Canvas() {
    w = 640;
    h = 480;
    zoom = 1;
    frame = createGraphics(w, h);
    frame.beginDraw(); 
    frame.clear(); 
    frame.endDraw();
  }
  void update() {
    float mx = mouseX-x; 
    float my = mouseY-y;
    if (mousePressed) {
      frame.beginDraw();
      frame.ellipse(mx, my, 2, 2);
      frame.endDraw();
    }
    show();
  }
  void show() {
    noStroke();
    fill(255);
    rect(x, y, frame.width*zoom, frame.height*zoom);
    image(frame, x, y, frame.width*zoom, frame.height*zoom);
  }
}

