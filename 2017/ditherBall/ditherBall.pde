PFont font;
PShader post;

void setup() {
  size(720, 720, P3D);
  post = loadShader("post.glsl");
  post.set("resolution", float(width), float(height));
  sphereDetail(200);

  font = createFont("Chivo-Black", 160, true);
  println(PFont.list());
  textFont(font);
}

void draw() {

  post.set("time", millis()/1000.);


  background(128+cos(frameCount)*128);
  pushMatrix();
  translate(width/2, height/2, -800);
  float vel = 0.2;
  rotateX(frameCount*0.1*vel);
  rotateY(frameCount*0.07*vel);
  rotateZ(frameCount*0.019*vel);

  //ambientLight(128, 128, 128);
  directionalLight(128, 128, 128, 0, 0, -1);
  directionalLight(60, 60, 60, 0, 0.5, 0.5);
  lightFalloff(1, 0, 0);
  lightSpecular(0, 0, 0);

  noStroke();
  fill(255);
  sphere(500);
  popMatrix();

  textAlign(CENTER, CENTER);
  fill(128+cos(frameCount+PI)*128);
  text("NORMAL", width/2, height*0.1);
  text("IN  -  OUT", width/2, height*0.85);

  filter(post);
}