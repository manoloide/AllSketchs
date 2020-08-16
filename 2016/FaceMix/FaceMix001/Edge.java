import processing.core.PVector;

public class Edge {
  
  public PVector p1, p2;
  
  public Edge() {
    p1=null;
    p2=null;
  }
  
  public Edge(PVector p1, PVector p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
  
}