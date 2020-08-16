class Frame {
  ArrayList<Shape> shapes;
  PGraphics render;
  Frame() {
  }
  void show() {
    render.beginDraw();
    render.clear();
    for (int i = 0; i < shapes.size (); i++) {
      Shape s = shapes.get(i);
      s.draw(render);
    }
    render.endDraw();
  }
}

