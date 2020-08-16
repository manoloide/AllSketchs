
import peasy.PeasyCam;

PShader post;

int seed = int(random(999999999));
PeasyCam cam;

void settings() {
  size(960, 540, P3D);
  //size(1920, 1080, P3D);
  smooth(4);

  //post = loadShader("post.glsl");
  pixelDensity(2);
}

void setup() {
  cam = new PeasyCam(this, 400);
  post = loadShader("post.glsl");
}

void draw() {

  float time = millis()*0.001;


  randomSeed(seed);
  noiseSeed(seed);

  background(0);
  lights();


  float fov = PI/2.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*10.0);


  for(int i = 0; i < 10; i++){
    pushMatrix();
    translate(width*random(-0.5, 0.5), height*random(-0.5, 0.5));
    flower(time*random(0.1, 1));
    popMatrix();
  }

  post = loadShader("post.glsl");
  filter(post);
}

void flower(float time) {
  int cc = int(random(3, 60));
  float da = TAU/cc;
  float dd = width*0.1;
  float ss = 100;
  float s1 = (TAU*ss*0.5)/cc;
  float vs = random(1);
  float ds = TAU*int(random(0, 10))/cc;
  float rotMax = random(2)*random(1);
  for (int i = 0; i < cc; i++) {
    float ang = da*i;
    pushMatrix();
    translate(cos(ang)*dd, sin(ang)*dd);
    rotate(ang);
    //rotateX(time*random(0.1));
    //box(s1);
    sphereDetail(8);
    float s = ss*(0.6+cos(time*vs+i*ds)*0.1);
    pushMatrix();
    noStroke();
    for (int j = 0; j < 8; j++) {
      float aa = 0;//random(TAU);
      rotate(aa+cos(time+j*0.2)*rotMax);
      rotateY(time);
      translate(cos(aa)*s*0.5, sin(aa)*s);
      //rotate(aa);
      fill(255);
      box(s, s*0.04, s*0.04);
      translate(cos(aa)*s*0.5, sin(aa)*s, 0.5);
      fill(rcol());
      sphere(s*0.2);
      s *= 0.9;
    }
    popMatrix();
    popMatrix();
  }
}

void keyPressed() {
  seed = int(random(999999999));
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
