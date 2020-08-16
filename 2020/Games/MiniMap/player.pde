class Player {

  float aceleration = 900;
  float maxSpeed = 186;
  float gravity = 800;
  float jump = 400;

  boolean floor;
  float w, h;
  PVector position, velocity;
  Player() {
    w = tileSize*0.6;
    h = tileSize*0.6;
    floor = false;
    position = new PVector(width/2., height/2.);
    velocity = new PVector();
  }

  void update() {

    float ms = maxSpeed;
    if (!floor) ms *= 0.6;

    if (input.left.pressed) {
      velocity.x -= aceleration * global.delta;
      velocity.x = constrain(velocity.x, -ms, ms);
    } else if (input.right.pressed) {
      velocity.x += aceleration * global.delta;
      velocity.x = constrain(velocity.x, -ms, ms);
    } else {
      velocity.x = velocity.x*pow(0.84, 60 * global.delta);
    }

    if (input.jump.pressed && floor) {
      velocity.y = -jump;
      floor = false;
    } 

    if (!floor)
      velocity.y += gravity*global.delta;

    move();
  }

  void show() {

    float y1 = position.y;    
    float y2 = height-stats.water;
    float cy = (y1+y2)*0.5;
    float dist = abs(y1-y2);

    noFill();
    strokeWeight(2);
    beginShape(LINES);
    stroke(255, 120);
    vertex(position.x, y1);
    stroke(#edf731, 0);
    vertex(position.x, y2);
    endShape();

    textAlign(LEFT, CENTER);
    textFont(regular);
    textSize(16);
    fill(255);
    text(str(int(dist))+"px", position.x+5, cy);

    noStroke();
    rectMode(CENTER);
    fill(255);
    rect(position.x, position.y, w, h);
    if (floor) fill(colors[2]);
    else fill(colors[4]);
    rect(position.x, position.y, w*0.4, h*0.4);
  }

  void move() {

    PVector prevPos = position.copy();
    position.add((new PVector(velocity.x, 0)).mult(global.delta));
    if (map.collision(position, w, h)) {
      position = prevPos;
      velocity.x *= 0.5;
    }

    prevPos = position.copy();
    position.add((new PVector(0, velocity.y)).mult(global.delta));
    if (map.collision(position, w, h)) {
      position = prevPos;
      velocity.y = 0;
    } 

    prevPos = position.copy();
    position.add(new PVector(0, +1));
    floor = map.collision(position, w, h);
    position = prevPos;
  }
}
