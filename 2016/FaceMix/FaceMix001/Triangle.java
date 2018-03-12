import processing.core.PVector;

public class Triangle {

  public PVector p1, p2, p3;
  
  public Triangle() { 
    p1=null;
    p2=null;
    p3=null; 
  }
  
  public Triangle(PVector p1, PVector p2, PVector p3) {
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
  }
  
  public boolean sharesVertex(Triangle other) {
    return p1 == other.p1 || p1 == other.p2 || p1 == other.p3 ||
           p2 == other.p1 || p2 == other.p2 || p2 == other.p3 || 
           p3 == other.p1 || p3 == other.p2 || p3 == other.p3;
  }
  
}