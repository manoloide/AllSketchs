import peasy.*;

PeasyCam cam;
int seed = int(random(999999));

void setup() {
  size(720, 720, P3D);
  //pixelDensity(displayDensity());
  smooth(8);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);
  //cam.setFreeRotationMode();
  cam.setWheelScale(0.2);
  generate();
}

void draw() {
  background(0);

  randomSeed(seed);

  //if (frameCount%40 == 0) generate();

  blendMode(ADD);
  strokeWeight(1);

  int cc = 300;
  float size = height*8;
  float des = size/cc;
  stroke(255, 160);
  for (int i = 0; i < cc; i++) {
    point(0, 0, i*des-size*0.5);
    point(0, i*des-size*0.5, 0);
    point(i*des-size*0.5, 0, 0);
  }


  float r = 200;
  /*
  stroke(255, 80);
   noFill();
   pushMatrix();
   ellipse(0, 0, r*2, r*2);
   rotateX(HALF_PI);
   ellipse(0, 0, r*2, r*2);
   rotateY(HALF_PI);
   ellipse(0, 0, r*2, r*2);
   popMatrix();
   */

  des = -500;
  stroke(255);

  strokeWeight(2);
  for (int j = 0; j < 200; j++) {
    int res = 300;
    float ia = random(TWO_PI)+frameCount*random(-0.04, 0.04);
    float da = random(-0.2, 0.2)*random(1);
    float dc = 8.0/(r*2);
    //beginShape();
    float h, d, ang, xx, yy;
    for (int i = 1; i < res; i++) {
      h = map(i, 0, res, -r, r);
      d = sqrt(r*r-(h*h));
      ang = ia+da*i;
      xx = cos(ang)*d;
      yy = sin(ang)*d;
      stroke(getColor(dc*i+abs(ang)), 240);
      point(xx, h, yy);
    }
    //endShape();
  }

  PShader post = loadShader("post.glsl");
  post.set("resolution", width*0.5, height*0.5);
  filter(post);
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(999999));
}

int colors[] = {#48272A, #0D8DBA, #6DC6D2, #4F3541, #A43409, #BA622A};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}