boolean newPlanet = false;
Planet planet, nextPlanet;
PShader displace, textureMix, post;

void setup() {
  size(800, 600, P3D);
  smooth(8);
  displace = loadShader("displaceFrag.glsl", "displaceVert.glsl");
  displace.set("displaceStrength", 0.2);
  textureMix = loadShader("textureMixFrag.glsl", "textureMixVert.glsl");
  post = loadShader("post.glsl");
  post.set("iResolution", float(width), float(height));
  planet = new Planet();
  nextPlanet = new Planet();
  thread("changePlanet");
}


void draw() {
  background(10);
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  pointLight(255, 80, 80, mouseX*2-width/2, mouseY*2-height/2, 500);
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  ambientLight(14, 14, 34);
  //shader.set("normalMap", normals);
  shader(displace);
  pushMatrix();
  translate(width/2, height/2, -300);  
  pushMatrix();
  rotateY(PI * frameCount / 1000);
  planet.update();
  popMatrix();
  popMatrix();

  post.set("iGlobalTime", millis()/1000.0);
  filter(post);
}

void keyPressed() {
  planet.change(nextPlanet);
}

void changePlanet() {
  newPlanet = false;
  planet = nextPlanet;
  nextPlanet = null;
  nextPlanet = new Planet();
  newPlanet = true;
}

