int seed = int(random(999999));

void setup() {
  size(3250, 3250, P3D);
  smooth(2);
  pixelDensity(2);
  generate();

  strokeWeight(3);
  saveImage();
  exit();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Box {
  int col;
  float x, y, z, s;
  Box(float x, float y, float z, float s) {
    this.x = x; 
    this.y = y; 
    this.z = z; 
    this.s = s;
    col = rcol();
  }

  void show() {
    float ms = s*0.4999;
    pushMatrix();
    translate(x, y, z);

    float v1 = (random(1) < 0.5)? -1 : 1;
    float v2 = (random(1) < 0.5)? -1 : 1;
    float v3 = (random(1) < 0.5)? -1 : 1;

    fill(rcol());
    beginShape();
    vertex(-ms, -ms, ms*v1);
    vertex(+ms, -ms, ms*v1);
    vertex(+ms, +ms, ms*v1);
    vertex(-ms, +ms, ms*v1);
    endShape(CLOSE);

    beginShape();
    vertex(-ms, ms*v2, -ms);
    vertex(+ms, ms*v2, -ms);
    vertex(+ms, ms*v2, +ms);
    vertex(-ms, ms*v2, +ms);
    endShape(CLOSE);
    beginShape();
    vertex(ms*v3, -ms, -ms);
    vertex(ms*v3, +ms, -ms);
    vertex(ms*v3, +ms, +ms);
    vertex(ms*v3, -ms, +ms);
    endShape(CLOSE);

    /*
    fill(rcol());
     beginShape();
     vertex(-ms, -ms, +ms);
     vertex(+ms, -ms, +ms);
     vertex(+ms, +ms, +ms);
     vertex(-ms, +ms, +ms);
     endShape(CLOSE);
     */

    popMatrix();
  }
}

void generate() {
  background(#00033D);

  ortho(-width/2, width/2, -height/2, height/2, 0.1, width*40);

  //lights();
  noStroke();
  stroke(0, 40);

  translate(0, 0, -width*3);
  rotateX(random(TAU));
  rotateY(random(TAU));
  rotateZ(random(TAU));

  ArrayList<Box> boxes = new ArrayList<Box>();
  boxes.add(new Box(0, 0, 0, width*random(1, 3)));

  int sub = int(random(10000));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(boxes.size()));
    Box b = boxes.get(i);

    float ms = b.s*0.5;
    boxes.add(new Box(b.x-ms*0.5, b.y-ms*0.5, b.z-ms*0.5, ms));
    boxes.add(new Box(b.x+ms*0.5, b.y-ms*0.5, b.z-ms*0.5, ms));
    boxes.add(new Box(b.x-ms*0.5, b.y+ms*0.5, b.z-ms*0.5, ms));
    boxes.add(new Box(b.x+ms*0.5, b.y+ms*0.5, b.z-ms*0.5, ms));
    boxes.add(new Box(b.x-ms*0.5, b.y-ms*0.5, b.z+ms*0.5, ms));
    boxes.add(new Box(b.x+ms*0.5, b.y-ms*0.5, b.z+ms*0.5, ms));
    boxes.add(new Box(b.x-ms*0.5, b.y+ms*0.5, b.z+ms*0.5, ms));
    boxes.add(new Box(b.x+ms*0.5, b.y+ms*0.5, b.z+ms*0.5, ms));

    boxes.remove(ind);
  }

  for (int i = 0; i < boxes.size(); i++) {
    Box b = boxes.get(i);
    b.show();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#FECBE0, #FEC602, #F29202, #27CC8C, #022EC2};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)];

  return lerpColor(c1, c2, v%1);
}