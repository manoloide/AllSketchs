class Camera {
  PVector pos;
  Camera() {
    pos = new PVector();
  }

  void update() {


    float fov = PI/2.4;
    float cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);

    pos.lerp(ship.pos, 0.25);

    rotateX(-PI*0.1);
    translate(-pos.x, pos.y, -pos.z);
  }
}
