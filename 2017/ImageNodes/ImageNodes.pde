ArrayList<Node> nodes;
AddNode addNode;
PImage render;

void setup() {
  size(960, 960);
  nodes = new ArrayList<Node>();

  render = createImage(512, 512, RGB);
}


void draw() {
  background(30);

  image(render, 0, 0);

  for (int i = 0; i < nodes.size(); i++) {
    Node n = nodes.get(i);
    n.update();
    n.show();
  }

  if (addNode != null) {
    addNode.update();
    addNode.show();
  }

  noStroke();
  fill(0, 250);
  rect(0, 0, width, 20);

  /*
  Wire w = new Wire();
   w.show();
   */
}

void mousePressed() {
  addNode = new AddNode(mouseX, mouseY);
  /*
  //nodes.add(new Node(mouseX, mouseY));
   render = perlin(render, random(0.05), new PVector(random(1000), random(1000)), random(1));
   PImage aux = edge(render);
   aux = edge(aux);
   render = mix(render, aux, random(1));
   PImage radial = radialGradient(render, new PVector(random(render.width), random(render.height)), render.width*random(1));
   render = mix(render, radial, random(1));
   render = edge(render);
   */
}

PImage noise(PImage ori, boolean col) {
  PImage aux = ori.get();
  for (int j = 0; j < aux.height; j++) {
    for (int i = 0; i < aux.width; i++) {
      color val = (col)? color(random(256), random(256), random(256)) : color(random(256));
      aux.set(i, j, val);
    }
  }
  return aux;
}


PImage perlin(PImage ori, float det, PVector pos, float amp) {
  PImage aux = ori.get();
  for (int j = 0; j < aux.height; j++) {
    for (int i = 0; i < aux.width; i++) {
      float val = pow(noise(pos.x+det*i, pos.y+det*j), amp);
      aux.set(i, j, color(val*256));
    }
  }


  return aux;
}

PImage radialGradient(PImage ori, PVector pos, float size) {
  PImage aux = ori.get();
  for (int j = 0; j < aux.height; j++) {
    for (int i = 0; i < aux.width; i++) {
      float val = 1-constrain(dist(pos.x, pos.y, i, j)/size, 0, 1);
      val = pow(val, 0.8);
      aux.set(i, j, color(val*256));
    }
  }
  return aux;
}

PImage blur(PImage ori) {
  float v = 1.0 / 9.0;
  float[][] kernel = {{ v, v, v }, { v, v, v }, { v, v, v }};
  PImage aux = createImage(ori.width, ori.height, RGB);
  for (int y = 1; y < aux.height-1; y++) {
    for (int x = 1; x < aux.width-1; x++) {
      float sum = 0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          float val = red(ori.get(x+kx, y+ky));
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      aux.set(x, y, color(sum));
    }
  }
  aux.updatePixels();
  return aux;
}



PImage edge(PImage ori) {
  float[][] kernel = {{ -1, -1, -1}, 
    { -1, 9, -1}, 
    { -1, -1, -1}};
  ori.loadPixels();
  PImage aux = createImage(ori.width, ori.height, RGB);
  for (int y = 1; y < aux.height-1; y++) { 
    for (int x = 1; x < aux.width-1; x++) {
      float sum = 0; 
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          float val = red(ori.get(x+kx, y+ky));
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      aux.set(x, y, color(sum));
    }
  }
  aux.updatePixels();
  return aux;
}



PImage mix(PImage img1, PImage img2, float mix) {
  PImage aux = img1.get();
  for (int j = 0; j < aux.height; j++) {
    for (int i = 0; i < aux.width; i++) {
      color v1 = img1.get(i, j);
      color v2 = img2.get(i, j);
      aux.set(i, j, lerpColor(v1, v2, mix));
    }
  }
  return aux;
}

/*
PImage blur(PImage ori, float det, PVector pos, float amp) {
 PImage aux = ori.get();
 for (int j = 0; j < aux.height; j++) {
 for (int i = 0; i < aux.width; i++) {
 float val = pow(noise(pos.x+det*i, pos.y+det*j), amp);
 aux.set(i, j, color(val*256));
 }
 }
 return aux;
 }
 */




///////////////////////////

class In {
}

class Out {
}

class Wire {
  float x1, y1, x2, y2;
  Wire() {
    x1 = 100;
    y1 = 100;
    x2 = mouseX;
    y2 = mouseY;
  }

  void show() {
    float dx = (x1-x2)*0.5;
    float dy = 0;//(y1-y2)*0.5;
    strokeWeight(2);
    stroke(100);
    noFill();
    bezier(x1, y1, x1-dx, y1-dy, x2+dx, y2+dy, x2, y2);
  }
}

class AddNode {
  float x, y, w, h;
  String text;
  AddNode(float x, float y) {
    this.x = x; 
    this.y = y;
    w = 120;
    h = 18;
    text = "Test 1!";
  }

  void update() {
  }

  void show() {

    fill(230);
    rect(x-w*0.5, y-h*0.5, w, h);
    textAlign(CENTER, TOP);
    textSize(14);
    fill(0);
    text(text, x-w*0.5, y-h*0.5, w, h);
  }
}

class Node {
  ArrayList<In> ins;
  ArrayList<Out> outs;
  boolean on, select, moved; 
  float x, y, w, h;
  String name;

  Node(float x, float y) {
    w = 120; 
    h = 100;
    this.x = x-w/2;
    this.y = y-h/2;
  }

  void update() {
  }

  void process() {
  }

  void show() {
    stroke(60);
    if (select) stroke(255, 200, 0);
    fill(70);
    rect(x, y, w, h, 4);
    noStroke();
    fill(55);
    rect(x+1, y+1, w-1, 19, 4, 4, 0, 0);
  }
}