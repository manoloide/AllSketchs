PShader post;

void setup() {
  size(640, 640, P2D);
  smooth(8);
  post = loadShader("shader.glsl");
  PImage tex0 = loadImage("text.jpg");
  post.set("displace", tex0);
  post.set("resolution", float(width), float(height));
  post.set("textureResolution", float(tex0.width), float(tex0.height));
  post.set("chroma", 0.04);
  post.set("grain", 0.0002);
}

int seed = 206557;
boolean export = false;

void draw() {


  float time = millis()/1000.;
  if (export) time = map(frameCount-1, 0, 30, 0, 1);

  float t1 = (time*2.00)%1;
  float t2 = (time*1.00)%1;
  float t3 = (time*0.50)%1;
  float t4 = (time*0.25)%1;

  int ds = int(time/4.0);

  randomSeed(seed+ds*234);

  background(10);
  translate(width/2, height/2);

  //if (t1 > 0.98) return;

  noFill();
  rectMode(CENTER);
  for (int k = 0; k < 4; k++) {
    int cc = int(pow(2, int(random(0, 6))));
    float ss = width/float(cc); 
    int dir = ((random(1) < 0.5)? -1 : 1);
    float dx = Easing.ExpoInOut(pow(abs((t4*2)-1), random(0.4, 2.4)), 0, 1, 1)*dir; 
    float dy = Easing.ExpoInOut(pow(abs((t4*2)-1), random(0.4, 2.4)), 0, 1, 1)*dir; 
    strokeWeight(random(1, 3));
    float sss = ss;
    if (random(1) < 0.6) sss *= random(0.1);
    stroke(255, random(50, 70));
    for (int j = -1; j <= cc+1; j++) {
      for (int i = -1; i <= cc+1; i++) {
        rect((i-cc*0.5+dx-0.5)*ss, (j-cc*0.5+dy-0.5)*ss, sss, sss);
      }
    }
  }

  filter(post);

  if (export) {
    saveFrame("export/pic####.png");
    if (time >= 90) exit();
  }
}  