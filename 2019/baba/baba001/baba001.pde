import toxi.math.noise.SimplexNoise;


int seed = int(random(99999999));

boolean export = false;
float timeExport = 15;

PImage text;
PShader blur;
PShader displace;
PImage colorMap, displacementMaps;

void setup() {
  //size(1920, 1080, P3D);
  //size(960, 540, P2D);
  size(displayWidth, displayHeight, P3D);
  frameRate(30);
  smooth(8);
  blur = loadShader("blur.glsl");
  text = loadImage("circleGrad.png");

  colorMap = loadImage("Texture01.jpg");
  displacementMaps = imageToDisplacementMap(colorMap);

  float displaceStrength = 300.5;
  displace = loadShader("displaceFrag.glsl", "displaceVert.glsl"); // load the PShader with a fragment and a vertex shader
  displace.set("displaceStrength", displaceStrength); // set the displaceStrength
  displace.set("colorMap", colorMap);
  displace.set("displacementMap", displacementMaps);



  generate();
  background(255);
}


void draw() {



  float time = frameCount*(1./30);
  float nt = time/timeExport;
  nt = nt%1;

  if (frameCount%20 == 0) blur = loadShader("blur.glsl");

  noTint();
  float blurAmp = map(cos(time*10), -1, 1, 0.001, 0.005)*0.04;
  blur.set("time", nt);//nt+random(1000));
  for (int i = 0; i < 5; i++) {
    blur.set("direction", blurAmp, 0);
    filter(blur); 
    blur.set("direction", 0, blurAmp);
    filter(blur);
  }

  //println(time, nt);

  randomSeed(seed);
  noiseSeed(seed);

  //lights();


  translate(width/2, height/2, cos(nt*PI*2)*100); 
  rotateY(cos(nt*PI)*0.4); 
  rotateX(cos(nt*PI*3)*0.4); 
  
  
  //spotLight(255, 0, 0, 0, 0, 40, cos(nt*PI), 0, 0, PI/2, 2);
  ambientLight(280, 240, 240);

  //background(0); // black background
  //perspective(PI/3.0, (float) width/height, 0.1, 1000000); // perspective for close shapes
  //scale(100); // scale by 100

  float det = random(6);
  colorMode(HSB, 1, 1, 1);
  color col = color(cnoise(nt, random(det))*1, 1, cnoise(nt, random(det))*3);
  colorMode(RGB, 255, 255, 255);
  tint(red(col), green(col), blue(col));

  //tint(255, 0, 0);
  displace.set("time", nt);
  displace.set("displaceStrength", cos(nt*TAU*2)*500);
  textureMode(NORMAL);
  shader(displace);
  stroke(0);
  //fill(255);
  //shape(mesh);
  renderPlane();

  //sphere(200);
  if (export) {
    if (frameCount >= timeExport*30) saveFrame("export/####.png");
    if (frameCount >= timeExport*30*2)exit();
    //else saveFrame("export/####.png");
  }
}


float cnoise(float tt, float det) {
  float aa = tt*TAU;
  float xx = cos(aa)*det;
  float yy = sin(aa)*det;
  return noise(xx, yy);
}

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(9999999));

  mesh = CreatePlane();
}

PShape mesh;

PShape CreatePlane() {

  float w = 400;
  float h = 800;

  int cw = 40;
  int ch = 80;

  float sw = 10;
  float sh = 10;

  float dx = sw*cw*-0.5;
  float dy = sh*ch*-0.5;

  PShape mesh = createShape();
  //mesh.
  mesh.beginShape(TRIANGLES);
  mesh.noStroke();
  mesh.texture(colorMap);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float xx = i*sw+dx;
      float yy = j*sh+dy;
      mesh.normal(0, 0, 1);
      mesh.vertex(xx, yy, 0, i*1./cw, j*1./cw);
      mesh.normal(0, 0, 1);
      mesh.vertex(xx+sw, yy, 0, i*1./cw, j*1./cw);
      mesh.normal(0, 0, 1);
      mesh.vertex(xx, yy+sh, 0, i*1./cw, j*1./cw);
      mesh.normal(0, 0, 1);
      mesh.vertex(xx+sw, yy+sh, 0, i*1./cw, j*1./cw);
      mesh.normal(0, 0, 1);
      mesh.vertex(xx+sw, yy, 0, i*1./cw, j*1./cw);
      mesh.normal(0, 0, 1);
      mesh.vertex(xx, yy+sh, 0, i*1./cw, j*1./cw);
    }
  }
  mesh.endShape();

  return mesh; // our work is done here, return DA MESH! ;-)
}

PShape renderPlane() {

  float w = 400;
  float h = 800;

  int cw = 40;
  int ch = 80;

  float sw = 10;
  float sh = 10;

  float dx = sw*cw*-0.5;
  float dy = sh*ch*-0.5;

  beginShape(TRIANGLES);
  noStroke();
  texture(colorMap);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float xx = i*sw+dx;
      float yy = j*sh+dy;
      normal(0, 0, 1);
      vertex(xx, yy, 0, i*1./cw, j*1./ch);
      normal(0, 0, 1);
      vertex(xx+sw, yy, 0, i*1./cw, j*1./ch);
      normal(0, 0, 1);
      vertex(xx, yy+sh, 0, i*1./cw, j*1./ch);
      normal(0, 0, 1);
      vertex(xx+sw, yy+sh, 0, i*1./cw, j*1./ch);
      normal(0, 0, 1);
      vertex(xx+sw, yy, 0, i*1./cw, j*1./ch);
      normal(0, 0, 1);
      vertex(xx, yy+sh, 0, i*1./cw, j*1./ch);
    }
  }
  endShape();

  return mesh; // our work is done here, return DA MESH! ;-)
}

int blurFactor = 3; // the blur for the displacement map (to make it smoother)
float resizeFactor = 0.2; // the resize factor for the displacement map (to make it smoother)
PImage imageToDisplacementMap(PImage img) {
  PImage imgCopy = img.get(); // get a copy so the original remains intact
  imgCopy.resize(int(imgCopy.width*resizeFactor), int(imgCopy.height*resizeFactor)); // resize
  if (blurFactor >= 1) { 
    imgCopy.filter(BLUR, blurFactor);
  } // apply blur
  return imgCopy;
}


//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
int colors[] = {#fffc3d, #000ed9, #f5adff};
//int colors[] = {#F7743B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#F7513B, #6789AA, #4B4372, #262626};
//int colors[] = {#50A85F, #DD2800, #F2AF3C, #5475A8};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
//int colors[] = {#FFCC33, #FFA8F4, #4949FF, #00DBDB, #EDFFFC};
//int colors[] = {#E8E6DD, #DFBB66, #D68D46, #857F5D, #809799, #5D6D83, #0F1C15};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
//int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};
//int colors[] = {#EA0707, #58C908, #163572, #000000};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v); 
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 3.8));
}
