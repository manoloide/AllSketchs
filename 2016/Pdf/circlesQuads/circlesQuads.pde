import processing.pdf.*;
void settings() {
  float widthCm = 20;
  float heightCm = 20;
  float dpi = 150;
  int w = int((widthCm*dpi)/2.54);
  int h = int((heightCm*dpi)/2.54);
  print(w, h);
  size(w, h, PDF, getTimestamp()+".pdf");
}

void setup() {
}

void draw() {
  background(250);
  ArrayList<PVector> quads = new ArrayList<PVector>();
  quads.add(new PVector(width/2, height/2, width*0.96));

  int sub = int(pow(2, random(4, 14)));
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
  for (int i = 0; i < quads.size(); i++) {
    PVector q = quads.get(i);
    color aux = rcol();
    /*
    stroke(aux);
     fill(aux);
     rect(q.x, q.y, q.z, q.z);
     */
    noStroke();
    quad2(q.x, q.y, q.z, rcol(), rcol());


    float ang = random(TWO_PI);
    float mm = random(0.1, 0.96);
    stroke(0, 6);
    noFill();
    strokeWeight(q.z*mm*0.02);
    ellipse(q.x, q.y, q.z*mm, q.z*mm);
    strokeWeight(q.z*mm*0.01);
    ellipse(q.x, q.y, q.z*mm, q.z*mm);
    strokeWeight(1);
    noStroke();
    fill(rcol());
    ellipse(q.x, q.y, q.z*mm, q.z*mm);
    aux = rcol();
    strokeCap(RECT);
    strokeWeight(q.z*mm*0.001);
    stroke(aux);
    fill(aux);
    arc(q.x, q.y, q.z*mm, q.z*mm, ang, ang+PI);
  }

  /*
  noFill();
  int cc = int(random(500, 2000));
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(14)*random(0.1, 1);
    float a1 = random(TWO_PI);
    float a2 = a1+random(PI*0.8);
    stroke(255, random(256)*random(1)*random(1)*random(1));
    arc(x, y, s, s, a1, a2);
  }
  */

  // Exit the program 
  println("Finished.");
  exit();
}

void quad2(float x, float y, float s, color c1, color c2) {
  float ms = s*0.5; 
  beginShape();
  fill(c1);
  vertex(x-ms, y-ms);
  vertex(x+ms, y-ms);
  fill(c2);
  vertex(x+ms, y+ms);
  vertex(x-ms, y+ms);
  endShape();
}

int pallet[] = {#513C3C, #2A769A, #41C3BE, #F7F36B};
int rcol() {
  return pallet[int(random(pallet.length))];
}

String getTimestamp() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  return timestamp;
}