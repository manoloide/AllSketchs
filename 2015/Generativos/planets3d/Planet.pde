class Planet {
  float tam;
  int time, timeChange;
  Planet nextPlanet;
  PShape planet;
  PImage texture, normals;
  PGraphics aux;
  Planet() {
    timeChange = 10;
    aux = createGraphics(1024, 512, P2D);
    generate();
  }
  void update() {
    show();
    if (time > 0) {
      planet.resetMatrix();
      planet.scale(map(time, timeChange, 0, tam, nextPlanet.tam));
      time--;
      if (time == 0) {
        thread("changePlanet");
      }
    }
  }

  void show() {
    if (time > 0) {
      textureMix.set("mixValue", 1-time*1.0/timeChange);
      textureMix.set("tex0", texture);
      textureMix.set("tex1", nextPlanet.texture);
      aux.beginDraw();
      aux.shader(textureMix);
      aux.image(texture, 0, 0);
      aux.endDraw();
      displace.set("colorMap", aux.get());
      textureMix.set("tex0", normals);
      textureMix.set("tex1", nextPlanet.normals);
      aux.beginDraw();
      aux.clear();
      aux.shader(textureMix);
      aux.image(texture, 0, 0);
      aux.endDraw();
      displace.set("displacementMap", aux.get());
    } else {
      displace.set("colorMap", texture);
      displace.set("displacementMap", normals);
    }
    shape(planet);
  }

  void generate() {
    generateTexture(1024, 512);
    noStroke();
    sphereDetail(40);
    tam = random(180, 280);
    planet = createShape(SPHERE, 1);
    planet.scale(tam);
    planet.setTexture(texture);
  }

  void change(Planet np) {
    nextPlanet = np;
    time = timeChange;
  }

  void  generateTexture(int w, int h) {
    pushStyle();
    colorMode(HSB, 256, 256, 256);
    int c = int(random(256));
    color cwater = color((c+128)%256, random(200), random(50, 100));
    color c1 = color(c, random(200, 255), random(200, 256));
    color c2 = color(c+random(-20, 20), random(120), random(10, 100));
    popStyle();
    texture = createImage(w, h, RGB);
    normals = createImage(w, h, RGB);
    noiseSeed(int(random(9999999)));
    float det = random(0.01, 0.02);
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        float n = noise(i*det+100, j*det);
        if (i > w*0.9) {
          float mix = map(i, w*0.9, w, 0, 1);
          n = lerp(n, noise((i-w)*det+100, j*det), mix);
        }
        n = pow(n*2-1, 1.2);
        color col = color(0, 255, 0); 
        if (n < 1) {
          if (n < 0.01) {
            col = lerpColor(cwater, c1, pow(n*100, 1.5));
            n *= 10;
          } else {
            n += 0.1;
            col = lerpColor(c1, c2, n);
          }
        } else {
          n = 0;
          col = lerpColor(cwater, color(255), (n-1)/5);//lerpColor(c3, c2, constrain(n, 0, 1));
        }

        texture.set(i, j, col);
        normals.set(i, j, color(255*pow(n, 1.2)));//max(n, 0.5)*256));
      }
    }
  }
}

