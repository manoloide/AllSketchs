import peasy.PeasyCam;

int seed;
PeasyCam cam;
Camera camera;

public void settings() {
  size(960, 540, P3D);
  pixelDensity(2);
}

void setup() {
  cam = new PeasyCam(this, 400);
  seed = int(random(999999999));
  //camera = new Camera();
}

class Camera {
  PVector rot, nrot;
  float time; 
  Camera() {
    rot = new PVector();
    nrot = new PVector();
    time = random(0);
  }

  void update() {
    time -= 1./60;
    if (time < 0) {
      newPos();
      time = random(4, 10);
    }


    rot.lerp(nrot, 0.004);

    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
  }

  void newPos() {
    randomSeed(seed+frameCount);
    nrot.x = random(-HALF_PI, HALF_PI);
    nrot.y = random(-HALF_PI, HALF_PI);
    nrot.z = random(-HALF_PI, HALF_PI);
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

void draw() {

  float time = millis()*0.001;

  //translate(width*0.5, height*0.5);
  //camera.update();

  randomSeed(seed);
  noiseSeed(seed);
  noiseDetail(1);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(-width/2, -width/2, width, width));

  int div = int(random(100, 2000));
  for (int i = 0; i < div; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    float val = noise(i, time*random(-0.5, 0.5)*random(1));
    boolean hor = random(1) < 0.5;
    if (hor) {
      float nw = r.w*val;
      rects.add(new Rect(r.x, r.y, nw, r.h));
      rects.add(new Rect(r.x+nw, r.y, r.w-nw, r.h));
    } else {
      float nh = r.h*val;
      rects.add(new Rect(r.x, r.y, r.w, nh));
      rects.add(new Rect(r.x, r.y+nh, r.w, r.h-nh));
    }
    rects.remove(ind);
  }

  //lights();


  background(colors[0]);
  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float d = min(r.w, r.h)*0.1;
    int c1 = getColor(noise(time*random(1)*random(0.4, 1))*colors.length*3);
    int c2 = getColor(noise(time*random(1)*random(0.4, 1))*colors.length*3);
    pushMatrix();
    //translate(r.x+r.w*0.5, r.y+r.h*0.5, d*0.5);
    translate(r.x+r.w*0.5, r.y+r.h*0.5);

    fill(c1);
    float sca = pow(noise(time*random(1)), 0.2);
    //sca = 1;
    box(r.w*sca, r.h*sca, d*sca);

    /*
    boolean hor = (random(1) < 0.5);
     beginShape();
     fill(c1);
     vertex(-r.w*0.5, -r.h*0.5);
     if (hor) fill(c2);
     vertex(+r.w*0.5, -r.h*0.5);
     fill(c2);
     vertex(+r.w*0.5, +r.h*0.5);
     if (hor) fill(c1);
     vertex(-r.w*0.5, +r.h*0.5);
     endShape();
     */

    popMatrix();
  }
}

void keyPressed() {
  seed = int(random(999999999));
}

//int colors[] = {#EFECF0, #F0D430, #31AEE6, #F78F85, #000000};
int colors[] = {#F0EFED, #FBC1D2, #ED397A, #44C7BF, #E7E737};
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