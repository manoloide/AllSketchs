class Camera {
  PVector position;
  float dir;

  Camera() {
    position = new PVector();
  }

  void update() {
    
    float newDir = (player.direction.z <= 0)? -100 : 200;
    dir = lerp(dir, newDir, 0.05);

    position = position.lerp(player.position.copy().add(0, 0, dir), 0.06);

    translate(width*0.5, height*0.5);
    rotateX(-HALF_PI*0.4);
    translate(-position.x, -position.y, -position.z);
    //
    //
  }
}
