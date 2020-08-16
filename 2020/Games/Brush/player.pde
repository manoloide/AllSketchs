class Player {

  float maxVelocity = 8;
  PVector velocity;

  boolean floor;
  float gravity;

  PVector position, size, direction, newDirection;
  Player(float x, float y, float z) {
    position = new PVector(x, y, z);
    size = new PVector(40, 120, 40);
    velocity = new PVector();
    direction = new PVector();
    newDirection = new PVector();
    floor = false;
  }

  void update() {

    boolean press = false;
    PVector movement = new PVector();
    if (input.left.pressed) {
      press = true;
      movement.x += 1;
    }
    if (input.right.pressed) {
      press = true;
      movement.x -= 1;
    }
    if (input.up.pressed) {
      press = true;
      movement.z -= 1;
    }
    if (input.down.pressed) {
      press = true;
      movement.z += 1;
    }

    if (input.jump.pressed && floor) gravity = -24;

    movement.normalize();
    if(press) newDirection = movement.copy();
    direction.lerp(newDirection, 0.08);

    if (press) {
      velocity.add(movement.mult(1));
      velocity.limit(maxVelocity);
    } else {
      velocity.mult(0.7);
    }

    PVector prev = position.copy();
    position.add(velocity);
    if (world.collision(position, size)) {
      position = prev;
    }


    prev = position.copy();
    position.add(0, gravity, 0);
    floor = false;
    if (world.collision(position, size)) {
      position = prev; 
      floor = true;
    }
    if (floor) {
      gravity *= 0.2;
    } else {
      gravity += 1.2;
    }

    if (position.y > 600) {
      reset();
    }

    //movement.mult(velocity);
  }

  void show() {
    noFill();
    stroke(255);
    noStroke();
    fill(240);
    pushMatrix();
    translate(position.x, position.y, position.z);
    float ang = HALF_PI-atan2(direction.z, direction.x);
    rotateY(ang);
    box(size.x, size.y, size.z);
    stroke(0, 0, 255);
    line(0, 0, 0, 0, 0, size.z);
    //if (floor) fill(255, 0, 0, 80);
    //box(size*0.5);
    popMatrix();
  }
}
