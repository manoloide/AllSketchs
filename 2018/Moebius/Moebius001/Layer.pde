class Layer {
  
  ArrayList<Stroke> strokes;
  
  Brush brush;
  Stroke stroke;
  
  Layer() {
     
     strokes = new ArrayList<Stroke>();
    
     brush = new Brush();
     stroke = new Stroke(); 
     
     strokes.add(stroke);
     
  }
  
  void draw(PGraphics render){
    
    for(int i = 0; i < strokes.size(); i++){
      Stroke stroke = strokes.get(i);
      brush.draw(render, stroke);
    }
    
  }
  
}