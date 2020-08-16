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

  randomSeed(seed);
  background(rcol());

  int dc = int(random(10, 33));
  float dd = width*1./dc;
  float ddes = random(10000);
  float ddet = random(0.01);
  float dang = random(TAU);
  float ades = random(10000);
  float adet = random(0.01);
  stroke(0, 6);
  for (int j = 0; j < dc; j++) {
    for (int i = 0; i < dc; i++) {
      float x = i*dd;
      float y = j*dd;
      float ang = dang+noise(ddes+i*ddet, ddes+j*ddet)*TAU;
      float amp = noise(ades+i*adet, ades+j*adet);
      float cx = x+dd*(0.5+cos(ang)*0.4*amp);
      float cy = y+dd*(0.5+sin(ang)*0.4*amp);
      beginShape();
      fill(lerpColor(rcol(), color(0), random(0.3)));
      vertex(x, y);
      vertex(x+dd, y);
      fill(rcol());
      vertex(cx, cy);
      endShape(CLOSE);

      beginShape();
      fill(lerpColor(rcol(), color(0), random(0.3)));
      vertex(x+dd, y);
      vertex(x+dd, y+dd);
      fill(rcol());
      vertex(cx, cy);
      endShape(CLOSE);

      beginShape();
      fill(lerpColor(rcol(), color(0), random(0.3)));
      vertex(x+dd, y+dd);
      vertex(x, y+dd);
      fill(rcol());
      vertex(cx, cy);
      endShape(CLOSE);

      beginShape();
      fill(lerpColor(rcol(), color(0), random(0.3)));
      vertex(x, y+dd);
      vertex(x, y);
      fill(rcol());
      vertex(cx, cy);
      endShape(CLOSE);
    }
  }

  noStroke();
  noiseDetail(1);
  ArrayList<Blob> blobs = new ArrayList<Blob>();
  float des = random(10000);
  float det = random(0.01);
  int c = int(random(500));
  for (int i = 0; i < c; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = width*random(0.2, 0.4)*noise(des+xx*det, des+yy*det);
    blobs.add(new Blob(xx, yy, ss));
  }

  for (int i = 0; i < blobs.size(); i++) {
    int cc =  int(random(6)*random(1));
    Blob b = blobs.get(i);
    for (int j = 0; j < cc; j++) {
      float ang = random(TAU);
      float ddd = random(b.r)*1.2;
      float nx = b.xx+cos(ang)*ddd;
      float ny = b.yy+sin(ang)*ddd;
      float ns = b.ss*random(0.4)*random(1);
      blobs.add(i+1, new Blob(nx, ny, ns));
    }
    i += cc;
  }

  for (int i = 0; i < blobs.size(); i++) {
    Blob b1 = blobs.get(i);
    for (int j = i+1; j < blobs.size(); j++) {
      Blob b2 = blobs.get(j);
      float dis = dist(b1.xx, b1.yy, b2.xx, b2.yy);
      if (dis < min(b1.ss, b2.ss)*2) {
        float ang = atan2(b2.yy-b1.yy, b2.xx-b1.xx);
        float pos = 0;
        while (pos < dis) {
          float npos = pos+random(3);
          if (npos > dis) npos = dis;
          stroke(rcol());
          line(b1.xx+cos(ang)*pos, b1.yy+sin(ang)*pos, b1.xx+cos(ang)*npos, b1.yy+sin(ang)*npos);
          pos = npos;
        }
      }
    }
  }

  noStroke();
  for (int i = 0; i < blobs.size(); i++) {
    blobs.get(i).showShadow();
    blobs.get(i).show();
  }
}

class Blob {
  ArrayList<PVector> form;
  float xx, yy, ss;
  float det, des;
  float da, r;
  int col;
  int res;
  Blob(float xx, float yy, float ss) {
    this.xx = xx;
    this.yy = yy;
    this.ss = ss; 

    r = ss*0.5;

    col = rcol();
    det = random(2);
    des = random(100000);

    res = int(max(8, PI*r));
    da = TAU/res;

    form = new ArrayList<PVector>();
    for (int i = 0; i < res; i++) {
      float ang = da*i;
      float x = cos(ang);
      float y = sin(ang);
      float amp = 1-(noise(des+x*det, des+y*det)*0.4); 
      x += cos(ang)*amp*r;
      y += sin(ang)*amp*r;
      form.add(new PVector(x, y));
    }
  }

  void show() {
    beginShape(); 
    for (int i = 0; i < form.size(); i++) {
      PVector p1 = form.get(i);
      PVector p2 = form.get((i+1)%form.size());
      beginShape(); 
      fill(col, 250);
      vertex(xx+p1.x, yy+p1.y);
      vertex(xx+p2.x, yy+p2.y);
      fill(col, 0);
      vertex(xx, yy);
      endShape(CLOSE);
    }
    endShape(CLOSE);

    int scol = rcol();
    while (col == scol) scol = rcol();
    for (int i = 0; i < form.size(); i++) {
      PVector p1 = form.get(i);
      PVector p2 = form.get((i+1)%form.size());
      beginShape(); 
      fill(scol, 40);
      vertex(xx+p1.x, yy+p1.y);
      vertex(xx+p2.x, yy+p2.y);
      fill(scol, 0);
      vertex(xx+p2.x*0.6, yy+p2.y*0.6);
      vertex(xx+p1.x*0.6, yy+p1.y*0.6);
      endShape(CLOSE);
    }

    fill(scol);
    ellipse(xx, yy, r*0.1, r*0.1);
  }

  void showShadow() {
    for (int i = 0; i < form.size(); i++) {
      PVector p1 = form.get(i);
      PVector p2 = form.get((i+1)%form.size());
      float amp1 = 1.0;
      float amp2 = 2;
      float des = r*0.2;
      beginShape(); 
      fill(0, 20);
      vertex(xx+p2.x*amp1, yy+p2.y*amp1);
      vertex(xx+p1.x*amp1, yy+p1.y*amp1);
      fill(0, 0);
      vertex(xx+p1.x*amp2+des, yy+p1.y*amp2+des);
      vertex(xx+p2.x*amp2+des, yy+p2.y*amp2+des);
      endShape(CLOSE);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

int colors[] = {#17E5DB, #5442AE, #A64AC9, #FD6519, #FDCF00, #FFFFFF};
//int colors[] = {#010187, #0A49FF, #FF854E, #FFCAE3, #FFFFFF};
//int colors[] = {#27007F, #00A6FF, #FF216E, #FFB7E3, #FFFFFF};
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