PImage tex0, tex1;
PShader post;

int seed = int(random(99999));

void setup() {
  size(640, 640, P3D);
  smooth(8);
  post = loadShader("shader.glsl");
  tex0 = loadImage("http://3.bp.blogspot.com/-ceKkFTLhRro/UQV3ZymLa6I/AAAAAAAAAKw/dwwe-ho-DhQ/s1600/grass+bump.jpg");
  //tex0 = loadImage("text.jpg");
  tex1 = createImage(width, height, RGB);

  PGraphics gra = createGraphics(width*2, height*2);
  gra.beginDraw();
  gra.background(10);
  gra.strokeWeight(2);
  gra.stroke(240);
  for (int i = 0; i < gra.width+gra.height; i+=10) {
    gra.line(-2, i, i, -2);
  }
  gra.endDraw();
  tex1 = gra.get();

  post.set("displace", tex0);
  post.set("resolution", float(width), float(height));
  post.set("textureResolution", float(tex0.width), float(tex0.height));
  post.set("chroma", 0.5);
  post.set("grain", 0.5);
}

void draw() {
  background(0);
  lights();
  translate(width/2, height/2, -300);
  float v = random(0.2);
  rotateX(frameCount*random(0.01)*v);
  rotateY(frameCount*random(0.01)*v);
  rotateZ(frameCount*random(0.01)*v);
  randomSeed(seed);
  float amp = 600;
  for (int i = 0; i < 2500*random (0.1, 1); i++) {
    pushMatrix();
    translate(random(-amp, amp), random(-amp, amp), random(-amp, amp));
    rotateX(random(TWO_PI));
    rotateY(random(TWO_PI));
    rotateZ(random(TWO_PI));
    noStroke();
    //box(random(20, 500)*random(1)*random(1));
    TexturedCube(((random(1) < 0.5)? tex0 : tex1), random(20, 500)*random(1)*random(1)*random(1));
    popMatrix();
  }

  post.set("chroma", random(1));
  post.set("grain", (0.1+cos(frameCount*random(0.04))*0.1)*random(0.01)) ;

  filter(post);
}

void keyPressed() {
  if (key == 's') saveImage();
  else seed = int(random(99999));
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void TexturedCube(PImage tex, float sca) {
  beginShape(QUADS);
  texture(tex);

  // Given one texture and six faces, we can easily set up the uv coordinates
  // such that four of the faces tile "perfectly" along either u or v, but the other
  // two faces cannot be so aligned.  This code tiles "along" u, "around" the X/Z faces
  // and fudges the Y faces - the Y faces are arbitrarily aligned such that a
  // rotation along the X axis will put the "top" of either texture at the "top"
  // of the screen, but is not otherwised aligned with the X/Z faces. (This
  // just affects what type of symmetry is required if you need seamless
  // tiling all the way around the cube)

  // +Z "front" face
  vertex(-1*sca, -1*sca, 1*sca, 0, 0);
  vertex( 1*sca, -1*sca, 1*sca, 1*sca, 0);
  vertex( 1*sca, 1*sca, 1*sca, 1*sca, 1*sca);
  vertex(-1*sca, 1*sca, 1*sca, 0, 1*sca);

  // -Z "back" face
  vertex( 1*sca, -1*sca, -1*sca, 0, 0);
  vertex(-1*sca, -1*sca, -1*sca, 1*sca, 0);
  vertex(-1*sca, 1*sca, -1*sca, 1*sca, 1*sca);
  vertex( 1*sca, 1*sca, -1*sca, 0, 1*sca);

  // +Y "bottom" face
  vertex(-1*sca, 1*sca, 1*sca, 0, 0);
  vertex( 1*sca, 1*sca, 1*sca, 1*sca, 0);
  vertex( 1*sca, 1*sca, -1*sca, 1*sca, 1*sca);
  vertex(-1*sca, 1*sca, -1*sca, 0, 1*sca);

  // -Y "top" face
  vertex(-1*sca, -1*sca, -1*sca, 0, 0);
  vertex( 1*sca, -1*sca, -1*sca, 1*sca, 0);
  vertex( 1*sca, -1*sca, 1*sca, 1*sca, 1*sca);
  vertex(-1*sca, -1*sca, 1*sca, 0, 1*sca);

  // +X "right" face
  vertex( 1*sca, -1*sca, 1*sca, 0, 0);
  vertex( 1*sca, -1*sca, -1*sca, 1*sca, 0);
  vertex( 1*sca, 1*sca, -1*sca, 1*sca, 1*sca);
  vertex( 1*sca, 1*sca, 1*sca, 0, 1*sca);

  // -X "left" face
  vertex(-1*sca, -1*sca, -1*sca, 0, 0);
  vertex(-1*sca, -1*sca, 1*sca, 1*sca, 0);
  vertex(-1*sca, 1*sca, 1*sca, 1*sca, 1*sca);
  vertex(-1*sca, 1*sca, -1*sca, 0, 1*sca);

  endShape();
}