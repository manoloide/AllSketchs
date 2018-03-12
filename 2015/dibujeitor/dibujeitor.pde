import codeanticode.tablet.*;

ArrayList<Layer> layers;
Layer layer;
Stroke stroke;
Tablet tablet;

void setup(){
  size(800, 600);
  tablet = new Tablet(this); 
  layer = new Layer();
  stroke = new Stroke();
  layer.addStroke(stroke);
}

void draw(){
  frame.setTitle("Fps: "+frameRate);
  background(254);
  layer.update();
  stroke.show(g);
}

void mouseDragged(){
  //tablet.getPressure()*
  stroke.vectores.add(new PVector(mouseX, mouseY, 30*random(1)));
}

void mouseReleased(){
  layer.addStroke(stroke);
  stroke = new Stroke();
}
