int paleta[] = {
  #11644D, 
  #A0B046, 
  #F2C94E, 
  #F78145, 
  #F24E4E
};

ArrayList<Node> nodes;
PFont font;

void setup() {
  size(800, 600);
  nodes = new ArrayList<Node>();
  nodes.add(new Node(width/2, height/2, "Helvetica"));
  font = createFont("HelveticaNeue-Bold", 18, true);
  textFont(font);
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
  boolean on, remove;
  float cx, cy, x, y, s;
  String txt;
  Node(float x, float y, String txt) {
    this.x = cx = x; 
    this.y = cy = y;
    this.txt = txt;
    s = 8;
    children = new ArrayList<Node>();
  }

  void update() {
    
    for (int i = 0; i < children.size (); i++) {
      Node c = children.get(i);
      c.update();
    }

    show();
  }

  void show() {
    textAlign(LEFT, CENTER);
    noStroke();
    fill(250);
    ellipse(x, y, s, s);
    text(txt, x+s*0.75, y);
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

