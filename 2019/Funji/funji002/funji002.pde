import org.processing.wiki.triangulate.*;
import peasy.PeasyCam;

int seed = int(random(99999));

PeasyCam cam;

void settings() {
  size(800, 600, P3D);
  pixelDensity(2);
  smooth(4);
}

public void setup() {
  cam = new PeasyCam(this, 400);
  //cam.se
}

void draw() {
  background(180);


  float fov = PI/random(1, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);

  noiseSeed(seed);
  randomSeed(seed);
  stroke(255);

  ArrayList<PVector> points = new ArrayList<PVector>(); 
  float size = width*1.6;
  int ccc = int(random(120));
  for (int i = 0; i < ccc; i++) {
    float x = random(-size*0.5, size*0.5);
    float y = random(-size*0.5, size*0.5);
    float z = random(-size*0.5, size*0.5);

    points.add(new PVector(x, y, z));
  }

  ArrayList tris = new ArrayList();
  tris = Triangulate.triangulate(points);

  noFill();
  beginShape(TRIANGLES);
  stroke(120);
  //strokeWeight(0.6);
  strokeWeight(1);
  for (int i = 0; i < tris.size(); i++) {
    if (random(1) < 0.8) continue;
    Triangle t = (Triangle)tris.get(i);
    vertex(t.p1.x, t.p1.y, t.p1.z);
    vertex(t.p2.x, t.p2.y, t.p2.z);
    vertex(t.p3.x, t.p3.y, t.p3.z);
  }
  endShape();

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    stroke(rcol());
    strokeWeight(map(cos(frameCount*random(0.1)), -1, 1, random(12), random(80)));
    point(p.x, p.y, p.z);
  }
}

void keyPressed() {
  seed = int(random(99999));
}

//int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
int colors[] = {#DEE2E3, #E7BD07, #DEE2E3, #4FAEE6, #0A142B, #19645D, #D07EBA, #DE5621};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
//int colors[] = {#000000, #ffffff};
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
