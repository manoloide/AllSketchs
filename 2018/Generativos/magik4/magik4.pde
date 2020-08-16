import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));
float det, des;
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
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.02, 0.12);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      float dis = dist(x, y, o.x, o.y);
      if (dis < (s+o.z)*0.5) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }

  for (int j = 0; j < points.size(); j++) {

    PVector p = points.get(j);
    float amp = random(0.01);
    float x1 = p.x+random(-p.z, p.z)*amp;//random(width);
    float y1 = p.y+random(-p.z, p.z)*amp;//random(height);
    float x2 = p.x+random(-p.z, p.z)*amp;//random(width);
    float y2 = p.y+random(-p.z, p.z)*amp;//random(height);
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

    for (int i = 0; i < lar; i++) {
      stroke(lerpColor(getColor(ic+dc*i), color(0), cos(i*PI*0.1)*0.16+0.16));
      line(x1, y1, x2, y2); 

      float ang1 = (float) SimplexNoise.noise(des1+x1*det1, des1+y1*det1)*TAU*amp1; 
      float ang2 = (float) SimplexNoise.noise(des2+x2*det2, des2+y2*det2)*TAU*amp2; 

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
        stroke(0, 40);
        line(ax2, ay2, x2, y2);
      }
    }
  }

  post = loadShader("post.glsl");
  filter(post);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
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
