import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

PShader sh;
PShape grid;

void setup() {
  //size(1280, 720, P3D);
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void generate() {

  noiseSeed(seed);
  randomSeed(seed);

  sh = loadShader("frag.glsl", "vert.glsl");
  shader(sh);
  int bb = -80;
  int mw = (width-bb)/2;
  int mh = (height-bb)/2;
  grid = createShape();
  grid.beginShape(QUADS);
  grid.noStroke();  
  grid.fill(150);  
  float d = 2;
  float det = random(0.0006);
  float n1, n2, n3, n4;
  float des = random(1000);
  for (int x = -mw; x < mw; x += d) {
    for (int y = -mh; y < mh; y += d) {
      n1 = (float) SimplexNoise.noise(des+x*det, des+y*det);
      n2 = (float) SimplexNoise.noise(des+(x+d)*det, des+y*det);
      n3 = (float) SimplexNoise.noise(des+(x + d)*det, des+(y + d)*det);
      n4 = (float) SimplexNoise.noise(des+x*det, des+(y+d)*det);
      grid.fill(getColor(pow(n1, 4)*10));
      grid.attribPosition("tweened", x, y, 100 * n1);
      grid.vertex(x, y, 0);

      grid.fill(getColor(n2*12));
      grid.attribPosition("tweened", x + d, y, 100 * n2);
      grid.vertex(x + d, y, 0);

      grid.fill(getColor(n3*12));
      grid.attribPosition("tweened", x + d, y + d, 100 * n3); 
      grid.vertex(x + d, y + d, 0);

      grid.fill(getColor(n4*12));
      grid.attribPosition("tweened", x, y + d, 100 * n4);
      grid.vertex(x, y + d, 0);
    }
  }
  grid.endShape();
}

void draw() {
  background(255);
  sh.set("tween", 0.8);//map(mouseX, 0, width, 0, 1));
  translate(width*0.5, height*0.5, 0);
  //rotateX(frameCount * 0.01);
  //rotateY(frameCount * 0.01);
  shape(grid);
}


void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
int colors[] = {#EA2E73, #F7AA06, #1577D8};
//int colors[] = {#0F0F0F, #7C7C7C, #4C4C4C};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
}
