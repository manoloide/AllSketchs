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

void generate() { 

  des = random(1000);
  det = random(0.004);

  randomSeed(seed);
  background(10);

  int cc = int(max(8, random(220)*random(1)));
  float ss = width*1./cc;

  noStroke(); 

  for (int i = 0; i < 20; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.6);
    arc2(x, y, s, 0, 0, TAU, color(255), 0, random(10));
  }

  float s = ss*random(0.05);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      float xx = ss*i;
      float yy = ss*j;
      fill(255, 2);
      ellipse(xx, yy, ss, ss);
      fill(255, 80);
      ellipse(xx, yy, s, s);
    }
  }

  stroke(255, 10);
  for (int i = 0; i < 10; i++) {
    float xx = random(width+ss);
    float yy = random(height+ss);

    xx -= xx%ss;
    yy -= yy%ss;   

    int rep = int(random(1000));
    for (int j = 0; j < rep; j++) {
      float dx = int(random(-2, 2))*ss; 
      float dy = int(random(-2, 2))*ss; 
      line(xx, yy, xx+dx, yy+dy);
      xx += dx;
      yy += dy;
    }
  }

  for (int i = 0; i < 10; i++) {

    float xx = random(width+ss);
    float yy = random(height+ss);
    float si = int(random(1, cc*0.3))*ss*2;
    xx -= xx%ss;
    yy -= yy%ss;  

    stroke(255, 6);
    fill(255, 3);
    ellipse(xx, yy, si, si);
  }

  float des = random(1000);
  float det = random(0.1);
  for (int i = 0; i < 100; i++) {
    float xx = random(width+ss);
    float yy = random(height+ss);
    float si = int(random(1, cc*0.3))*ss*2;
    xx -= xx%ss;
    yy -= yy%ss;

    int cw = int(random(1, cc*0.25));
    int ch = int(random(1, cc*0.25));

    for (int jj = 0; jj < ch; jj++) {
      for (int ii = 0; ii < cw; ii++) {
        float x = xx+ii*ss;
        float y = yy+jj*ss;
        fill(255, noise(des+x*det, des+y*det)*10);
        ellipse(x, y, s, s);
      }
    }
  }


  int ccc = int(random(cc*0.9));
  for (int i = 0; i < ccc; i++) {
    float xx = random(width+ss);
    float yy = random(height+ss);
    xx -= xx%ss;
    yy -= yy%ss;   
    float w = int(random(1, cc*random(0.3)))*ss;
    float h = int(random(1, cc*random(0.3)))*ss; 
    if (random(1) < 0.8) w = h;
    float dd = w*0.5*int(random(-2, -2));
    if (random(1) < 0.5) w *= -1;


    beginShape();
    fill(255, 0);
    vertex(xx, yy+h);
    vertex(xx, yy);
    fill(255, 100);
    vertex(xx+w, yy+dd);
    vertex(xx+w, yy+h+dd);
    endShape(CLOSE);
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

int colors[] = {#FE603C, #242D3B, #027ECB, #E5B270, #FD9EC8, #FDD3C7};
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