import org.processing.wiki.triangulate.*;

int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(rcol());
  randomSeed(seed);

  noStroke();
  beginShape();
  fill(rcol());
  vertex(width, 0);
  vertex(0, 0);
  fill(rcol());
  vertex(0, height/2);
  vertex(width, height/2);
  endShape(CLOSE);

  float des = random(1000);
  float det = random(0.01);
  float desCol = random(1000);
  float detCol = random(0.0003, 0.001);

  beginShape();
  fill(rcol());
  vertex(0, height/2);
  vertex(width, height/2);
  fill(rcol());
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  for (int i = 0; i < 300000; i++) {
    float x = random(width);
    float y = height/2+random(height/2)*random(1);
    float amp = map(y, height/2, height, 0.1, 1);
    float s = map(noise(des+x*det, des+y*det), 0, 1, 1*amp, 8*amp);
    fill(0, 6);
    ellipse(x+s*0.2, y+s*0.2, s*2, s);
    fill(getColor(noise(desCol+x*detCol, desCol+y*detCol/(amp*2))*20), 80);
    ellipse(x, y, s*2, s);
  }

  int cc = 40;
  float ss = width/cc;
  detCol = random(0.004, 0.012);
  float amp = random(0.2, 0.4)*0.4;
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      float xx = i*ss;
      float yy = j*ss;
      noStroke();
      fill(0, 40);
      ellipse(xx+1, yy+1, ss*amp+0.4, ss*amp+0-4);
      fill(getColor(noise(desCol+xx*detCol, desCol+yy*detCol)*30));
      ellipse(xx, yy, ss*amp, ss*amp);
      if (random(1) < 0.15) {
        noFill();
        stroke(255, 20);
        ellipse(xx, yy, ss*2, ss*2);
      }
      if (random(1) < 0.15) {
        noFill();
        stroke(255, 40);
        ellipse(xx, yy, ss, ss);
      }
    }
  }

  float detAng = random(0.002, 0.006);
  float desAng = random(10000);

  float detAmp = random(0.0004, 0.0008)*3;
  float desAmp = random(100000);

  cc *= 5;
  ss = width*1./cc;
  detCol = random(0.004, 0.012)*10;
  noFill();
  float desZ = random(0.01);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      float xx = i*ss;
      float yy = j*ss;

      beginShape();
      vertex(xx, yy);

      float ampCC = pow(noise(desAmp+xx*detAmp, desAmp+yy*detAmp), 0.8)*2-1;
      int ccc = int(80*ampCC);
      for (int k = 0; k < ccc; k++) {
        float ang = noise(desAng+xx*detAng, desAng+yy*detAng, k*desZ)*TAU*2;
        xx += cos(ang);
        yy += sin(ang);
        float alp = pow(map(k, 0, ccc, 1, 0), 0.5)*120;
        stroke(getColor(noise(desCol+xx*detCol, desCol+yy*detCol, k*desZ)*8), alp);
        vertex(xx, yy);
      }
      endShape();
    }
  }

  cc /= 5;
  ss = width*1./cc;

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < cc; i++) {
    float xx = int(random(cc+1))*ss;
    float yy = int(random(cc+1))*ss; 
    float s = ss*int(random(1, 6));
    points.add(new PVector(xx, yy, s));
  }


  ArrayList triangles = Triangulate.triangulate(points);
  stroke(0, 20);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(255, random(40));
    vertex(t.p1.x, t.p1.y);
    fill(255, random(40));
    vertex(t.p2.x, t.p2.y);
    fill(255, random(40));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();


  for (int i = 0; i < cc; i++) {
    PVector p = points.get(i);
    float xx = p.x;
    float yy = p.y;
    float s = p.z;
    int col = rcol();

    fill(col, 10);
    noStroke();
    //strokeWeight(s*0.08);
    ellipse(xx, yy, s, s);

    arc2(xx, yy, s, s*0.92, 0, TAU, col, 255, 255);

    noStroke();
    fill(0);
    arc2(xx, yy, s*0.0, s*0.2, 0, TAU, color(0), 255, 255);
    //ellipse(xx, yy, s*0.2, s*0.2);
    fill(col);
    //ellipse(xx, yy, s*0.15, s*0.15);
    arc2(xx, yy, s*0.0, s*0.15, 0, TAU, col, 255, 255);
    fill(255);
    //ellipse(xx, yy, s*0.025, s*0.025);
    arc2(xx, yy, s*0.0, s*0.025, 0, TAU, color(255), 255, 255);
  }
  strokeWeight(1);
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(8, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
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
