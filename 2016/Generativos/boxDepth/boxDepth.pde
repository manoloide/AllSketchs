int paleta[] = {
  #222831, 
  #393E46, 
  #FF5722, 
  #EEEEEE
};

ColorRamp cr;
int seed; 
PShader post, depthShader;
PGraphics depth;

void setup() {
  size(640, 640, P3D);
  smooth(8);

  cr = new ColorRamp();
  cr.addColor(paleta[0], 0.0);
  cr.addColor(paleta[1], 0.2);
  cr.addColor(paleta[2], 0.5);
  cr.addColor(paleta[3], 1.0);

  post = loadShader("data/post.glsl");
  post.set("resolution", float(width), float(height));

  depthShader = loadShader("depthFrag.glsl", "depthVert.glsl");
  depthShader.set("near", 200.0); // Standard: 0.0
  depthShader.set("far", 800.0); // Standard: 100.0
  depthShader.set("nearColor", 1.0, 1.0, 1.0, 1.0); // Standard: white
  depthShader.set("farColor", 0.0, 0.0, 0.0, 1.0); // Standard: black

  depth = createGraphics(width, height, P3D);
  depth.shader(depthShader);
}

void draw() {
  if (frameCount%120 == 0) generate();

  pushMatrix();
  depth.beginDraw();
  drawScene(depth, false);
  depth.endDraw();
  drawScene(g, true);

  post.set("mouse", float(mouseX), float(mouseY));
  post.set("time", millis()/1000.);
  post.set("tDepth", depth.get());
  /*
  depthShader.set("near", 300.0+cos(frameCount*0.04)*200);
  depthShader.set("far", 900.0+cos(frameCount*0.04)*200);
  */
  filter(post);
  popMatrix();
  /*
  clear();
   image(depth, 0, 0);
   */
  /*
  hint(DISABLE_DEPTH_TEST);
   tint(255, 220);
   image(depth, 0, 0);
   hint(ENABLE_DEPTH_TEST);*/

  if (frameCount%2 == 0 && false) {
    if (frameCount >= 120*12) exit();
    else
      saveFrame("export/#####.png");
  }
}

void drawScene(PGraphics gra, boolean lights) {
  if (lights) {
    gra.lights();
    gra.pointLight(220, 120, 0, 0.5, cos(frameCount*0.02+PI)*500, 1);
    gra.pointLight(0, 120, 220, cos(frameCount*0.02)*500, 1, 1);
  }
  gra.noStroke();
  randomSeed(seed);
  noiseSeed(seed);
  gra.clear();
  gra.translate(width/2, height/3*2, -200);
  float v = 0.05;
  gra.rotateX(cos(frameCount*0.00097*v+random(PI))*0.2+PI*0.2);
  //gra.rotateY(frameCount*0.0013*v);
  gra.rotateZ(random(TWO_PI)+frameCount*0.007*v);


  int cc = 20;
  float tt = 80; 
  gra.translate(-cc/2.*tt, -cc/2.*tt, 0);
  float det = 0.008;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float x = i*tt;
      float y = j*tt;
      float ani = frameCount*0.0012;
      float noi = noise(x*det+ani, y*det+ani);
      float h = pow(0.8+noi, 13.8)*1.2;
      float z = h/2;
      gra.fill(cr.getColor(noi));
      gra.pushMatrix();
      gra.translate(x, y, z);
      gra.box(tt, tt, h);
      gra.popMatrix();
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  seed = int(random(99999999));
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

class Color {
  color col;
  float pos;
  Color (int col, float pos) {
    this.col = col;
    this.pos = pos;
  }
}

class ColorRamp {
  ArrayList<Color> colors;
  ColorRamp () {
    colors = new ArrayList<Color>();
  }

  void addColor(int c, float p){
    p = constrain(p, 0, 1);
    int ind = 0;
    for(int i = 0; i < colors.size(); i++){
      ind = i;
      if(p >= colors.get(i).pos){
        break;
      }
    }
    colors.add(ind, new Color(c, p));
  }

  color getColor(float p){
    p = constrain(p, 0, 1);
    color col = color(0);

    if(colors.size() > 0) col = colors.get(0).col;

    for(int i = 1; i < colors.size(); i++){
      if(p >= colors.get(i).pos){
        col = lerpColor(colors.get(i-1).col, colors.get(i).col, map(p, colors.get(i-1).pos, colors.get(i).pos, 0, 1));
        break;
      }
    }
    return col;
  }

  void show(float x, float y, float w, float h){
    for(int i = 0; i < w; i++){
      stroke(getColor(i*1./w));
      line(x, y+i, x+w, y+i);
    }
  }

}

