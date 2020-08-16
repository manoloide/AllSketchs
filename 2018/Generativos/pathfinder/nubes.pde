void nubes() {

  float det = random(0.001, 0.002)*4;
  float des = random(10000);

  float p1 = 0.05;
  float p2 = 0.05;


  noLights();
  //ambientLight(280, 280, 280);
  //directionalLight(50, 50, 50, -0.5, -0.1, -0.9);
  /*
  directionalLight(50, 50, 50, 0, 0.5, -1);
   directionalLight(220*p1, 80*p1, 160*p1, 0, 1, 0);
   directionalLight(220*p2, 180*p2, 140*p2, 0, -1, 0);
   lightFalloff(1, 0, 0);
   //lightSpecular(1, 0, 0); 
   ambientLight(240, 230, 225);
   */

  pushMatrix();
  translate(0, 0, 400);
  //sphereDetail(8);
  Icosahedron ico = new Icosahedron();
  for (int i = 0; i < 180000; i++) {
    pushMatrix();
    float x = random(-width*0.5, width*1.5);
    float y = random(-height*0.5, height*1.5);
    float z = random(-10, 10)-180;
    float bri = -4;
    stroke(230+bri);
    fill(random(220, 240)+bri);
    translate(x, y, z);
    float n = constrain(noise(des+x*det, des+y*det, des+z*det)*2-1.4, 0, 1);
    if (n > 0) {
      //sphere(6*pow(n, 0.3));
      rotateX(random(TAU));
      rotateY(random(TAU));
      rotateZ(random(TAU));
      ico.show(24*pow(n, 0.3)*random(0.5, 1));
    }
    popMatrix();
  }
  popMatrix();
}
