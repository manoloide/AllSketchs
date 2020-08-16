ArrayList<Node> nodes;
boolean mouseClicked;
void setup() {
  size(640, 640);
  nodes = new ArrayList<Node>();
  Node init = new Node(null, width/2, height/2, 100);
  nodes.add(init);
  for (int i = 0; i < 9; i++) {
    Node seg = new Node(init, 50);
    int r = int(random(2, 5)); 
    for (int j = 0; j < r; j++) {
      Node tri = new Node(seg, 10);
      /*
      for (int k = 0; k < 1; k++) {
       Node qua = new Node(tri, 16);
       }*/
    }
  }
  init.init();
}

void draw() {
  //println(frameRate, nodes.size());
  background(255);
  for (int i = 0; i < nodes.size (); i++) {
    Node n = nodes.get(i);
    n.update();
  }
  mouseClicked = false;
}

void mousePressed() {
  mouseClicked = true;
}

