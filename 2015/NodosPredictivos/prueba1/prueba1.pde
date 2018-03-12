int paleta[] = {
  #11644D,
  #A0B046,
  #F2C94E,
  #F78145,
  #F24E4E
};

ArrayList<Node> nodes;

void setup() {
  size(800, 600, P3D);
  nodes = new ArrayList<Node>();
  nodes.add(new Node(width/2, height/2, ""));
}

void draw() {
  background(20);
  for (int i = 0; i < nodes.size (); i++) {
    Node n = nodes.get(i);
    n.update();
    if (n.remove) nodes.remove(i--);
  }
}

void keyPressed() {
  nodes = new ArrayList<Node>();
  nodes.add(new Node(width/2, height/2, ""));
}

class Node {
  ArrayList<Node> children;
  boolean remove;
  float cx, cy, x, y;
  String txt;
  Node(float x, float y, String txt) {
    cx = this.x = x; 
    cy = this.y = y;
    this.txt = txt;
    children = new ArrayList<Node>();
  }

  void update() {
    for (int i = 0; i < children.size (); i++) {
      Node c = children.get(i);
      c.update();
    }
    if (txt.length() < 1) {
      txt += (char) int(random(97, 123));
    }
    if (children.size() < 4 && random(100) < 2) {
      searchWords();
    }
    show();
  }

  void show() {
    int bb = 4;
    float ww = textWidth(txt)+bb*2;
    float hh = 20+bb*2;
    rectMode(CENTER);
    textSize(20);
    textAlign(CENTER, CENTER);
    fill(0);
    rect(x, y, ww, hh);
    fill(250);
    text(txt, x, y);
  }

  void searchWords() {
    String bus = txt.replace(' ', '+');
    JSONArray aux = loadJSONArray("http://suggestqueries.google.com/complete/search?q="+bus+"&client=firefox&hl=es");
    JSONArray list = aux.getJSONArray(1);
    int cant = min(list.size (), 4);
    for (int i = 0; i < cant; i++) {
      float xx = x+cos(TWO_PI/cant*i)*50;
      float yy = y+sin(TWO_PI/cant*i)*50;
      children.add(new Node(xx, yy, list.getString(i)));
    }
    print(list);
  }
}

