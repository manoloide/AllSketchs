class Ship {
  boolean up, down, left, right;
  float maxVel = 400;
  float vel;
  PVector pos, dir, chunk;
  Ship(float x, float y, float z) {
    pos = new PVector(x, y, z);
    dir = new PVector();
    chunk = new PVector();
  }
  void update() {


    dir.mult(0.9);
    if (up) dir.z = lerp(dir.z, -1, 0.1);
    if (down) dir.z = lerp(dir.z, +1, 0.1);
    if (left) dir.x = lerp(dir.x, -1, 0.1);
    if (right) dir.x = lerp(dir.x, +1, 0.1);
    if (keyPressed) {
      vel = lerp(vel, maxVel, 0.2);
    } else {
      vel = lerp(vel, 0, 0.1);
    }  

    pos.add(dir.copy().mult(vel));

    chunk = (pos.copy()).div(size).add((pos.x < 0)? -0.5 : +0.5, (pos.y < 0)? -0.5 : +0.5, (pos.z < 0)? -0.5 : +0.5);
    chunk.set(int(chunk.x), int(chunk.y), int(chunk.z));
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);

    pushStyle();
    noStroke();
    fill(#92CCBC);
    box(10, 10, 60);

    pushMatrix();
    // contra camera --PROB
    rotateX(+PI*0.1);
    billboard();
    box(10, 10, 60);
    noFill();
    stroke(60);
    strokeWeight(0.5);
    rect(0, 0, 140, 140);

    fill(50);
    textSize(21);
    text(nfp(int(chunk.x), 2)+"  "+nfp(int(chunk.y), 2)+"  "+nfp(int(chunk.z), 2), 0, -100);
    fill(0);
    textSize(9);
    text(nfp(pos.x, 4, 2)+" "+nfp(pos.y, 4, 2)+" "+nfp(pos.z, 4, 2), 0, -80);
    popStyle();
    popMatrix();

    popMatrix();
  }
}
