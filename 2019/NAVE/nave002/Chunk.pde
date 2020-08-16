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

    //pos chunk
    fill(250);
    float sizeText = map((abs(ax)+abs(ay)+abs(az))*1, 0, 5, 40, 0);
    if (sizeText > 0) {
      textSize(sizeText);
      text(nfp(ax, 2)+nfp(ay, 2)+nfp(az, 2), 0, -160);
    }

    //gril size
    if (abs(ax) < 2 && abs(ay) < 2 && abs(az) < 2 ) { 
      noFill();
      stroke(255);
      strokeWeight(10);
      box(size);
    } 


    //points size
    /*
    else {
     float ms = size*0.495;
     stroke(int(cos(time*400)*0.5+0.5)*255);
     strokeWeight(30);
     point(-ms, -ms, -ms);
     point(+ms, -ms, -ms);
     point(-ms, +ms, -ms);
     point(+ms, +ms, -ms);
     point(-ms, -ms, +ms);
     point(+ms, -ms, +ms);
     point(-ms, +ms, +ms);
     point(+ms, +ms, +ms);
     }
     */

    //blocks
    int sub = 12; 
    float ss = (size*1./sub);
    float desSub = sub*0.5-0.5;
    float amps[][][] = new float[sub][sub][sub];
    for (int k = 0; k < sub; k++) {
      for (int j = 0; j < sub; j++) {
        for (int i = 0; i < sub; i++) {
          amps[i][j][k] = world.getAmp(i*ss+pos.x, j*ss+pos.y, k*ss+pos.z);
          //amp = 0.1;
        }
      }
    }

    boolean debugPoints = false;

    if (debugPoints) {
      beginShape(POINTS);
      strokeWeight(ss*0.1);
      stroke(0);
      noFill();
    } else {
      beginShape(QUADS);
      noStroke();
      fill(#F7F718);
      fill(255, 0, 0);
    }
    //beginShape(POINTS);

    float x, y, z, amp, ms;
    for (int k = 0; k < sub; k++) {
      for (int j = 0; j < sub; j++) {
        for (int i = 0; i < sub; i++) {

          x = (i-desSub)*ss;
          y = (j-desSub)*ss;
          z = (k-desSub)*ss;
          amp = amps[i][j][k];
          //amp = 0.1;
          if (amp > 0) {
            ms = ss*amp;

            if (debugPoints) {
              vertex(x, y, z);
            } else {

              vertex(x-ms, y-ms, z-ms);
              vertex(x+ms, y-ms, z-ms);
              vertex(x+ms, y+ms, z-ms);
              vertex(x-ms, y+ms, z-ms);
              vertex(x-ms, y-ms, z+ms);
              vertex(x+ms, y-ms, z+ms);
              vertex(x+ms, y+ms, z+ms);
              vertex(x-ms, y+ms, z+ms);

              ///*
              vertex(x-ms, y-ms, z-ms);
              vertex(x+ms, y-ms, z-ms);
              vertex(x+ms, y-ms, z+ms);
              vertex(x-ms, y-ms, z+ms);
              vertex(x-ms, y+ms, z-ms);
              vertex(x+ms, y+ms, z-ms);
              vertex(x+ms, y+ms, z+ms);
              vertex(x-ms, y+ms, z+ms);

              vertex(x-ms, y-ms, z-ms);
              vertex(x-ms, y+ms, z-ms);
              vertex(x-ms, y+ms, z+ms);
              vertex(x-ms, y-ms, z+ms);
              vertex(x+ms, y-ms, z-ms);
              vertex(x+ms, y+ms, z-ms);
              vertex(x+ms, y+ms, z+ms);
              vertex(x+ms, y-ms, z+ms);
              //*/
            }
          }
        }
      }
    }

    endShape();
    popMatrix();
  }
}
