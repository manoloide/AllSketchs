int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  //render();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(999999));

  render();
}

void render() {

  background(0);
  translate(width/2, height/2);

  ArrayList<PVector> quads = new ArrayList<PVector>();

  quads.add(new PVector(0, 0, width));

  int sub = int(pow(10 , random(1, random(1, 2)))); 
  for (int i = 0; i < sub; i++) {
    int ind = int(random(quads.size()));
    PVector q = quads.get(ind); 
    float ms = q.z*0.5; 
    quads.add(new PVector(q.x-ms*0.5, q.y-ms*0.5, ms));
    quads.add(new PVector(q.x+ms*0.5, q.y-ms*0.5, ms));
    quads.add(new PVector(q.x+ms*0.5, q.y+ms*0.5, ms));
    quads.add(new PVector(q.x-ms*0.5, q.y+ms*0.5, ms));
    quads.remove(ind);
  }

  rectMode(CENTER); 
  noStroke();
  //stroke(0);
  for (int i = 0; i < quads.size(); i++) {
    PVector q = quads.get(i); 
    int c1 = getColor(colors.length*random(2));//rcol(); 
    int c2 = getColor(colors.length*random(2));//rcol();
    float ms = random(0.2, 1); 
    ms = 0.25;
    int dir = int(random(4));
    //dir = int(4+atan2(q.y, q.x)/HALF_PI)%4;
    int dx = ((dir/2)%2)*2-1;
    int dy = (dir%2)*2-1;
    float dd = (q.z-q.z*ms)*0.5;
    fill(c2);
    beginShape();
    endShape(CLOSE);
    rect(q.x, q.y, q.z, q.z); 
    fill(c2);
    rect(q.x+dd*dx, q.y+dd*dy, q.z*ms, q.z*ms);
    fill(0, 80);
    float d2 = (q.z*0.5-dd*2);
    beginShape();
    fill(0, 80);
    vertex(q.x-dx*d2, q.y+dy*q.z*0.5);
    vertex(q.x-dx*d2, q.y-dy*d2);
    fill(0, 0);
    vertex(q.x-dx*q.z*0.5, q.y-dy*q.z*0.5, 5, 5);
    vertex(q.x-dx*q.z*0.5, q.y+dy*q.z*0.5, 5, 5);
    endShape(CLOSE);

    fill(255, 80);
    beginShape();
    fill(255, 80);
    vertex(q.x-dx*d2, q.y-dy*d2);
    vertex(q.x+dx*q.z*0.5, q.y-dy*d2);
    fill(255, 0);
    vertex(q.x+dx*q.z*0.5, q.y-dy*q.z*0.5, 5, 5);
    vertex(q.x-dx*q.z*0.5, q.y-dy*q.z*0.5, 5, 5);
    endShape(CLOSE);
  }
}

int colors[] = {#F8CA9C, #F8B6D9, #EF276B, #A14FBE, #1D43B8};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};
int rcol() {
  return colors[int(random(colors.length))] ;
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}