int seed = int(random(999999));
import toxi.math.noise.SimplexNoise;

void setup() {
  size(960, 960, P3D);
  smooth(2);
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
  background(250);

  //blendMode(ADD);


  float val = 3;//map(pow(abs(cos(time*0.05)), 2), 0, 1, 1.1, 2.2);
  float fov = PI/val;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*600.0);



  //frustum(-width, width, -height, height, -0.1, 2000);

  noiseDetail(1);

  translate(width*0.5, height*0.5, -width*0.5);   

  ArrayList<Box> boxes = new ArrayList<Box>();
  boxes.add(new Box(0, 0, 0, width*2, width*2, width*2));

  int sub = int(random(12, 80));//int(random(20000));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(boxes.size()*random(0.5)));
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

  hint(DISABLE_DEPTH_MASK);



  noFill();
  strokeWeight(0.8);

  for (int i = 0; i < boxes.size(); i++) {
    //if (random(1) > 0.5) continue;
    Box b = boxes.get(i);
    pushMatrix();
    translate(b.x, b.y, b.z);
    //fill(rcol(), random(120, 240));
    box(b.w, b.h, b.d);
    //if(random(1) < 0.04) sphere(b.w*0.05);
    /*
     box(b.w*0.9, b.h*0.01, b.d*0.01);
     box(b.w*0.01, b.h*0.9, b.d*0.01);
     box(b.w*0.01, b.h*0.01, b.d*0.9);
     box(b.w*0.1, b.h*0.1, b.d*0.1);
     */
    int cc = int(max(3, b.w*random(0.1, 0.9)));
    stroke(rcol(), random(8, 18));
    for (int j = 1; j < cc; j++) {
      float amp = 0.5;
      float v = map(j, 0, cc, -amp, amp);
      pushMatrix();
      translate(-b.w*amp, -b.h*amp, v*b.d);
      if (random(1) < 0.9) rect(0, 0, b.w, b.h);
      popMatrix();

      pushMatrix();
      translate(v*b.w, -b.h*amp, b.d*amp);
      rotateY(HALF_PI);
      if (random(1) < 0.9) rect(0, 0, b.w, b.h);
      popMatrix();

      pushMatrix();
      translate(-b.w*0.5, v*b.w, -b.d*0.5);
      rotateX(HALF_PI);
      if (random(1) < 0.9) rect(0, 0, b.w, b.h);
      popMatrix();
    }

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
