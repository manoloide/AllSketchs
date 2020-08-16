int seed = int(random(999999999));

PShader post, splanet;
void setup() {
  size(640, 640, P3D);
  smooth(8);

  post = loadShader("data/post.glsl");
  post.set("resolution", float(width), float(height));
  splanet = loadShader("data/vert.glsl", "data/frag.glsl");
}

void draw() {
  post.set("time", millis()/1000.);
  randomSeed(seed);  

  background(20);
  stroke(16);
  for (int i = 0; i <= 640; i+=20) {
    line(i, 0, i, height);
    line(0, i, width, i);
  }

  translate(width/2, height/2, 0);

  rotateX(frameCount*0.002);
  rotateY(frameCount*0.00073);
  rotateZ(frameCount*0.00007);

  lights();
  noStroke();
  fill(random(256), random(256), random(256));
  //shader(splanet);
  float s = width*random(0.2, 0.3);
  sphere(s);

  for (int i = 0; i < 400; i++) {
    pushMatrix();
    rotateX(random(TWO_PI));
    rotateY(random(TWO_PI));
    rotateZ(random(TWO_PI));
    stroke(0);
    line(0, 0, s+8, 0);
    translate(s+8, 0, 0);
    fill((random(1) < 0.5)? color(255, 0, 0) : color(0, 255, 0));
    //sphere(2);
    box(2);
    popMatrix();
  }

  filter(post);
}

void keyPressed() {
  seed = int(random(999999999));
}

