int seed = int(random(999999));
PShader post;

void setup() {
  size(960, 520, P2D);
  smooth(2);
  pixelDensity(2);

  post = loadShader("post.glsl");
}

void draw() {
  generate();

  if (frameCount%20 == 0) post = loadShader("post.glsl"); 
  filter(post);
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    //generate();
  }
}

void generate() {

  float time = millis()*0.001;

  randomSeed(seed);
  background(10);

  int cc = int(random(100)*random(1));
  float ss = width*1./cc;
  float amp = random(random(0.8, 1), 1);
  rectMode(CENTER);
  noStroke();
  float ds = random(10000);
  float ts = random(0.01)*random(1);
  float da = random(10000);
  float ta = random(0.01)*random(1);
  float dw = random(10000);
  float tw = random(0.01)*random(1);
  float dh = random(10000);
  float th = random(0.01)*random(1);
  float angTime = time*random(1)*random(1);
  noiseDetail(2);
  rectMode(CENTER);
  for (int j = 0; j < cc+1; j++) {
    for (int i = 0; i < cc+1; i++) {
      float xx = (i+0.5)*ss;
      float yy = (j+0.5)*ss;
      float ww = ss*pow((0.1+noise(dw+xx*tw, dw+yy*tw)), 0.5)*4;
      float hh = ss*pow((0.1+noise(dh+xx*th, dh+yy*th)), 0.5)*4;
      float ang = noise(da+xx*ta, da+yy*ta, angTime)*TAU*4;
      float n = 1-pow(noise(ds+xx*ts, ds+yy*ts, time*random(1)), 2);
      pushMatrix();
      stroke(0);
      translate(xx, yy);
      rotate(ang);
      fill(lerpColor(rcol(), color(255), 0.2));
      rect(0, 0, ww*amp*n, hh*amp*n);

      popMatrix();
    }
  }

  for (int i = 0; i < cc*3; i++) {
    float xx = random(width+ss);
    float yy = random(width+ss); 

    xx -= xx%ss;
    yy -= yy%ss;

    fill(rcol());
    float s3 = ss*(1+cos(time*random(0.1)));
    noStroke();
    arc2(xx, yy, ss, s3, 0, TAU, rcol(), cos(time*random(0.1))*128+128, 0);
    stroke(0);
    ellipse(xx, yy, ss, ss);
    float s2 = ss*noise(random(10)*time);
    fill(rcol());
    ellipse(xx, yy, s2, s2);
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

int colors[] = {#DFC4E4, #EE6054, #2470CB, #E9C639, #ECF5CD, #229E8E, #13283C};
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