int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  //strokeWeight(3);
  pixelDensity(2);

  //post = loadShader("post.glsl");

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
  background(0);

  int cc = int(random(6, 40));
  float dc = random(600)*random(1);
  float ic = random(colors.length);
  for (int i = 0; i < cc; i++) {
    float col = pow(map(i, 0, cc-1, 0, 1), 0.7); 
    float hh = pow(map(i, 0, cc-1, 0, 1), 1.2); 

    float amp = random(1./cc, 2./cc);

    float det = random(0.001, 0.008);
    float des = random(10000);


    float det2 = random(0.0001, 0.001);
    float des2 = random(10000);



    float det3 = random(0.0001, 0.001);
    float des3 = random(10000);

    fill(getColor(ic+col*colors.length*dc));
    //noFill();
    stroke(255, 0, 0);
    noStroke();
    float ampw = random(100);
    beginShape();
    for (float j = -ampw; j <= width+ampw; j++) {
      float x = j;
      float y = i+height*hh;
      noiseDetail(2);
      float dx = noise(des2+x*det2, des2+y*det2)*ampw-ampw*0.5;
      noiseDetail(4);
      float dy = noise(des+x*det, des+y*det)*amp*height;
      noiseDetail(1);
      dy *= pow(noise(des3+x*det3, des3+y*det3), 0.2);
      vertex(x+dx, y+dy);
    }
    vertex(width, height);
    vertex(0, height);
    endShape(CLOSE);
  }



  /*
  post = loadShader("post.glsl");
   filter(post);
   */
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