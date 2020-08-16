int seed = int(random(99999));

ArrayList<Node> nodes;

float depth;

PVector camera;

void setup() {
  size(1280, 720, P3D);
  pixelDensity(2);
  smooth(4);

  camera = new PVector();

  generate();
}

void draw() {
  background(#312C50);

  camera.x = lerp(camera.x, width*0.3-mouseX*0.6, 0.08);
  camera.y = lerp(camera.y, height*0.3-mouseY*0.6, 0.08);

  translate(camera.x, camera.y, depth);

  for (int i = 0; i < nodes.size(); i++) {
    Node n = nodes.get(i);
    n.show();
    /*
    pushMatrix();
    translate(n.x, n.y, n.z);
    sphere(20);
    popMatrix();
    */
  }
}

void keyPressed() {
  seed = int(random(99999));
  generate();
}

void mousePressed() {
  nodes.add(new Node(mouseX-camera.x, mouseY-camera.y, -depth));
}

void generate() {
  nodes = new ArrayList<Node>();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  depth += e;
}
