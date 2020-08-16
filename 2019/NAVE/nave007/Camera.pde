class Camera {
  PVector pos;
  Camera() {
    pos = new PVector();
  }

  void update() {

    float fov = PI/2.4;
    float cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*20.0);

    pos.lerp(ship.pos, 0.8);

    rotateX(-PI*0.1);
    translate(-pos.x, -pos.y+20, -pos.z);
  }
}

void billboard() {
  float[] rota = cam.getRotations();
  rotateX(rota[0]);
  rotateY(rota[1]);
  rotateZ(rota[2]);
}
