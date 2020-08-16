class Node {
  ArrayList<Node> nodes;
  float cx, cy;
  float x, y, s;
  float ang;
  Node parent;
  Trend select;
  String name;
  Touch touch;
  Node(Node parent, float x, float y, String name) {
    this.parent = parent;
    this.name = name;
    if (parent != null) {
      this.x = parent.x; 
      this.y = parent.y;
      cx = x; 
      cy = y;
      parent.addNode(this);
    } else {
      setPosition(x, y);
    }
    nodes = new ArrayList<Node>();
  }

  void init() {
  }

  void update() {
    ang = atan2(y-parent.y, x-parent.x);
  }

  void show() {
  }

  Node getNode(String name) {
    for (int i = 0; i < nodes.size (); i++) {
      Node n = nodes.get(i);
      if (n.name.equals(name)) {
        return n;
      }
    } 
    return null;
  }

  void addNode(Node n) {
    nodes.add(n);
  }

  void setParent(Node parent) {
    this.parent = parent;
  }

  void setPosition(float x, float y) {
    this.x = cx = x;
    this.y = cy = y;
    if (parent != null) ang = atan2(y-parent.y, x-parent.x);
  }
}

