int seed; 
PShader post, depthShader;
PGraphics depth;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  post = loadShader("data/post.glsl");
  post.set("resolution", float(width), float(height));

  depthShader = loadShader("depthFrag.glsl", "depthVert.glsl");
  depthShader.set("near", 200.0); // Standard: 0.0
  depthShader.set("far", 900.0); // Standard: 100.0
  depthShader.set("nearColor", 1.0, 1.0, 1.0, 1.0); // Standard: white
  depthShader.set("farColor", 0.0, 0.0, 0.0, 1.0); // Standard: black

  depth = createGraphics(width, height, P3D);
  depth.shader(depthShader);
}

void draw() {
  if (frameCount%120 == 0) generate();

  pushMatrix();
  depth.beginDraw();
  drawScene(depth, false);
  depth.endDraw();
  drawScene(g, true);

  post.set("mouse", float(mouseX), float(mouseY));
  post.set("time", millis()/1000.);
  post.set("tDepth", depth.get());
  depthShader.set("near", 300.0+cos(frameCount*0.04)*200); // Standard: 0.0
  depthShader.set("far", 900.0+cos(frameCount*0.04)*200); // Standard: 100.0
  filter(post);
  popMatrix();
  /*
  clear();
  image(depth, 0, 0);
  */
  /*
  hint(DISABLE_DEPTH_TEST);
   tint(255, 220);
   image(depth, 0, 0);
   hint(ENABLE_DEPTH_TEST);*/

  if (frameCount%2 == 0 && false) {
    if (frameCount >= 120*12) exit();
    else
      saveFrame("export/#####.png");
  }
}

void drawScene(PGraphics gra, boolean lights) {
  if (lights) {
    gra.lights();
    gra.pointLight(220, 120, 0, 0.5, cos(frameCount*0.02+PI)*500, 1);
    gra.pointLight(0, 120, 220, cos(frameCount*0.02)*500, 1, 1);
  }
  gra.noStroke();
  gra.colorMode(HSB, 256);
  gra.fill(20, 220, 90);
  randomSeed(seed);
  noiseSeed(seed);
  gra.clear();
  gra.translate(width/2, height/3*2, -200);
  float v = 0.05;
  gra.rotateX(cos(frameCount*0.00097*v+random(PI))*0.2+PI*0.2);
  //gra.rotateY(frameCount*0.0013*v);
  gra.rotateZ(random(TWO_PI)+frameCount*0.007*v);


  int cc = 10;
  float tt = 120; 
  float hh = (tt/2)*sqrt(3);
  gra.translate(-cc/2.*tt*1.5, -cc*hh*0.5, 0);
  float det = 0.008;
  float da = TWO_PI/6;
  float r = tt*0.5;
  for (int j = 0; j < cc*2; j++) {
    for (int i = 0; i < cc; i++) {
      gra.fill(random(60, 100), random(160, 180), random(160, 220));
      float x = (i+(j%2)*0.5)*tt*1.5;
      float y = j*hh*0.5;
      float ani = frameCount*0.003;
      float h = noise(x*det+ani, y*det+ani)*720;
      float z = h/2;
      for (int k = 0; k < 6; k++) {
        gra.beginShape();
        gra.vertex(x, y, h);
        gra.vertex(x+cos(da*k)*r, y+sin(da*k)*r, h);
        gra.vertex(x+cos(da*k+da)*r, y+sin(da*k+da)*r, h);
        gra.endShape(CLOSE);/*
   gra.beginShape();
         gra.vertex(x, y, 0);
         gra.vertex(x+cos(da*k)*r, y+sin(da*k)*r, 0);
         gra.vertex(x+cos(da*k+da)*r, y+sin(da*k+da)*r, 0);
         gra.endShape(CLOSE);*/
        gra.beginShape();
        gra.vertex(x+cos(da*k+da)*r, y+sin(da*k+da)*r, h);
        gra.vertex(x+cos(da*k)*r, y+sin(da*k)*r, h);
        gra.vertex(x+cos(da*k)*r, y+sin(da*k)*r, 0);
        gra.vertex(x+cos(da*k+da)*r, y+sin(da*k+da)*r, 0);
        gra.endShape(CLOSE);
      }
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  seed = int(random(99999999));
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
