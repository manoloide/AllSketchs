int paleta[] = {
  /*
  #45595A, 
   #786650, 
   #E86A42, 
   #E2A672, 
   #F9C593*/
  #150936, 
  #BE005C, 
  #FE2B07, 
  #FE661F, 
  #6DDAD9
};

int r = 0;
int seed = 0;
int cantidadTexturas = 3;
PImage texturas[];

int VISUALIZACION = 0, TEXTURAS = 1;
int estado = TEXTURAS;

PFont helve;
PShader glow, vignette;

void setup() {
  size(600, 600, P3D);
  frameRate(-1);                                      // set unlimited frame rate
  //((PJOGL)PGraphicsOpenGL.pgl).gl.setSwapInterval(1);
  textureMode(NORMAL);
  smooth(16);
  helve = createFont("Helvetica Neue Bold", 68, true);
  glow = loadShader("glow.glsl");
  glow.set("iResolution", float(width), float(height)); 
  vignette = loadShader("vignette.glsl");
  vignette.set("resolution", float(width), float(height)); 
  crearTexturas();

  background(rcol());
}

void draw() {
  if(frameCount%20 == 0) frame.setTitle("fps:"+frameRate);
  // shader(vignette);
  //  shader(glow);
  hint(DISABLE_DEPTH_TEST);
  /*
  image(texturas[0], 0, 0, width/2, height/2);
   image(texturas[1], width/2, 0, width/2, height/2);
   image(texturas[2], 0, height/2, width/2, height/2);
   image(texturas[3], width/2, height/2, width/2, height/2);
   */
  hint(ENABLE_DEPTH_TEST);
  lights();
  int idl = 60;
  directionalLight(idl, idl, idl, 0, 0, -1);
  int ial = 80;
  ambientLight(ial, ial, ial);
  translate(width/2.0, height/2.0, -700);
  rotateX(frameCount*0.0008);
  rotateY(frameCount*0.0013);

  noStroke();
  r = int(random(999999999));
  randomSeed(seed);
  for (int i = 0; i < 80; i++) {
    pushMatrix();

    float sep = 500;
    translate(random(-sep, sep), random(-sep, sep), random(-sep, sep));
    float tt = random(10, 40)*cos(frameCount*0.002343+pow(2,i))+3; 
    scale(tt);
    TexturedCube(texturas[int(random(cantidadTexturas))]);
    /*
    scale(0.5/tt);
     translate(tt*0.6, 0, 0);
     
     fill(254);
     String name = str((int(random(65, 91))))+nf(int(random(100)), 2);
     textFont(helve);
     text(name, 0, 0);
     */
    popMatrix();
  }
  randomSeed(r);
  glow.set("iGlobalTime", frameRate/6.);

  //shader(vignette);
}

void keyPressed() {
  if (key == 's') saveFrame("#####.png");
  else if (key == 't') crearTexturas();
  else if (key == ENTER) background(rcol());
  else seed = int(random(9999999));
}

void mouseClicked() {

  if (mouseY < height/2) {
    if (mouseX < width/2) texturas[0] = crearTextura();
    else texturas[1] = crearTextura();
  } else {
    if (mouseX < width/2) texturas[2] = crearTextura();
    else texturas[3] = crearTextura();
  }
}
void crearTexturas() {
  texturas = new PImage[cantidadTexturas];
  for (int i = 0; i < cantidadTexturas; i++) {
    texturas[i] = crearTextura();
  }
}

PImage crearTextura() {
  int tt = 256;
  PGraphics aux = createGraphics(tt, tt);
  aux.beginDraw();
  aux.background(random(256), random(256),random(256));//rcol());
  int r = int(random(1));
  if (r == 0) {
    aux.stroke(random(256), random(256),random(256));//rcol());
    int esp = int(random(8, 24));
    aux.strokeWeight(esp*random(0.8, 1));
    for (int i = -int (random (esp)); i <tt*2; i +=esp*2) {
      aux.line(i, -2, -2, i);
    }
  }
  aux.endDraw();
  return aux.get();
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

void TexturedCube(PImage tex) {
  beginShape(QUADS);
  texture(tex);

  // Given one texture and six faces, we can easily set up the uv coordinates
  // such that four of the faces tile "perfectly" along either u or v, but the other
  // two faces cannot be so aligned.  This code tiles "along" u, "around" the X/Z faces
  // and fudges the Y faces - the Y faces are arbitrarily aligned such that a
  // rotation along the X axis will put the "top" of either texture at the "top"
  // of the screen, but is not otherwised aligned with the X/Z faces. (This
  // just affects what type of symmetry is required if you need seamless
  // tiling all the way around the cube)

  // +Z "front" face
  vertex(-1, -1, 1, 0, 0);
  vertex( 1, -1, 1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  // -Z "back" face
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1, 1, -1, 1, 1);
  vertex( 1, 1, -1, 0, 1);

  // +Y "bottom" face
  vertex(-1, 1, 1, 0, 0);
  vertex( 1, 1, 1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex(-1, 1, -1, 0, 1);

  // -Y "top" face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1, 1, 1, 1);
  vertex(-1, -1, 1, 0, 1);

  // +X "right" face
  vertex( 1, -1, 1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex( 1, 1, 1, 0, 1);

  // -X "left" face
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1, 1, 1, 0);
  vertex(-1, 1, 1, 1, 1);
  vertex(-1, 1, -1, 0, 1);

  endShape();
}
