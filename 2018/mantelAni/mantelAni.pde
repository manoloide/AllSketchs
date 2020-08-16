int seed = int(random(999999));
//132155
PGraphics render;
void setup() {
  size(960, 540, P2D);
  smooth(8);
  pixelDensity(2);
  render = createGraphics(width, height, P2D);
  render.smooth(8);

  seed = 985079;
  generate();
  image(render, 0, 0);
  //saveImage();
  //exit();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    println(seed);
    generate();
    image(render, 0, 0);
  }
}

void generate() {

  randomSeed(seed);
  noiseDetail(1);
  noiseSeed(seed);

  color back = rcol();
  render.beginDraw();
  render.strokeWeight(1);
  render.background(back);

  ArrayList<PVector> points = new ArrayList<PVector>();

  float des = random(1000000);
  float det = random(0.01, 0.016)*960;

  for (int i = 0; i < 3000; i++) {
    render.stroke(rcol(), 250);
    render.fill(rcol(), 240);
    float x = render.width*random(-0.1, 1.1);
    float y = render.height*random(-0.1, 1.1);
    render.beginShape();
    float dis = render.width/9.6;
    for (int j = 0; j < dis; j++) {
      float nx = map(x, 0, render.width, 0, 1)*det;
      float ny = map(y, 0, render.height, 0, 1)*det;
      float ang = noise(des+nx, des+ny)*TWO_PI;
      x += cos(ang);
      y += sin(ang);
      render.vertex(x, y);
    }
    render.endShape(CLOSE);
  }
  println("END BACK");

  /*
  for (int i = 0; i < 80000; i++) {
   float x = render.width*random(1);
   float y = render.width*random(1);
   float dis = dist(x, y, render.width/2, render.height/2);
   dis = dis/(render.width*1.41);
   dis = map(dis, 0, 1, 2, 1);
   float nx = map(x, 0, render.width, 0, 1)*det;
   float ny = map(y, 0, render.height, 0, 1)*det;
   float s = render.width*random(0.1)*random(0.5, 1)*dis;
   s = render.width*noise(des+nx, des+ny)*dis*random(0.05, 0.2);
   
   if (s < 1) continue;
   
   boolean add = true;
   for (int j = 0; j < points.size(); j++) {
   PVector o = points.get(j);
   if (dist(x, y, o.x, o.y) < (s+o.z)*0.6) {
   add = false;
   break;
   }
   }
   
   if (add) points.add(new PVector(x, y, s));
   }
   
   
   render.noStroke();
   for (int i = 0; i < points.size(); i++) {
   PVector p = points.get(i);
   render.fill(lerpColor(back, color(0), random(0.05, 0.15)), 80);
   float r = p.z*0.5;
   int res = max(8, int(PI*r));
   float da = TWO_PI/res;
   render.beginShape();
   for (int j = 0; j < res; j++) {
   float ang = da*j;
   float sa = (ang+PI*1.75)%TWO_PI;
   sa = abs(sa-PI);
   if (sa < HALF_PI) sa = HALF_PI;
   float rr = r*(1.2-pow(abs(sin(sa)), 1.5)*0.2);
   float x = p.x+cos(ang)*rr;
   float y = p.y+sin(ang)*rr;
   render.vertex(x, y);
   }
   render.endShape(CLOSE);
   arc2(p.x, p.y, p.z, p.z*1.5, 0, TAU, 0, 20, 0);
   
   //ellipse(p.x+p.z*0.3, p.y+p.z*0.4, p.z, p.z);
   }
   println("END POINTS");
   
   for (int i = 0; i < points.size(); i++) {
   PVector p = points.get(i);
   color col = rcol();
   render.fill(col);
   render.ellipse(p.x, p.y, p.z, p.z);
   arc2(p.x, p.y, p.z, p.z*0.0, 0, TAU, 0, 5, 0);
   arc2(p.x, p.y, p.z, p.z*0.5, 0, TAU, 0, 20, 0);
   arc2(p.x+p.z*0.125, p.y-p.z*0.125, p.z*0.0, p.z*0.5, 0, TAU, 255, 20, 0);
   
   //noiseCircle(p.x, p.y, p.z, p.z*1.2, 255, 70, 0);
   //noiseCircle(p.x, p.y, p.z, p.z*1.2, 255, 70, 0);
   
   float r = p.z*0.5;
   ArrayList<PVector> pp = new ArrayList<PVector>();
   for (int j = 0; j < 800; j++) {
   float ang = random(TWO_PI);
   float dis = acos(random(PI));
   float x =  cos(ang)*dis*(r*0.6);
   float y =  sin(ang)*dis*(r*0.6);
   float ss = r*random(0.04, 0.1);
   
   boolean add = true;
   for (int k = 0; k < pp.size(); k++) {
   PVector o = pp.get(k);
   if (dist(x, y, o.x, o.y) < (ss+o.z)*0.5) {
   add = false;
   break;
   }
   }
   
   if (add) {
   pp.add(new PVector(x, y, ss));
   
   render.fill(0, 120);
   render.arc(p.x+x, p.y+y, ss, ss*1.6, 0, PI);
   
   render.fill(rcol());
   render.ellipse(p.x+x, p.y+y, ss, ss);
   }
   }
   }
   */


  render.endDraw();
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    render.beginShape();
    render.fill(col, shd1);
    render.vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    render.vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    render.fill(col, shd2);
    render.vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    render.vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    render.endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  render.save(timestamp+".png");
}

int colors[] = {#D81D03, #101A9D, #1C7E4E, #F6A402, #EFD4BF, #E2E0EF, #050400};
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