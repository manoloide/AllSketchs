import peasy.PeasyCam;

PeasyCam cam;

int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(6500, 6500, P3D);
  smooth(2);
  //pixelDensity(2);

  //cam = new PeasyCam(this, 80);

  post = loadShader("post.glsl");
  generate();
  
  saveImage();
  exit();
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    //generate();
  }
}

class Arc {
  float z, r, h, a1, a2;
  Arc(float z, float r, float h, float a1, float a2) {
    this.z = z;
    this.r = r;
    this.h = h;
    this.a1 = a1;
    this.a2 = a2;
  }
}

void generate() { 

  float time = millis()*0.001;

  randomSeed(seed);
  background(0);

  blendMode(ADD);
  //blendMode(DARKEST);


  float fov = PI/random(1.1, 1.8);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);

  translate(width*0.5, height*0.5, 0);

  rotateX(random(TAU)+random(-0.1, 0.1)*time);
  rotateY(random(TAU)+random(-0.1, 0.1)*time);
  rotateZ(random(TAU)+random(-0.1, 0.1)*time);

  //lights();

  float sca = width/960.;

  for (int j = 0; j < 80; j++) {
    float radius = random(2000)*sca;
    int rnd = int(random(6));
    rnd = 5;

    pushMatrix();
    rotateX(random(TAU)+random(-0.1, 0.1)*time);
    rotateY(random(TAU)+random(-0.1, 0.1)*time);
    rotateZ(random(TAU)+random(-0.1, 0.1)*time);

    int col = rcol();

    if (rnd == 0) spherePoints(radius*random(1), int(radius*random(1, 5)));
    if (rnd == 1) {
      noFill();
      stroke(col);
      ellipse(0, 0, radius, radius);
    }
    if (rnd == 2) {
      line(0, 0, 0, radius, 0, 0);
    }
    if (rnd == 3) {
      int seg = int(random(1, 100)*random(0.1, 1));
      float amp = random(0.1, 0.9);
      float da = TAU/seg;
      noFill();
      for (int i = 0; i < seg; i++) {
        arc(0, 0, radius, radius, da*i, da*(i+amp));
      }
    }
    if (rnd == 4) {
      int seg = int(random(1, 20));
      float amp = random(0.1, 0.9);
      float ang = random(TAU);
      float da = ang/seg;
      if (random(1) < 0.0) {
        fill(col);
        noStroke();
      } else {
        stroke(col);
        noFill();
      }
      for (int i = 0; i < seg; i++) {
        arc(0, 0, radius, radius, da*i, da*(i+amp));
      }
    }
    if (rnd == 5) {
      ArrayList<Arc> arcs = new ArrayList<Arc>();
      arcs.add(new Arc(0, radius, random(10, random(random(520)))*sca, 0, TAU));

      int sub = int(random(0, 12));
      for (int i = 0; i < sub; i++) {
        int ind = int(random(arcs.size()));
        Arc a = arcs.get(ind);
        if (random(1) < 0.5) {
          float ma = random(0.2, 0.8);
          float ta = a.a2-a.a1;
          float da = 0;
          if (ta >= TAU)  da = random(TAU);
          arcs.add(new Arc(a.z, a.r, a.h, a.a1+da, a.a1+ta*ma+da));
          arcs.add(new Arc(a.z, a.r, a.h, a.a1+ta*ma+da, a.a2+da));
        } else {
          float mh = random(0.2, 0.8);
          float h1 = a.h*mh;
          float h2 = a.h*(1-mh);
          arcs.add(new Arc(a.z-a.h*0.5+h1*0.5, a.r, h1, a.a1, a.a2));
          arcs.add(new Arc(a.z+a.h*0.5-h2*0.5, a.r, h2, a.a1, a.a2));
        }
        arcs.remove(ind);
      }

      for (int i = 0; i < arcs.size(); i++) {
        Arc a = arcs.get(i);

        stroke(255, 10);
        noFill();
        stroke(rcol());

        int res = int((a.a2-a.a1)*a.r*random(0.2, 0.5));
        float da = (a.a2-a.a1)/res;
        float a1, a2;
        float mh = a.h*0.5;
        int sal = int(random(1, 40));
        int mod = int(random(1, 40));
        for (int k = 0; k < res; k++) {
          if (k%mod < sal) continue;
          a1 = a.a1+da*k;
          a2 = a1+da;
          beginShape();
          vertex(cos(a1)*a.r, sin(a1)*a.r, a.z-mh);
          vertex(cos(a1)*a.r, sin(a1)*a.r, a.z-mh);
          vertex(cos(a2)*a.r, sin(a2)*a.r, a.z+mh);
          vertex(cos(a2)*a.r, sin(a2)*a.r, a.z+mh);
          endShape(CLOSE);
        }
      }
    }
    if (rnd == 6) {
      int seg = int(random(1, 100)*random(0.1, 1));
      float amp = random(0.1, 0.9);
      float ang = random(TAU);
      if (random(1) < 0.5) ang = random(TAU);
      float da = ang/seg;
      float alp1 = 0;//random(TAU);
      float alp2 = 255;//random(TAU);
      if (random(1) < 0.5) {
        alp1 = 255;
        alp2 = 0;
      }
      noFill();
      float r1 = random(radius);
      float r2 = random(radius);
      if (random(1) < 0.5)
        for (int i = 0; i < seg; i++) {
          noStroke();
          beginShape();
          fill(col, alp1);
          vertex(0, 0, 0);
          fill(col, alp2);
          vertex(cos(da*i)*radius, sin(da*i)*radius);
          vertex(cos(da*(i+amp))*radius, sin(da*(i+amp))*radius);
          //arc(0, 0, radius, radius, da*i, da*(i+amp));
          endShape(CLOSE);
        }
    }

    popMatrix();
  }


  post = loadShader("post.glsl");
  filter(post);
}

void spherePoints(float radius, float samples) {
  float offset = 2./samples;
  float increment = PI * (3-sqrt(5.));
  int rnd = 1;
  for (int i = 0; i < samples; i++) {
    float y = ((i*offset)-1.)+(offset/2.);
    float r = sqrt(1.-pow(y, 2));

    float phi = ((i + rnd) % samples) * increment;

    float x = cos(phi) * r;
    float z = sin(phi) * r;

    point(x*radius, y*radius, z*radius);
  }
}

void lineRect(float x1, float y1, float x2, float y2) {
  float cx = (x1+x2)*0.5;
  float cy = (y1+y2)*0.5;

  float dw = abs(x2-x1);
  float dh = abs(y2-y1);
  if (dw > dh) {
    line(x1, y1, cx, y1);
    line(x2, y2, cx, y2);
    line(cx, y1, cx, y2);
  } else {
    line(x1, y1, x1, cy);
    line(x2, cy, x2, y2);
    line(x1, cy, x2, cy);
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

int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#000000};
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