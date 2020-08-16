int seed = int(random(999999));
import toxi.math.noise.SimplexNoise;

void setup() {
  size(960, 960, P3D);
  smooth(2);
  pixelDensity(2);

  generate();
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Box {
  float x, y, z, w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }
}


void generate() { 

  float time = millis()*0.001;

  randomSeed(seed);
  background(0);
  
  blendMode(ADD);


  float val = map(pow(abs(cos(time*0.05)), 2), 0, 1, 1.1, 2.2);
  float fov = PI/val;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*600.0);



  //frustum(-width, width, -height, height, -0.1, 2000);
  
  noiseDetail(1);

  rotateX((float) SimplexNoise.noise(time*0.002, -37.4)*PI*4);
  rotateY((float) SimplexNoise.noise(time*0.002, -2)*PI*4); 
  rotateZ((float) SimplexNoise.noise(time*0.002, 49)*PI*4);

  translate(width*0.5, height*0.5, -width*0.5);    
  scale(1./val);

  ArrayList<Box> boxes = new ArrayList<Box>();
  boxes.add(new Box(0, 0, 0, width*60, width*60, width*60));

  int sub = 800;//int(random(20000));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(boxes.size()*random(1)));
    Box b = boxes.get(ind);

    float mw = b.w*0.5;
    float mh = b.h*0.5;
    float md = b.d*0.5;

    boxes.add(new Box(b.x-mw*0.5, b.y-mh*0.5, b.z-md*0.5, mw, mh, md));
    boxes.add(new Box(b.x+mw*0.5, b.y-mh*0.5, b.z-md*0.5, mw, mh, md));
    boxes.add(new Box(b.x+mw*0.5, b.y+mh*0.5, b.z-md*0.5, mw, mh, md));
    boxes.add(new Box(b.x-mw*0.5, b.y+mh*0.5, b.z-md*0.5, mw, mh, md));     
    boxes.add(new Box(b.x-mw*0.5, b.y-mh*0.5, b.z+md*0.5, mw, mh, md));
    boxes.add(new Box(b.x+mw*0.5, b.y-mh*0.5, b.z+md*0.5, mw, mh, md));
    boxes.add(new Box(b.x+mw*0.5, b.y+mh*0.5, b.z+md*0.5, mw, mh, md));
    boxes.add(new Box(b.x-mw*0.5, b.y+mh*0.5, b.z+md*0.5, mw, mh, md));

    boxes.remove(ind);
  }



  noFill();
  stroke(255, 50);
  strokeWeight(2);

  for (int i = 0; i < boxes.size(); i++) {
    if(random(1) > 0.2) continue;
    Box b = boxes.get(i);
  stroke(rcol(), 80);
    pushMatrix();
    translate(b.x, b.y, b.z);
    //fill(rcol(), random(120, 240));
    box(b.w, b.h, b.d);
    
    box(b.w*0.9, b.h*0.01, b.d*0.01);
    box(b.w*0.01, b.h*0.9, b.d*0.01);
    box(b.w*0.01, b.h*0.01, b.d*0.9);

    box(b.w*0.1, b.h*0.1, b.d*0.1);
    
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
  return lerpColor(c1, c2, v%1);
}
