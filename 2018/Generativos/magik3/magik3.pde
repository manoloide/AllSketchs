int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  post = loadShader("post.glsl");

  generate();

  /*
  saveImage();
   exit();
   */
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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  background(rcol());

  /*
  for (int i = 0; i < 10000; i++) {
   float x = random(width);
   float y = random(height);
   float s = width*random(0.04)*random(1)*random(1)*0.2;
   float a = random(TAU);
   float d = s*random(2, random(30));
   beginShape();
   fill(rcol());
   vertex(x-cos(a)*d+cos(a-HALF_PI)*s*0.1, y-sin(a)*d+sin(a-HALF_PI)*s*0.1);
   vertex(x-cos(a)*d+cos(a+HALF_PI)*s*0.1, y-sin(a)*d+sin(a+HALF_PI)*s*0.1);
   fill(rcol());
   vertex(x+cos(a)*d+cos(a+HALF_PI)*s*0.1, y+sin(a)*d+sin(a+HALF_PI)*s*0.1);
   vertex(x+cos(a)*d+cos(a-HALF_PI)*s*0.1, y+sin(a)*d+sin(a-HALF_PI)*s*0.1);
   endShape();
   
   endShape();
   noStroke();
   fill(rcol());
   //ellipse(x, y, s, s);
   //arc2(x, y, s, s*2, 0, TAU, color(255), 20, 0);
   }
   */

  for (int j = 0; j < 4; j++) {


    float x1 = random(width);
    float y1 = random(height);
    float x2 = random(width);
    float y2 = random(height);
    float det1 = random(0.2)*random(1)*random(1);
    float des1 = random(1000);
    float det2 = random(0.2)*random(1)*random(1);
    float des2 = random(1000);

    x1 = lerp(x1, x2, 0.92);
    x2 = lerp(x2, x1, 0.92);
    y1 = lerp(y1, y2, 0.92);
    y2 = lerp(y2, y1, 0.92);

    float amp1 = random(10);
    float amp2 = random(10);

    float ic = random(colors.length);
    float dc = random(0.006)*random(0.1, 1)*random(0.1, 1)*random(0.1, 1);

    noiseDetail(1);

    float vel = 0.071*random(0.5, 2);

    float lar = random(1000, 10000);

    ArrayList<PVector> stars = new ArrayList<PVector>();
    for (int i = 0; i < lar; i++) {
      stroke(lerpColor(getColor(ic+dc*i), color(0), cos(i*PI*0.1)*0.16+0.16));
      line(x1, y1, x2, y2); 

      float ang1 = noise(des1+x1*det1, des1+y1*det1)*TAU*amp1; 
      float ang2 = noise(des2+x2*det2, des2+y2*det2)*TAU*amp2; 

      float ax1 = x1;
      float ay1 = y1;
      float ax2 = x2;
      float ay2 = y2;
      x1 += cos(ang1)*vel;
      y1 += sin(ang1)*vel;
      x2 += cos(ang2)*vel;
      y2 += sin(ang2)*vel;
      noStroke();
      if (i < lar-2) {
        stroke(255, 250);
        line(ax1, ay1, x1, y1);
        stroke(0, 240);
        line(ax2, ay2, x2, y2);
      }
    }

    for (int i = 0; i < stars.size(); i++) {
      PVector s = stars.get(i);
      noStroke();
      float ss = random(1, 42)*random(0.5, 1);
      arc2(s.x, s.y, 0, ss, 0, TAU, color(255), 40, 0);
    }
  }

  post = loadShader("post.glsl");
  filter(post);
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

int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
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
