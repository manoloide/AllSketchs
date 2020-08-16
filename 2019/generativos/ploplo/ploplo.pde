import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) { 
    saveImage();
    exit();
  }
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

  randomSeed(seed);
  noiseSeed(seed);


  float fov = PI/random(2.2, 2.6);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);

  translate(width*0.5, height*0.5);
  rotateX(HALF_PI*random(4));
  rotateY(HALF_PI*random(4));

  background(240);

  blendMode(DARKEST);

  ArrayList<Box> boxes = new ArrayList<Box>();
  float ss = width+600;
  boxes.add(new Box(0, 0, 0, ss, ss, ss));

  translate(-ss*0.5, -ss*0.5, -ss*0.5);
  int sub = 20;
  for (int c = 0; c < sub; c++) {
    int ind = int(random(boxes.size()*0.2, boxes.size()*random(1))*0.1);
    if (random(1) < 0.8+pow((c*1./sub), 0.4)*0.8) ind = c;
    Box b = boxes.get(ind);

    float mw = b.w*0.5;
    float mh = b.h*0.5;
    float md = b.d*0.5;

    boxes.add(new Box(b.x, b.y, b.z, mw, mh, md));
    boxes.add(new Box(b.x+mw, b.y, b.z, mw, mh, md));
    boxes.add(new Box(b.x+mw, b.y+mh, b.z, mw, mh, md));
    boxes.add(new Box(b.x, b.y+mh, b.z, mw, mh, md));


    boxes.add(new Box(b.x, b.y, b.z+md, mw, mh, md));
    boxes.add(new Box(b.x+mw, b.y, b.z+md, mw, mh, md));
    boxes.add(new Box(b.x+mw, b.y+mh, b.z+md, mw, mh, md));
    boxes.add(new Box(b.x, b.y+mh, b.z+md, mw, mh, md));

    boxes.remove(ind);

    int sep = int(random(3, 10)*2);

    float det = random(0.012, 0.002)*random(0.4, 1)*0.1;
    float des = random(1000);

    float ic = random(colors.length);
    float dc = random(6, 8);

    float str = random(1, 5)*2;


    //beginShape(POINTS);
    stroke(rcol(), 250);
    int cc = 0;
    for (int k = 0; k < b.d; k+=sep) {
      for (int j = 0; j < b.h; j+=sep) {
        for (int i = 0; i < b.w; i+=sep) {
          /*
          cc++;
           if (cc > 8000) {
           cc = 0;
           endShape();
           beginShape(POINTS);
           }
           */
          float noi = (float)SimplexNoise.noise(des+i*det, des+j*det, des+k*det);
          strokeWeight(str*(noi+0.4));
          stroke(getColor(ic+dc*noi));
          if (noi < -0.6) point(b.x+i, b.y+j, b.z+k);
        }
      }
    }
    //endShape();
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
