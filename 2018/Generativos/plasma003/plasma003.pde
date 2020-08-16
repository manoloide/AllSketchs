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
  noiseSeed(seed);

  background(0);
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.1, 0.25);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(x, y, p.x, p.y) < (s+p.z)*0.5) {
        add = false; 
        break;
      }
    }
    if (add) {
      points.add(new PVector(x, y, s));
    }
  }

  blendMode(ADD);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    int col = rcol();
    fill(col);
    //ellipse(p.x, p.y, p.z, p.z);
    float alp = random(100);
    float valp = random(0.2);
    boolean randCol = true;//random(1) < 0.1;
    float det = random(0.01);
    float des = random(1000);
    for (int k = 0; k < 500; k++) {
      float a1 = random(TAU);
      float a2 = random(TAU);
      float va1 = random(-0.05, 0.05);
      float va2 = random(-0.05, 0.05);
      for (int j = 0; j < 100; j++) {
        alp += valp;
        a1 += va1;
        a2 += va2;
        PVector d = new PVector(cos(a1)*cos(a2)*p.z, sin(a1)*cos(a2), sin(a2));
        if (randCol) col = getColor(noise(des+d.x*det, des+d.y*det, des+d.z*det*0.01)*colors.length*2);
        stroke(col, (cos(alp)*0.5+0.5)*110);
        point(p.x+d.z*p.z, p.y+d.y*p.z, p.x+d.z*p.z);
      }
    }

    stroke(col, 180);
    for (int k = 0; k < 1000; k++) {
      float a = random(TAU);
      point(p.x+cos(a)*p.z, p.y+sin(a)*p.z);
    }

    col = rcol();
    stroke(col, 60);
    float a1 = random(TAU);
    float a2 = random(TAU);
    float va1 = random(-0.05, 0.05);
    float va2 = random(-0.05, 0.05);
    for (int k = 0; k < 10000; k++) {
      a1 += va1;
      a2 += va2;
      point(p.x+cos(a1)*cos(a2)*p.z, p.y+sin(a1)*cos(a2)*p.z, p.x+sin(a2)*p.z);
    }

    va2 = 0;
    va1 = random(100);
    for (int k = 0; k < 1000; k++) {
      a1 += va1;
      a2 += va2;
      point(p.x+cos(a1)*cos(a2)*p.z, p.y+sin(a1)*cos(a2)*p.z, p.x+sin(a2)*p.z);
    }


    float amp = random(1);
    pushMatrix();
    translate(p.x, p.y);
    rotate(random(TAU));
    int cc = int(random(3, 55));
    float da = TAU/cc;
    for (int k = 0; k < 4000; k++) {
      a1 += va1;
      float  a = a1-(a1%da)*0.05;
      point(cos(a)*p.z*1.05, sin(a)*p.z*1.05*amp);
    }
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
