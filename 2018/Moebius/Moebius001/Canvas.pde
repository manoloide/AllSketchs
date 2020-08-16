class Canvas {
  
  ArrayList<Layer> layers;
  int w, h;
  PGraphics render;
  
  Layer layerSelect;
  
  Canvas(int w, int h) {
    
    this.w = w; 
    this.h = h;
    render = createGraphics(w, h);
    layers = new ArrayList<Layer>();
    
    layerSelect = new Layer();
    layers.add(layerSelect);
    
  }

  void update() {
    
  }

  void show() {
     
  }
  
  void updateGraphics(){
    
     render.beginDraw();
     render.background(255);
     for(int i = 0; i < layers.size(); i++){
         Layer layer = layers.get(i);
         layer.draw(render);
     }
     render.endDraw();
     
  }
}