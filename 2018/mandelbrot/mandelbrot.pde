PShader mandel, post;

int seed = int(random(9999999));
boolean viewMap = false;

float nx, ny, ns;
float x, y, scale; 
int iterations = 60;
float velocity = 1;

void setup() {
  size(displayWidth, displayHeight, P2D);
  pixelDensity(2);

  noCursor();

  mandel = loadShader("mandel.glsl");
  mandel.set("width", width);
  mandel.set("height", height);

  post = loadShader("mandel.glsl");
  post.set("width", width);
  post.set("height", height);

  ns = 10;
}

void draw() {

  float time = millis()*0.001;

  background(0);
  randomSeed(seed);
  noiseSeed(seed);


  float ps = 0.005*scale*velocity; 
  if (up) ny += ps;
  if (down) ny -= ps;
  if (left) nx -= ps;
  if (right) nx += ps;

  if (in) ns -= ps*3;
  if (out) ns += ps*3;

  x = lerp(x, nx, 0.1);
  y = lerp(y, ny, 0.1);
  scale = lerp(scale, ns, 0.28);

  if (frameCount%20 == 0) {
    mandel = loadShader("mandel.glsl");
    post = loadShader("mandel.glsl");
  }
  mandel.set("width", width);
  mandel.set("height", height);
  mandel.set("seed", seed);
  mandel.set("areaWidth", -1*scale+x, scale+x);
  mandel.set("areaHeight", -1*scale+y, scale+y);
  mandel.set("iterations", iterations);
  mandel.set("time", time*random(1));
  filter(mandel);


  if (viewMap) map();

  //filter(post);
}

void map() {

  float time = millis()*0.01;
  float s = height*random(0.36, 0.4);
  noStroke();
  for (int i = 0; i < 5; i++) {
    float w = random(80);
    float h = random(2);

    float a1 = random(TAU)*s+time*random(-0.2, 0.2);
    float a2 = a1+random(TAU*0.2);

    float ss = s*random(0.9, 1);

    noFill();
    stroke(220, 220);
    strokeWeight(random(w));
    arc(width/2, height/2, ss, ss, a1, a2);
    float dx = (x-nx)*scale*140;
    float dy = (y-ny)*scale*140;

    noStroke();
    fill(255, 80);
    ellipse(width/2+dx, height/2+dy, 5, 5);
  }
}

boolean up, down, left, right;
boolean in, out;

void keyPressed() {

  if (key == 'w' || keyCode == UP) up = true;
  if (key == 's' || keyCode == DOWN) down = true;
  if (key == 'a' || keyCode == LEFT) left = true;
  if (key == 'd' || keyCode == RIGHT) right = true;

  if (key == 'm') viewMap = !viewMap;

  if (key == 'z') in = true;
  if (key == 'x') out = true;

  if (key == 'r') iterations++;
  if (key == 'e') iterations--;

  if (key == '+') velocity *= 1.2;
  if (key == 'ç') velocity *= 1/1.2;

  if (key == ' ') generate();

  if (key == 'c') randomCamera();

  iterations = constrain(iterations, 0, 640);
}

void generate() {
  seed = int(random(9999999));
}

void randomCamera() {

  randomSeed(seed+millis());

  velocity = 5;
  iterations = int(random(64));
  nx = random(-0.6, 0.8);
  ny = random(-0.6, 0.8);
  ns = random(-4, 4)*random(1)*random(1);//random(1);//random(2)*random(-10, 10);
}

void keyReleased() {
  if (key == 'w'|| keyCode == UP) up = false;
  if (key == 's'|| keyCode == DOWN) down = false;
  if (key == 'a'|| keyCode == LEFT) left = false;
  if (key == 'd'|| keyCode == RIGHT) right = false;

  if (key == 'z') in = false;
  if (key == 'x') out = false;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#DDD3C9, #EE9A02, #EB526E, #0169B3, #024E2C};
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
