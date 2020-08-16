class Camera {
  float rotZ, nrotZ;
  boolean goToOrtho;
  float toOrtho;
  Camera() {
    nrotZ = rotZ = 0;    
    toOrtho = 0;
  }

  void update() {

    if (goToOrtho) toOrtho = lerp(toOrtho, 1, 0.3);
    else toOrtho = lerp(toOrtho, 0, 0.2);

    rotZ = lerp(rotZ, nrotZ, 0.6);

    translate(width/2, height/2);
    rotateX(PI*toOrtho*0.33);
    rotateZ(rotZ);
  }

  void rotLeft() {
    nrotZ -= PI/4;
  }

  void rotRight() {
    nrotZ += PI/4;
  }
}
