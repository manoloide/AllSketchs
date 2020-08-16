class Stroke {
  ArrayList<PVector> points; 

  Stroke() {
    
    points = new ArrayList<PVector>();
    
  }

  void add(PVector p) {
    
    points.add(p);
    
  }
}