import org.processing.wiki.triangulate.*; 

int seed = int(random(999999));
Tipitos tipitos;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  tipitos = new Tipitos();
  generate();
}

void draw() {
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

  background(0);
  randomSeed(seed);

  ArrayList<PVector> quads = new ArrayList<PVector>();
  quads.add(new PVector(10, 10, width-20));

  int sub = int(random(100)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(quads.size()));
    PVector q = quads.get(ind);
    float ms = q.z*0.5;
    if (ms < 20) continue;
    quads.add(new PVector(q.x, q.y, ms));
    quads.add(new PVector(q.x+ms, q.y, ms));
    quads.add(new PVector(q.x+ms, q.y+ms, ms));
    quads.add(new PVector(q.x, q.y+ms, ms));
    quads.remove(ind);
  }

  noFill();
  for (int i = 0; i < quads.size(); i++) {
    PVector q = quads.get(i);
    float cx = q.x+q.z*0.5;
    float cy = q.y+q.z*0.5;
    stroke(255, 14);
    fill(rcol(), 10);
    rect(q.x+1, q.y+1, q.z-2, q.z-2);
    noStroke();
    beginShape();
    fill(255, 0);
    vertex(q.x+1, q.y+q.z*0.5);
    vertex(q.x+q.z-2, q.y+q.z*0.5);
    fill(255, 16);
    vertex(q.x+q.z-2, q.y+q.z-2);
    vertex(q.x+1, q.y+q.z-2);
    endShape(CLOSE);


    float cs = q.z/10;
    stroke(255, 3);
    fill(255, 1);
    noFill();
    for (int j = 1; j < 10; j++) {
      ellipse(cx, cy, cs*j, cs*j);
    }



    noStroke();
    arc2(cx, cy, q.z*0.1, q.z*0.8, 0, TAU, color(0), 20, 0);
    rock(cx, cy, q.z*0.65, 30);

    noStroke();
    stroke(240, 4);
    arc2(cx, cy, q.z*0.9, q.z*0.8, 0, TAU, color(240), 40, 0);
    noFill();
    stroke(240);
    ellipse(cx, cy, q.z*0.9, q.z*0.9);

    noStroke();
    fill(240, 40);
    rect(cx-1, cy-1, 2, 2);


    ArrayList<PVector> ps = new ArrayList<PVector>();
    int cc = int(random(5));
    float ss = q.z*0.1;
    float a, d, nx, ny;
    for (int j = 0; j < cc; j++) {
      a = random(TAU);
      d = q.z*sqrt(random(1))*0.3;
      nx = cx+cos(a)*d;
      ny = cy+sin(a)*d;
      PVector aux = new PVector(nx, ny);
      boolean add = true;
      for (int k = 0; k < ps.size(); k++) {
        PVector other = ps.get(k);
        if (aux.dist(other) < ss*1.2) {
          add = false;
          break;
        }
      }
      if (add) ps.add(aux);
    }

    for (int j = 0; j < ps.size(); j++) {
      PVector p = ps.get(j);
      nx = p.x;
      ny = p.y;
      //float x2 = (nx < cx)? cx-q.z*0.4 : cx+q.z*0.4;
      //float y2 = map(ny, cy-q.z*0.3, cy+q.z*0.3, cy-q.z*0.4, cy+q.z*0.4);
      PVector des1 = (new PVector(nx, ny)).sub(cx, cy).normalize().mult(ss*0.5);
      PVector des2 = (new PVector(nx, ny)).sub(cx, cy).normalize().mult(q.z*0.45);
      float x1 = nx+des1.x;
      float y1 = ny+des1.y;
      float x2 = cx+des2.x;
      float y2 = cy+des2.y;
      noFill();
      stroke(240);
      line(x1, y1, x2, y2);
      ellipse(nx, ny, ss, ss);
      noStroke();
      arc2(nx, ny, ss, ss*2.6, 0, TAU, color(255), 30, 0);
    }
  }

  //basicBack();

  //spiderWeb();


  /*
  noStroke();
   fill(0, 100);
   rect(0, 0, width, height);
   
   backGra(rcol(), random(50), rcol(), 4);
   
   blendMode(ADD);
   float det = random(0.001);
   float des = random(100000);
   for (int i = 0; i < 10000; i++) {
   float x = random(width);
   float y = random(height);
   float a = noise(des+x*det, des+y*det)*TAU*2;
   float d = 8;
   stroke(rcol(), 60);
   line(x, y, x+cos(a)*d, y+sin(a)*d);
   }
   blendMode(BLEND);
   
   det = random(0.005);
   des = random(10000);
   noStroke();
   for (int i = 0; i < 10000; i++) {
   float x = random(width);
   float y = random(height);
   float s = noise(des+x*det, des+y*det)*6;
   fill(rcol());
   randomTri(x, y, s);
   }
   
   for (int i = 0; i < 20; i++) {
   float x = random(width);
   float y = random(height);
   float s = width*random(0.2)*random(1);
   arc2(x, y, s*2, s*1.1, 0, TAU, rcol(), 80, 0);
   }
   */

  //islands();
}

float getAreaTri(PVector p1, PVector p2, PVector p3) {
  float d1 = dist(p1.x, p1.y, p2.x, p2.y);
  float d2 = dist(p2.x, p2.y, p3.x, p3.y);
  float d3 = dist(p3.x, p3.y, p1.x, p1.y);
  return sqrt((d1+d2+d3)*(-d1+d2+d3)*(d1-d2+d3)*(d1+d2-d3))/4;
}

PVector randInTri(PVector p1, PVector p2, PVector p3) {
  float r1 = random(1); 
  float r2 = random(1); 
  float s1 = sqrt(r1); 
  float x = p1.x*(1-s1)+p2.x*(1-r2)*s1+p3.x*r2*s1; 
  float y = p1.y*(1-s1)+p2.y*(1-r2)*s1+p3.y*r2*s1; 
  return new PVector(x, y);
}

//int colors[] = {#EC629E, #E85237, #ED7F26, #C28A17, #114635, #000000};
int colors[] = {#6E4ECE, #333333, #9F9EA8, #DDA852, #E6E6ED};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}