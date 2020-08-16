//-lista de strokes
//-imagen prerender

class Layer {
  ArrayList<Stroke> strokes;
  PGraphics img;
  Layer() {
    img = createGraphics(640, 480); 
    strokes = new  ArrayList<Stroke>();
    render();
  }
  void update() {
    //render();
    show();
  }
  void show() {
    image(img, 0, 0);
  }
  void render() {
    img.beginDraw();
    img.clear();
    for (int i = 0; i < strokes.size (); i++) {
      strokes.get(i).show(img);
    }
    img.endDraw();
  }
  void addStroke(Stroke s) {
    strokes.add(s);
    img.beginDraw();
    s.show(img);
    img.endDraw();
  }
}
