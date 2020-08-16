class Node {
  boolean on;
  float x, y, z;
  Node(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  void show() {
    stroke(255);
    strokeWeight(40);
    point(x, y, z);
    if (on) {
      stroke(255, 20);
      strokeWeight(50);
      point(x, y, z);
    }
  }
}
