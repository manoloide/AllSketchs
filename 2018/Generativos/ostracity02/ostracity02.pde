int seed = int(random(999999));
PShader post;
void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  post = loadShader("post.glsl");

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
  background(0);
  
  translate(width*0.5, height*0.5);
  rotateX(random(-0.8, 0.8));
  rotateY(random(-0.8, 0.8));
  rotateZ(random(-0.8, 0.8));

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 100000; i++) {
    float x = random(-width, width);
    float y = random(-height, height);
    float s = width*random(0.03, 0.8);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector ant = points.get(j); 
      if (dist(x, y, ant.x, ant.y) < (s+ant.z)*0.5) {
        add  = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float h = p.z;
    float r = p.z*0.5;
    int sub = max(4, int(PI*r*0.5));
    float da = TAU/sub;
    float des = random(TAU);
    float ic1 = random(colors.length);
    float ic2 = random(colors.length);
    float dc1 = (colors.length*int(random(1, 4)))*1./sub;
    float dc2 = (colors.length*int(random(1, 4)))*1./sub;
    noStroke();
    int div = 22;
    for (int k = 0; k < div; k++) {
      float amp1 = pow(map(k, 0, div, 1, 0), 1);//0.9);
      float amp2 = pow(map(k+1, 0, div, 1, 0), 1);//0.9);
      float h1 = map(k, 0, div, 0, h);
      float h2 = map(k+1, 0, div, 0, h);
      //stroke(255);
      for (int j = 0; j < sub; j++) {
        float ang = j*da;
        float r1 = r*amp1*abs(map(j, 0, sub, -1, 1));
        float r2 = r*amp2*abs(map(j+1, 0, sub, -1, 1));
        fill(rcol());
        //fill(random(255));
        beginShape();
        //fill(getColor(ic1+j*dc1));
        vertex(p.x+cos(ang)*r1, p.y+sin(ang)*r1, h1);
        //fill(getColor(ic1+(j+1)*dc1));
        vertex(p.x+cos(ang+da)*r1, p.y+sin(ang+da)*r1, h1);
        //fill(getColor(ic2+(j+1)*dc2));
        vertex(p.x+cos(ang+da)*r2, p.y+sin(ang+da)*r2, h2);
        //fill(getColor(ic2+j*dc2));
        vertex(p.x+cos(ang)*r2, p.y+sin(ang)*r2, h2);
        endShape(CLOSE);
      }
    }
    //ellipse(p.x, p.y, p.z, p.z);
  }

  filter(post);
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
