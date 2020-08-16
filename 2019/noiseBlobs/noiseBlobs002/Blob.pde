class Blob {

  boolean remove;
  float x, y, s, r;
  int seg, col;

  ArrayList<Vertex> vertexs;

  float desNoise, velRot, velOsc;

  Blob(float x, float y, float s) {

    this.x = x;
    this.y = y;
    this.s = s;

    vertexs = new ArrayList<Vertex>(); 

    col = rcol();
    
    velRot = random(1);

    r = s*0.5;
    seg = int(max(4, (r*r*PI*0.04)));
    for (int i = 0; i < seg; i++) {
      vertexs.add(new Vertex(x, y));
    }
  }

  void update() {


    float da = TAU/seg;
    float timeRot = millis()*0.001*velRot;

    for (int i = 0; i < vertexs.size(); i++) {
      float nr = r*(0.85+cos(timeRot*20+map(i, 0, seg, 0, TAU*9))*0.15)*(0.8+cos(time*velOsc)*0.2);
      float ang = da*i;
      PVector pos = new PVector(mouseX+cos(ang)*nr, mouseY+sin(ang)*nr);

      Vertex v = vertexs.get(i);
      v.update();
      v.setTarget(pos.x, pos.y);
    }
  }

  void show() {

    //noiseShader.set("displace", desNoise);
    //shader(noiseShader);

    noStroke();
    fill(col);
    //ellipse(0, 0, s, s);
    beginShape();
    for (int i = 0; i < seg; i++) {
      Vertex v = vertexs.get(i);
      vertex(v.x, v.y);
    }
    endShape(CLOSE);



    //resetShader();
  }
}

class Vertex {
  float x, y, nx, ny;
  float easing;

  Vertex(float x, float y) {
    this.x = nx = x; 
    this.y = ny = y;

    easing = random(0.1, 0.11);
  }

  void update() {
    x = lerp(x, nx, easing);
    y = lerp(y, ny, easing);
  }

  void setTarget(float nx, float ny) {
    this.nx = nx;
    this.ny = ny;
  }
}
