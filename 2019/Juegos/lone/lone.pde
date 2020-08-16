import toxi.math.noise.SimplexNoise;

void settings() {
  size(960, 540, P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  rectMode(CENTER);
}


void draw() {

  float time = millis()*0.001;

  background(#e5e7ea);
  ambientLight(120, 120, 120);
  directionalLight(10, 20, 30, 0, -0.5, -1);
  lightFalloff(0, 1, 0);
  directionalLight(180, 160, 160, -0.8, +0.5, -1);

  ortho();

  float grid = 50;

  stroke(0, 20);

  pushMatrix();
  translate(width*0.5, height*0.5);
  rotateX(PI*0.25);
  rotateZ(PI*0.25);

  int cg = 5;
  fill(255);
  for (int j = -cg; j < cg; j++) {
    for (int i = -cg; i < cg; i++) {
      rect(grid*(i+0.5), grid*(j+0.5), grid*0.1, grid*0.1);
    }
  }

  fill(255);
  box(grid*2, grid*2, 8);
  float osc = grid*2.4+cos(time*2.5)*grid*0.1;
  noFill();
  rect(0, 0, osc, osc);
  popMatrix();


  hint(DISABLE_DEPTH_TEST);

  rectMode(CENTER);
  for (int i = 0; i < 5; i++) {
    float v = i-2;
    fill(90, 200);
    stroke(0, 90);
    rect(width*0.5+v*60, height-50, 50, 50, 4);
    noFill();
    rect(width*0.5+v*60, height-50, 46, 46, 3);
  }

  hint(ENABLE_DEPTH_TEST);
}
