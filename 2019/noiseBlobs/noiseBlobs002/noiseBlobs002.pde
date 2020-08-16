
ArrayList<Blob> blobs;
float time;
PShader noiseShader;

void setup() {
  size(960, 540, P2D);  

  noiseShader = loadShader("noiseFrag.glsl");

  blobs = new ArrayList<Blob>();
}

void draw() {

  time = millis()*0.001;

  background(80);

  noiseShader.set("displace", 543);
  shader(noiseShader);
  noStroke();
  fill(150);
  rect(0, 0, width, height);
  resetShader();


  for (int i = 0; i < blobs.size(); i++) {
    Blob b = blobs.get(i);
    b.update();
    b.show();
    if (b.remove) {
      blobs.remove(i--);
    }
  }
}

void mousePressed() {
  blobs.add(new Blob(mouseX, mouseY, 100));
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#89EBFF, #8FFF3F, #EF2F00, #3DFF53, #FCD200};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#320399, #E07AFF, #EA1026, #FFD70F, #E5E5E5};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}
