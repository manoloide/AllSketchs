PShader post;
PVector camera, cameraTarget;


void setup() {
  size(960, 960, P3D); 
  //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  float fov = PI/2.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/80.0, cameraZ*80.0);
  post = loadShader("data/post.glsl");
  post.set("resolution", float(width), float(height));

  camera = new PVector();
  cameraTarget = new PVector();
}

void draw() {
  post.set("time", millis()/1000.);

  background(8);
  translate(width/2, height/2, .200);
  blendMode(ADD);
  /*
  pushMatrix();
   translate(0, height/3);
   rotateX(PI/2);
   stroke(250);
   drawGrid(width*3, height*3, 40);
   popMatrix();
   */

  PVector cameraVel = cameraTarget.copy();
  cameraVel.sub(camera);
  cameraVel.mult(0.018);
  camera.add(cameraVel); 

  translate(camera.x, camera.y);

  float des = (frameCount%120)/120.;
  float sep = 400;
  float dx1 = width*10;
  float dx2 = width*0.5;
  float dx3 = width;
  int cc = 60;
  float hei = 600;
  for (int i = 0; i < cc; i++) {
    float z = (i-des-1)*-sep;
    noFill();
    stroke(60, 80, 255);
    strokeWeight(2);

    beginShape();
    vertex(-dx1, hei, z);
    vertex(-dx2, hei, z);
    vertex(-dx3, 0, z);
    vertex(-dx2, -hei, z);
    vertex(-dx1, -hei, z);
    endShape();
    beginShape();
    vertex(dx1, hei, z);
    vertex(dx2, hei, z);
    vertex(dx3, 0, z);
    vertex(dx2, -hei, z);
    vertex(dx1, -hei, z);
    endShape();

    /*
    //noStroke();
     fill(60, 80, 255, 100);
     beginShape();
     vertex(-dx2, hei, z);
     vertex(-dx2, hei, z-sep);
     vertex(dx2, hei, z-sep);
     vertex(dx2, hei, z);
     endShape();
     beginShape();
     vertex(-dx2, -hei, z);
     vertex(-dx2, -hei, z-sep);
     vertex(dx2, -hei, z-sep);
     vertex(dx2, -hei, z);
     endShape();
     
     beginShape();
     vertex(-dx3, 0, z);
     vertex(-dx3, 0, z-sep);
     vertex(-dx2, hei, z-sep);
     vertex(-dx2, hei, z);
     endShape();
     beginShape();
     vertex(-dx3, -0, z);
     vertex(-dx3, -0, z-sep);
     vertex(-dx2, -hei, z-sep);
     vertex(-dx2, -hei, z);
     endShape();
     
     beginShape();
     vertex(dx3, 0, z);
     vertex(dx3, 0, z-sep);
     vertex(dx2, hei, z-sep);
     vertex(dx2, hei, z);
     endShape();
     beginShape();
     vertex(dx3, -0, z);
     vertex(dx3, -0, z-sep);
     vertex(dx2, -hei, z-sep);
     vertex(dx2, -hei, z);
     endShape();
     */
  }

  filter(post);
}

void mouseMoved() {
  cameraTarget.x = map(mouseX, 0, width, 400, -400);
  cameraTarget.y = map(mouseY, 0, height, 400, -400);
}

void drawGrid(float w, float h, int cc) {
  float mw = w/2;
  float mh = h/2;
  for (int i = 0; i <= w; i+=cc) {
    line(i-mw, -mh, i-mw, mh);
  } 
  for (int i = 0; i <= h; i+=cc) {
    line(-mw, i-mh, mw, i-mh);
  }
}