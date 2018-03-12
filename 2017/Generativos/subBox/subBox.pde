int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
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

  lights();
  seed = int(random(999999));
  background(getColor(random(colors.length*2)));
  translate(width/2, height/2, width*0.75);

  float fov = PI/1.25;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  ArrayList<PVector> quads = new ArrayList<PVector>();
  quads.add(new PVector(0, 0, width*4));

  int sub = int(random(2000, 6000)); 
  for (int i = 0; i < sub; i++) {
    int ind = int(random(quads.size())*random(0.5, 1));
    PVector q = quads.get(ind);
    float ms = q.z*0.5;
    quads.add(new PVector(q.x-ms*0.5, q.y-ms*0.5, ms));
    quads.add(new PVector(q.x+ms*0.5, q.y-ms*0.5, ms));
    quads.add(new PVector(q.x+ms*0.5, q.y+ms*0.5, ms));
    quads.add(new PVector(q.x-ms*0.5, q.y+ms*0.5, ms));
    quads.remove(ind);
  }

  //noFill();
  //stroke(255);
  noStroke();
  for (int i = 0; i < quads.size(); i++) {
    PVector q = quads.get(i);
    float dd = width*0.5-q.z*0.5;//*0.5;
    pushMatrix();
    if (random(1) < 0.4) {
      noFill();
      strokeWeight(random(1, 3));
      stroke(getColor(random(colors.length)));
    } else {
      noStroke();
      fill(getColor(random(colors.length)));
    }
    translate(q.x, q.y, -dd);
    box(q.z);
    popMatrix();
  }


  /*
  noStroke();
   rectMode(CENTER);
   for (int i = 0; i < quads.size(); i++) {
   PVector q = quads.get(i);
   int col = getColor(random(colors.length));
   float ms = q.z*0.5; 
   beginShape();
   fill(lerpColor(col, color(random(255)), random(0.2)));
   vertex(q.x-ms, q.y-ms);
   fill(lerpColor(col, color(random(255)), random(0.2)));
   vertex(q.x+ms, q.y-ms);
   fill(lerpColor(col, color(random(255)), random(0.2)));
   vertex(q.x+ms, q.y+ms);
   fill(lerpColor(col, color(random(255)), random(0.2)));
   vertex(q.x-ms, q.y+ms);
   endShape(CLOSE);
   }
   */
}


int colors[] = {#ECEAA4, #6D1E0A, #EF402C, #004500, #C7E969, #000000};
int rcol() {
  return colors[int(random(colors.length))] ;
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}