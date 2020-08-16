Canvas canvas;
UI ui;

void setup(){
  
   size(960, 540); 
   pixelDensity(2);
   
   canvas = new Canvas(width, height);
   initUI();
   
}

void initUI(){
  
  ui = new UI();
  ui.add((new UISection()).setPosition(0, 0).setSize(width, 20).setName("TopMenu"));
  ui.add((new UISection()).setPosition(0, 20).setSize(30, height-20).setName("ToolMenu"));
  ui.add((new UISection()).setPosition(width-120, 20).setSize(120, height-20).setName("Menu"));

}

void draw(){
  
  background(160);
  
  canvas.update();
  canvas.show();
  canvas.updateGraphics();
  image(canvas.render, 0, 0);
  
  ui.update();
  ui.show();
  
}

void mousePressed() {
 
   Stroke stroke = new Stroke();
   canvas.layerSelect.strokes.add(stroke);
   canvas.layerSelect.stroke = stroke;
   canvas.layerSelect.stroke.add(new PVector(mouseX, mouseY));
  
}

void mouseDragged() {
 
   canvas.layerSelect.stroke.add(new PVector(mouseX, mouseY));
  
}