class Chunk {
  int ix, iy, iz;
  int ax, ay, az;
  PVector pos;
  Chunk(int x, int y, int z) {
    this.ix = x;
    this.iy = y;
    this.iz = z;
  }

  void update() {

    ax = int(ship.chunk.x)+ix;
    ay = int(ship.chunk.y)+iy;
    az = int(ship.chunk.z)+iz;

    pos = new PVector(ax*size, ay*size, az*size);
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);


    fill(250);
    float sizeText = map((abs(ax)+abs(ay)+abs(az))*1, 0, 5, 200, 0);
    if (sizeText > 0) {
      textSize(sizeText);
      text(nfp(ax, 2)+nfp(ay, 2)+nfp(az, 2), 0, 0);
    }

    if (abs(ax) < 2 && abs(ay) < 2 && abs(az) < 2 ) { 
      noFill();
      stroke(255);
      strokeWeight(10);
      box(size);
    } else {
      float ms = size*0.5;
      stroke(0);
      strokeWeight(60);
      point(-ms, -ms, -ms);
      point(+ms, -ms, -ms);
      point(-ms, +ms, -ms);
      point(+ms, +ms, -ms);
      point(-ms, -ms, +ms);
      point(+ms, -ms, +ms);
      point(-ms, +ms, +ms);
      point(+ms, +ms, +ms);
    }
    popMatrix();
  }
}
