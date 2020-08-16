import toxi.math.noise.SimplexNoise;

int seed = 999;//int(random(999999));
float time;

boolean exportVideo = false;
float totalTime = 16;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  //pixelDensity(2);

  frameRate(30);


  rectMode(CENTER);
  strokeWeight(0.6);


  generate();
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

void draw() {

  if (exportVideo) {
    time = (frameCount*1./30);
  } else {
    time = millis()*0.001;
  }
  
  time = time%totalTime;

  randomSeed(seed);
  noiseSeed(seed);
  noiseDetail(4);

  background(#EFF1F4);
  ambientLight(120, 120, 120);
  directionalLight(10, 20, 30, 0, -0.5, -1);
  lightFalloff(0, 1, 0);
  directionalLight(180, 160, 160, -0.8, +0.5, -1);
  //lightFalloff(1, 0, 0);
  //lightSpecular(0, 0, 0);

  ortho();
  translate(width*0.5, height*0.5);
  rotateX(PI*0.25);
  rotateZ(PI*0.25);

  float ww = width*0.75;
  float hh = width*0.75;

  for (int j = -1; j < 2; j++) {
    for (int i = -1; i < 2; i++) {
      stroke(0, 40);
      bb(i*ww, j*hh, -200, ww*0.99, hh*.99, 4);
    }
  }

  if (exportVideo) {
    int frame = frameCount;//int(frameCount/2);
    String fileName = "export/f"+nf(frame, 4)+".png";
    saveFrame(fileName);

    float second = frame*(1./30);
    if (second > totalTime) {
      exit();
    }
  }
}

float curve(float val, float pwr) {
  float nv = val;
  if (val < 0.5) {
    nv = pow(map(val, 0.0, 0.5, 0, 1), pwr);
  } else {
    nv = pow(map(val, 0.5, 1.0, 1, 0), pwr);
  }
  return nv;
}

void bb(float x, float y, float z, float w, float h, int ite) {
  if (ite < 0) return;

  ArrayList<Rect> rects = new  ArrayList<Rect>();
  rects.add(new Rect(x, y, w, h));

  float des = random(10000);
  float det = random(0.001);

  float vel = 0.01;

  int div = int(random(10, 18)*0.1);

  for (int i = 0; i < div; i++) {

    int ind = int(random(rects.size()*random(1)*random(1)));
    Rect r = rects.get(ind);
    
    float tt = (time+random(totalTime))%totalTime;

    float pwr = 2.6;
    float m1wA = curve(constrain((float) SimplexNoise.noise(100+des+r.x*det, des+r.y*det, -23.6+i+tt*vel), 0.02, 0.98), pwr);
    float m1hA = curve(constrain((float) SimplexNoise.noise(des+r.x*det, 100+des+r.y*det, +57.6+i+tt*vel), 0.02, 0.98), pwr);

    float m1wB = curve(constrain((float) SimplexNoise.noise(100+des+r.x*det, des+r.y*det, -23.6+i), 0.02, 0.98), pwr);
    float m1hB = curve(constrain((float) SimplexNoise.noise(des+r.x*det, 100+des+r.y*det, +57.6+i), 0.02, 0.98), pwr);

    float mix = pow(constrain((tt*1./totalTime)*9-8, 0, 1), 2);
    float m1w = lerp(m1wA, m1wB, mix);
    float m1h = lerp(m1hA, m1hB, mix);
    
    

    float m2w = 1-m1w;
    float m2h = 1-m1h;

    m1w = m1w*0.4+0.3;
    m1h = m1h*0.4+0.3;
    m2w = m2w*0.4+0.3;
    m2h = m2h*0.4+0.3;

    m1w *= r.w;
    m2w *= r.w;
    m1h *= r.h;
    m2h *= r.h;

    rects.add(new Rect(r.x-r.w*0.5+m1w*0.5, r.y-r.h*0.5+m1h*0.5, m1w, m1h));
    rects.add(new Rect(r.x+r.w*0.5-m2w*0.5, r.y-r.h*0.5+m1h*0.5, m2w, m1h));
    rects.add(new Rect(r.x+r.w*0.5-m2w*0.5, r.y+r.h*0.5-m2h*0.5, m2w, m2h));
    rects.add(new Rect(r.x-r.w*0.5+m1w*0.5, r.y+r.h*0.5-m2h*0.5, m1w, m2h));
    rects.remove(ind);
  }


  noFill();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(getColor(random(20.2))); //time*random(0.02, 0.03)
    //rect(r.x, r.y, r.w, r.h);

    float ss = min(r.w, r.h)*0.2;

    //if (random(1) < 0.5) continue;

    float mw = r.w*0.49;
    float mh = r.h*0.49;

    float cc = int(random(1, 6));
    float dd = ss*cc*0.1;
    if (random(1) < 0.0 && ite == 0) {
      beginShape(QUADS);
      for (int j = 1; j <= cc; j++) {
        vertex(r.x-mw, r.y-mh, z+dd*j);
        vertex(r.x+mw, r.y-mh, z+dd*j);
        vertex(r.x+mw, r.y+mh, z+dd*j);
        vertex(r.x-mw, r.y+mh, z+dd*j);
      }    
      endShape(CLOSE);
    } else {
      float d = dd*cc;
      pushMatrix();
      translate(r.x, r.y, z+d*0.5);
      fbox(r.w, r.h, d);
      popMatrix();
    }
    bb(r.x, r.y, z+dd*cc, r.w, r.h, ite-1);
  }
}

void fbox(float w, float h, float d) {
  float mw = w*0.5;
  float mh = h*0.5;
  float md = d*0.5;


  beginShape(QUAD);
  vertex(-mw, +mh, -md);
  vertex(-mw, +mh, +md);
  vertex(+mw, +mh, +md);
  vertex(+mw, +mh, -md);
  
  vertex(+mw, -mh, -md);
  vertex(+mw, -mh, +md);
  vertex(+mw, +mh, +md);
  vertex(+mw, +mh, -md);
  
  vertex(-mw, -mh, +md);
  vertex(+mw, -mh, +md);
  vertex(+mw, +mh, +md);
  vertex(-mw, +mh, +md);
  endShape();
}

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(99999));
}

int colors[] = {#81C7EF, #2DC3BA, #BCEBD2, #F9F77A, #F8BDD3, #272928};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
