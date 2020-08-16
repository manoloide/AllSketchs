int seed = int(random(999999));

PShader noi;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");

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

  background(rcol());

  noiseSeed(seed);
  randomSeed(seed);
  
  lights();

  float fov = PI/random(1.1, 1.2);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);

  
  translate(width*0.5, height*0.5, 500);
  rotateX(random(-TAU, TAU)*0.002);
  rotateY(random(-TAU, TAU)*0.002);
  rotateZ(random(-TAU, TAU)*0.002);
  

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");


  strokeWeight(2);

  stroke(0);
  noFill();
  int cc = int(random(60, 80)*0.4)*1;
  
  float size = width*2.2;

  float amp = random(0.02)*random(1);
  float ang = random(TAU);

  noStroke();
  fill(rcol(), 240);
  noi.set("displace", random(100));
  shader(noi);
  for (int j = 0; j <= cc; j++) {
    float v = j*1./cc;
    wline(lerp(-size, size, v), -size, lerp(-size, size, v), size, amp, ang, cc, j%2 == 1);
    wline(size, lerp(-size, size, v), -size, lerp(-size, size, v), amp, ang, cc, j%2 == 0);
  }
}

void wline(float x1, float y1, float x2, float y2, float amp, float ang, int c, boolean inv) {
  int cc = int(max(1, dist(x1, y1, x2, y2)*2.2));
  float a = atan2(y2-y1, x2-x1)+HALF_PI;

  float des = random(1000);
  float det = random(0.006, 0.008)*1;
  
  noiseDetail(2);
  
  //noFill();
  //stroke(0);
  
  stroke(255, 8);
  //noStroke();
  
  float desc = random(100);
  float detc = random(0.001);
  
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= cc; i++) {
    float v = i*1./cc;
    float x = lerp(x1, x2, v);
    float y = lerp(y1, y2, v);
    float z = cos(v*c*PI+((inv)? PI : 0))*12;
    //float sz = (z > 0)? 1 : -1;
    //z = pow(z, 1.2)*sz;
    float str = lerp(1, 20, noise(des+x*det, des+y*det)*sin(v*PI));
    float col = noise(desc+x*detc, desc+y*detc)*10;
    fill(getColor(col));//ic+dc*v));
    vertex(x+cos(a)*str, y+sin(a)*str, z);
    vertex(x+cos(a+PI)*str, y+sin(a+PI)*str, z);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#000000, #0D0D52, #401972, #FF55A7, #F59CD4, #4CFDC6};
//int colors[] = {#1C2533, #303A36, #9DA37F, #A88D40, #C5BD77, #EAF2D9, #C2C8A8, #DED9A2, #DFE4CC};
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
