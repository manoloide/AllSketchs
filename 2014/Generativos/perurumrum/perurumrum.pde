import joons.*;

JoonsRenderer jr;

int paleta[] = {
  #EFFFCD, 
  #DCE9BE, 
  #555152, 
  #2E2633, 
  #99173C
};

float eyeX = 0;
float eyeY = 50;
float eyeZ = 150;
float centerX = 0;
float centerY = 0;
float centerZ = 0;
float upX = 0;
float upY = 0;
float upZ = -1;
float fov = PI / 4; 
float aspect = (float) 1.3333;  
float zNear = 5;
float zFar = 10000;

void setup() {
  size(600, 600, P3D);
  jr = new JoonsRenderer(this);
  jr.setSampler("bucket");

  jr.setAA(0, 2);
  jr.setCaustics(10);
  //jr.setTraceDepths(10, 10, 10);
 // smooth(32);
}

void draw() {
}

void generar() {
  jr.beginRecord(); 
  
  //perspective(fov, aspect, zNear, zFar);//use perspective() before camera()!!
  //camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  /*
  hint(DISABLE_DEPTH_TEST);
   background(rcol());
   int sep = int(random(2, 16));
   stroke(255, 60);
   strokeWeight(sep*random(0.4, 0.6));
   for (int i = -int (random (sep)); i < width+height; i+=sep*2) {
   line(-sep, i, i, -sep);
   }
   //background(20);
   hint(ENABLE_DEPTH_TEST);
   */
  translate(width/2, height/2, -800);
  jr.background("cornell_box", 2000, 2000, 2000
  ); //Cornell Box: width, height, depth.
  //jr.background(40);
  //jr.background("gi_ambient_occlusion");
  jr.background("gi_instant"); //Global illumination.
  lights();
  noFill();
  strokeWeight(1);
  for (int i = 0; i < 10; i++) {
    pushMatrix();
    translate(random(-width*0.4, width*0.4), random(-height*0.4, height*0.4), random(100));
    //stroke(rcol());
    //fill(rcol());
    color col = color(rcol());
    jr.fill("diffuse", red(col), green(col), blue(col));
    sphereDetail(120);
    float tt = random(10, 200);
    sphere(tt);
    for (int j = 0; j < 30; j++) {
      pushMatrix();
      rotateX(random(TWO_PI));
      rotateY(random(TWO_PI));
      rotateZ(random(TWO_PI));
      //stroke(rcol());
      translate(tt*1.5, 0, 0);
      box(10);
      popMatrix();
    }
    popMatrix();
  }
  jr.endRecord();

  jr.displayRendered(true);
}

void keyPressed() {
  if (key == 'r' || key == 'R') jr.render();
  if (key == 's') saveImage();
  else generar();
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-2;
  saveFrame(nf(n, 3)+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}
