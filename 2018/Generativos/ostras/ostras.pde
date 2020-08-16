int seed = int(random(999999));
PShader post;
void setup() {
  size(960, 960, P2D);
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

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.8);
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
    float r = p.z*0.5;
    int sub = max(4, int(PI*r*0.5));
    float da = TAU/sub;
    float des = random(TAU);
    float ic1 = random(colors.length);
    float ic2 = random(colors.length);
    float dc1 = random(colors.length)*random(0.4, 1);
    float dc2 = random(colors.length)*random(0.4, 1);
    noStroke();
    for (int j = 0; j < sub; j++) {
      float ang = j*da;
      float rr = r*pow(map(cos(des+ang), -1, 1, 0, 1), 0.3);
      beginShape();
      fill(getColor(ic1+j*dc1));
      vertex(p.x+cos(ang)*rr, p.y+sin(ang)*rr);
      fill(getColor(ic1+(j+1)*dc1));
      vertex(p.x+cos(ang+da)*rr, p.y+sin(ang+da)*rr);
      fill(getColor(ic2+j*dc2));
      vertex(p.x, p.y);
      endShape(CLOSE);
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
