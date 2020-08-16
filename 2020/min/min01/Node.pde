class Node {
  ArrayList<Node> childs;
  float x, y, w, h;
  Node parent;
  
  Node() {
    parent = null;
  }
  Node(Node _parent) {
    parent = _parent;
  }
  Node(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
  Node(float x, float y, float w, float h, Node parent) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
  void update() {
  }
  void show() {
  }
}
