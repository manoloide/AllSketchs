class Blob {
  boolean remove;
  float x, y, s, r;
  int seg, col;
  PVector vertex[];
  float desNoise, velRot, velOsc;

  Blob(float x, float y, float s) {

    this.x = x;
    this.y = y;
    this.s = s;

    col = rcol();

    desNoise = random(2000);
    velRot = random(-1, 1);
    velOsc = random(-1, 1);

    r = s*0.5;
    seg = int(max(4, (r*r*PI*0.1)));
    vertex = new PVector[seg];
    for (int i = 0; i < vertex.length; i++) {
      vertex[i] = new PVector(0, 0);
    }
  }

  void update() {

    float dis = dist(x, y, mouseX, mouseY);


    float dir = atan2(y-mouseY, x-mouseX);

    if (dis < 200) {
      float vel = pow(map(dis, 0, 200, 1, 0), 3);

      x += cos(dir)*vel*4;
      y += sin(dir)*vel*4;
    } else if (dis < 400) {
      float vel = pow(map(dis, 200, 400, 0, 1), 3);

      x += cos(dir)*-vel*4;
      y += sin(dir)*-vel*4;
    }


    float da = TAU/seg;

    float timeRot = millis()*0.001*velRot;

    for (int i = 0; i < seg; i++) {
      float nr = r*(0.85+cos(timeRot*20+map(i, 0, seg, 0, TAU*9))*0.15)*(0.8+cos(time*velOsc)*0.2);
      float ang = da*i;
      PVector pos = new PVector(cos(ang)*nr, sin(ang)*nr);
      vertex[i].lerp(pos, 0.5);
    }
  }

  void show() {

    noiseShader.set("displace", desNoise);
    shader(noiseShader);

    pushMatrix();
    translate(x, y);
    noStroke();
    fill(col);
    //ellipse(0, 0, s, s);
    beginShape();
    for (int i = 0; i < seg; i++) {
      PVector v = vertex[i];
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();



    resetShader();
  }
}
