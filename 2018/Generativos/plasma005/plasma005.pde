/*
 - añadir osilaciones en las lineas
 x añadir grilla
 - generar cuadrados con la posiciones de los planetas, tipo una grilla hud
 - añadir pequeños datos como gusanos, entrecortados que se mueven por los planetas
 x probar colores mas celeste, naranja, verde. rotar los hue de los colores ;)
 - añadir pelos a las bolas, perlin + gravedad
 - 
 */

int seed = int(random(999999));
PShader add;
void setup() {
  size(960, 960, P2D);
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

class rect{
   float x, y, w, h;
   rect(float x, float y, float w, float h){
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
   }
}

void generate() { 

  //add = loadShader("addfrag.glsl", "addvert.glsl");

  int aux[] = {#000F29, #FE0706, #F85E8D, #3E56A8, #090D0E, #06A5FF, #FE0706, #F85E8D, #06A5FF};
  colors = aux;

  colorMode(HSB);
  float hr = random(360);
  println(hr);
  for (int i = 0; i < aux.length; i++) {
    int col = aux[i];
    colors[i] = color((hue(col)+hr)%360, saturation(col), brightness(col));
  }
  colorMode(RGB);

  randomSeed(seed);
  noiseSeed(seed);

  background(252);

  /*
  blendMode(DARKEST);  
   for (int i = 0; i < 1000; i++) {
   float x = random(width);
   float y = random(height);
   stroke(rcol(), random(100)*random(1));
   point(x, y);
   }
   */

  stroke(0, 4);
  for (int i = 0; i < width; i+=40) {
    line(0, i, width, i);
    line(i, 0, i, height);
  }

  stroke(0, 30);
  for (int j = 0; j < height; j+=40) {
    for (int i = 0; i < width; i+=40) {
      point(i+0.5, j+0.5);
    }
  }


  //shader(add);
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    x -= x%40;
    y -= y%40;
    float s = width*random(0.04, 0.7);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(x, y, p.x, p.y) < (s+p.z)*0.5) {
        add = false; 
        break;
      }
    }
    if (add) {
      points.add(new PVector(x, y, s));
    }
  }

  for (int i = 0; i < points.size(); i++) {
    if (random(1) < 0.6) continue;
    PVector p = points.get(i);
    float r = p.z;
    float amp = random(0.4, 1.2);
    int col = rcol();
    boolean randCol = true;//random(1) < 0.1;
    float detC = random(2)*random(0.6, 1);
    float desC = random(1000);
    float detD = random(2);
    float desD = random(1000);
    float cc = r*r*PI*random(0.4, 0.5)*8;
    float desSize = random(0.45, 0.75);
    for (int k = 0; k < cc; k++) {
      float a1 = random(TAU);//rot+random(PI);
      float a2 = random(PI);
      for (int j = 0; j < 1; j++) {
        a1 = random(TAU);//rot+random(PI);
        a2 = random(PI);
        PVector d = new PVector(cos(a1)*cos(a2), sin(a1)*cos(a2), sin(a2));
        float mr = desSize+(constrain(noise(desD+d.x*detD, desD+d.y*detD, desD+d.z*detD), 0.5, 1)-0.5);
        d.mult(mr*amp);
        if (randCol) col = getColor(noise(desC+d.x*detC, desC+d.y*detC, desC+d.z*detC)*colors.length*2);
        stroke(col, random(140));//, (cos(alp)*0.5+0.5)*110);
        point(p.x+d.x*r, p.y+d.y*r);
      }
    }
    col = rcol();
    stroke(col, 60);
    float a1 = random(PI);
    float a2 = random(TAU);
    float va1 = random(-0.05, 0.05)*random(1000);
    float va2 = random(-0.05, 0.05)*random(1000);
    /*
    cc = int(random(20000));
    for (int k = 0; k < cc; k++) {
      a1 += va1;
      a2 += va2;
      point(p.x+cos(a1)*cos(a2)*r, p.y+sin(a1)*cos(a2)*r, p.x+sin(a2)*r);
    }
    */

    if (random(1) < 0.2) {
      amp = random(1);
      pushMatrix();
      translate(p.x, p.y);
      rotate(random(TAU));
      cc = int(random(3, 55));
      float da = TAU/cc;
      for (int k = 0; k < 4000; k++) {
        a1 += va1;
        float  a = a1-(a1%da)*0.05;
        point(cos(a)*p.z*1.05, sin(a)*p.z*1.05*amp);
      }
      popMatrix();
    }

    fill(rcol(), random(200));
    ellipse(p.x, p.y, r*0.1, r*0.1);
  }

  for (int i = 0; i < points.size()*random(0.3, 0.4); i++) {
    PVector p1 = points.get(int(random(points.size())));
    PVector p2 = points.get(int(random(points.size()))); 
    if (random(1) < 0.5) {
      stroke(rcol(), random(256));
      line(p1.x, p1.y, p2.x, p2.y);
    } else {
      float dis = p1.dist(p2);
      int cc = int(dis);
      float dd = dis/cc;
      float a = atan2(p2.y-p1.y, p2.x-p1.x);
      noStroke();
      fill(rcol(), 4);
      arc(p1.x, p1.y, dis, dis, a, a+HALF_PI);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
//int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
int colors[] = {#000F29, #FE0706, #F85E8D, #3E56A8, #090D0E, #06A5FF, #FE0706, #F85E8D, #06A5FF};
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
