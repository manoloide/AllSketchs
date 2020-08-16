ArrayList<Node> nodes;
PFont font;

void setup() {

  fullScreen(); 
  //pixelDensity(2);
  frameRate(10);

  generate();

  font = createFont("lucida-console.ttf", 18, true);
  textFont(font);
}

void draw() {

  background(120, 5, 5);

  for (int i = 0; i < nodes.size(); i++) {
    Node n = nodes.get(i);
    n.update();
    n.show();
  }
}

void keyPressed() {  
  for (int i = 0; i < nodes.size(); i++) {
    Node n = nodes.get(i);
    if (n instanceof Screen) {
      Screen s = (Screen)n;
      s.keyPressed();
    }
  }
}

void generate() {
  nodes = new ArrayList<Node>();
  Screen screen = new Screen(10, 10, width-20, height-20);
  nodes.add(screen);
  int sub = int(random(1, 20));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(nodes.size()));
    Node act = nodes.get(ind);
    float nw = act.w;
    float nh = act.h;
    if (random(1) < 0.5) {
      float w1 = nw*random(0.3, 0.7);
      float w2 = nw-w1;
      nodes.add(new Screen(act.x, act.y, w1, act.h));
      nodes.add(new Screen(act.x+w1, act.y, w2, act.h));
    } else {
      float h1 = nh*random(0.3, 0.7);
      float h2 = nh-h1;
      nodes.add(new Screen(act.x, act.y, act.w, h1));
      nodes.add(new Screen(act.x, act.y+h1, act.w, h2));
    }
    nodes.remove(ind);
  }
}
