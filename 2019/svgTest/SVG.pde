class SVG {
  int width, height;
  PGraphics render;
  SVG(int width, int height) {
    render = createGraphics(width, height);
  }

  void save(String name) {
  }

  void line(float x1, float y1, float x2, float y2) {
    render.line(x1, y1, x2, y2);
  }
  
  
}
