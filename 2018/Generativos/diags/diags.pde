int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(#BAB9B6);

  noiseSeed(seed);
  randomSeed(seed);


  float bb = 50; 

  noFill();
  stroke(120);
  //rect(width/2, height/2, width-bb*2, height-bb*2);

  int cc = 8;
  float ss = (width-bb*2)/cc;
  rectMode(CENTER);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      noStroke();
      fill(240);
      rect(bb+(i+0.5)*ss, bb+(j+0.5)*ss, ss-4, ss-4);
      if(random(1) < 0.4) grad(bb+2+i*ss, bb+2+j*ss, ss-4, ss*random(0.4, 1)-4, rcol());
      if(random(1) < 0.4) tris(bb+2+i*ss, bb+2+j*ss, ss-4, ss-4, int(random(4)), rcol());
      if(random(1) < 0.4) tris(bb+2+i*ss, bb+2+j*ss, ss-4, ss-4, int(random(4)), rcol());
      
      fill(rcol());
      if(random(1) < 0.3) rect(bb+(i+0.5)*ss, bb+(j+0.5)*ss, ss*0.5, ss*0.5);
      if(random(1) < 0.3) ellipse(bb+(i+0.5)*ss, bb+(j+0.5)*ss, ss*0.5, ss*0.5);
  }
  }
}

void grad(float x, float y, float w, float h, int col){
  beginShape();
  fill(col, 160);
  vertex(x, y);
  vertex(x+w, y);
  fill(col, 0);
  vertex(x+w, y+h);
  vertex(x, y+h);
  endShape();
}

void tris(float x, float y, float w, float h, int l, int col){
  beginShape();
  fill(col, random(256));
  if(l != 0) vertex(x, y);
  fill(col, random(256));
  if(l != 1) vertex(x+w, y);
  fill(col, random(256));
  if(l != 2) vertex(x+w, y+h);
  fill(col, random(256));
  if(l != 3) vertex(x, y+h);
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FED42E, #FF84D4, #FFAFDA, #51B9FF, #2BFF6A};
int rcol() {
  return colors[int(random(colors.length))];
}

int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
