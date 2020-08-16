import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

PImage brush;
PImage forms[];
PImage img;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  brush = loadImage("diente.png");

  //loadForms();

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}


void generate() {

  randomSeed(seed);
  noiseSeed(seed);
  background(getColor());

  rectMode(CENTER);
  imageMode(CENTER);



  float detCol = random(0.01);

  float detSca = random(0.1);

  ArrayList<PVector> points = new ArrayList<PVector>();


  for (int i = 0; i < 1800; i++) {

    float x = random(width); 
    float y = random(height);
    float ns = pow(noise(x*detSca, y*detSca), 2);
    float sca = 0.05+random(0.5, 1.2)*random(1.4)*ns*5;

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(x, y, other.x, other.y) < 450*pow((sca+other.z)*0.2, 0.8)) {
        add = false;
        break;
      }
    }

    if (add) {

      float mult = 1;
      if (random(1) < 0.1) {
        blendMode(ADD);
        mult = 0.1;
      } else blendMode(NORMAL);

      float ia = 0;//random(TAU);
      float da = random(PI*0.1)*random(1)*0.25;
      float nc = noise(x*detCol, y*detCol);
      float ang = random(TAU);
      float alp = random(0.9, 1);
      float ampDa = random(0.6, 1.2)*0.5;
      float ampDes = random(1, 5);
      for (int k = 0; k < 12000; k++) {

        pushMatrix();
        translate(x, y);
        rotate(ang+da*ampDa*k+random(0.1)*random(0.1));
        float ns2 = pow(noise(x*detSca*50, y*detSca*50), 2);
        int col = getColor(sca*3+nc*7+ns2*2+k*0.02+random(0.1));//+k*0.0+nc+random(1));
        //col = lerpColor(col, color(0), ns2*0.9);
        float ma = min(1, k*0.01);
        tint(col, 240*mult*alp*ma);//lerpColor(color(0), rcol(), random(0.18)), random(255)*0.1);

        float des = 3.6*k*sca*ampDes;
        float ms = cos(k*0.01)*0.8;
        scale((1-k*0.001)*ms*random(1, 1.01));
        image(brush, cos(ia+da*0.01*k)*des, sin(ia+da*0.01*k)*des*0.3, brush.width*sca, brush.height*sca);

        if (random(1) < 0.02) {
          blendMode(ADD);
          tint(col, 240*mult*alp*ma*0.12);//lerpColor(color(0), rcol(), random(0.18)), random(255)*0.1);

          image(brush, cos(ia+da*0.01*k)*des, sin(ia+da*0.01*k)*des*0.3, brush.width*sca*10, brush.height*sca*10);
          blendMode(NORMAL);
        }

        popMatrix();
        if (ms < 0) break;
      }

      points.add(new PVector(x, y, sca));
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#030005, #0E263F, #F91800, #F6E479, #F0F2F5};
int colors[] = {#F6E8EA, #EF8F96, #162051, #312F2F, #9CDB62};
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
  return lerpColor(c1, c2, pow(v%1, 1.2));
} 
