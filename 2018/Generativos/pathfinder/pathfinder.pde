import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

// montaña rusa
// cables entre edificios
// añadir carteles
// edificio en obra


// pantallas publictarias
// añadir parque

int farolColor;
int sandColor;

ArrayList<PVector> builds;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  hint(ENABLE_STROKE_PERSPECTIVE);
  rectMode(CENTER);

  generate();
}

void draw() {
  /*
  if (frameCount%60 == 0) {
   seed = int(random(999999));
   generate();
   }
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w;
    this.h = h;
  }
}

void generate() {

  //blendMode(ADD);


  randomSeed(seed);
  noiseSeed(seed);
  background(rcol());

  pushMatrix();
  //translate(0, 0, -3000);

  hint(DISABLE_DEPTH_MASK);
  back();
  hint(ENABLE_DEPTH_MASK);

  popMatrix();


  draw2();
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

void draw2() {

  ambientLight(50, 50, 50);
  directionalLight(10, 20, 30, 0, -0.5, -1);
  lightFalloff(0, 1, 0);
  directionalLight(240, 200, 200, -0.8, +0.5, -1);
  //lightFalloff(1, 0, 0);
  lightSpecular(0, 0, 0);

  boolean cameraUp = false;

  if (cameraUp) {
    translate(width*0.5, height*0.55, -200);
    //rotateX(HALF_PI);
  } else {
    ortho();
    translate(width*0.5, height*0.55, -2000);
    rotateX(HALF_PI*0.5);//*random(0.8, 1.2));
    rotateZ(HALF_PI*0.5);
  }

  float det = random(0.004);
  float des = random(10000);

  rectMode(CENTER);
  int cc = int(random(20, 32)*0.5);
  float size = width*0.68;
  float ss = size/cc;

  pushMatrix();
  translate(0, 0, 0.4);
  for (int i = 0; i < 1000; i++) {
    float x = random(-width, width);
    float y = random(-height, height);
    float s = random(6);
    noStroke();
    fill(rcol());
    ellipse(x, y, s, s);
  }
  popMatrix();

  barcos();
  //arboles();

  stroke(#135D00, 100);
  stroke(0, 20);
  for (int i = 0; i < cc*4; i++) {
    float x = (i*0.5-cc)*ss;
    line(x, -height, x, height);
    float y = (i*0.5-cc)*ss;
    line(-width, y, width, y);
  }

  pushMatrix();
  translate(0, 0, 0.2);
  for (int j = 0; j < cc*4; j++) {
    for (int i = 0; i < cc*4; i++) {

      if (i > cc-1 && i <= cc*3 && j > cc-1 && j <= cc*3) continue;
      float x = (i*0.5-cc)*ss;
      float y = (j*0.5-cc)*ss;
      float s = pow(max(0, noise(des+x*det, des+y*det)*1.8-0.8), 1.2);

      float n = 1;
      for (int k = 0; k < barcos.size(); k++) {
        PVector b = barcos.get(k);
        float dis = constrain(dist(x, y, b.x, b.y)/(b.z*0.7), 0, 1);
        dis = pow(dis, 3);
        if (n > dis) {
          n = dis;
        }
      }
      s *= n*0.4;



      line(x, y, 0, x, y, s*ss);
      fill(#2CBB01);  
      fill(255);
      rect(x, y, ss*0.08, ss*0.08);

      if (s <= 0) continue;
      pushMatrix();
      translate(0, 0, s*ss*0.9);
      fill(0);
      ellipse(x, y, s*ss*0.6, s*ss*0.6);
      fill(rcol());
      ellipse(x, y, s*ss*0.55, s*ss*0.55);    
      popMatrix();
    }
  }
  popMatrix();

  for (int i = 0; i < 10; i++) {
    int ix = int(random(cc*4));
    int iy = int(random(cc*4));
    if (ix > cc-1 && ix <= cc*3 && iy > cc-1 && iy <= cc*3) continue;
    float x = (ix*0.5-cc+0.25)*ss;
    float y = (iy*0.5-cc+0.25)*ss; 
    pushMatrix();
    translate(x, y, ss*0.25);
    noFill();
    box(ss*0.5);
    fill(rcol());
    box(ss*random(0.12, 0.16));
    popMatrix();
  }



  strokeWeight(0.8);
  stroke(0, 30);

  sandColor = rcol();
  farolColor = rcol();


  builds = new ArrayList<PVector>();

  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float x = (i-cc*0.5+0.5)*ss;
      float y = (j-cc*0.5+0.5)*ss;
      boolean sand = (i == 0 || j == 0 || i == cc-1 || j == cc-1);
      boolean build = (random(1) < 0.08) && !sand;
      boolean park = (!sand && !build && random(1) < 0.01);

      if (build) {
        builds.add(new PVector(x, y));
      }

      pushMatrix();
      translate(x, y, 0);

      stroke(0, 30);
      fill(#E6E7E9);
      if (sand) {
        fill(sandColor);
        noStroke();
      }


      translate(0, 0, ss*1*0.05);
      if (sand) box(ss*1.0, ss*1.0, ss*2*0.05);
      translate(0, 0, ss*1*0.05);
      translate(0, 0, ss*0.02);

      if (park) {
        fill(0, 255, 0);
        fill(rcol());

        translate(0, 0, ss*0.01);
        box(ss*0.86, ss*0.86, ss*0.02);
        translate(0, 0, ss*0.01);

        int cubes = int(random(2, 5)*random(0.5, 1));
        ArrayList<PVector> positions = new ArrayList<PVector>();
        for (int k = 0; k < cubes; k++) {
          float s = ss*0.03;
          float xx = random(-ss*0.43, ss*0.43);
          float yy = random(-ss*0.43, ss*0.43);
          xx = xx-xx%s;
          yy = yy-yy%s;

          boolean add = true;
          for (int l = 0; l < positions.size(); l++) {
            PVector other = positions.get(l);
            float dist = dist(xx, yy, other.x, other.y);
            if (dist < s*1.5) {
              add = false;
              break;
            }
          }
          if (add) {
            noStroke();
            pushMatrix();
            translate(xx, yy, s*0.5);
            rotate(random(TAU));
            int ccc = int(random(1, 16*random(0.1, 1)));
            for (int l = 0; l < ccc; l++) {
              fill(rcol());
              box(s);
              translate(0, 0, s);
            }
            popMatrix();
            positions.add(new PVector(x, y, s));
          }
        }
      }


      if (!sand && !build && !park) {
        stroke(0, 30);
        fill(200);
        translate(0, 0, ss*0.01);
        box(ss*0.86, ss*0.86, ss*0.02);
        translate(0, 0, ss*0.01);


        ArrayList<Box> boxes = new ArrayList<Box>();
        float noi = (0.1+pow(noise(des+x*det*1.2, des+y*det*1.2), 1.2)*1.0);
        boxes.add(new Box(0, 0, 0, ss*0.8, ss*0.8, ss*2*noi));

        int sub = int(random(6));
        for (int k = 0; k < sub; k++) {
          int ind = int(random(boxes.size()));
          Box b = boxes.get(ind);
          float w1 = random(0.3, 0.7);
          float w2 = (1-w1);
          float h1 = random(0.3, 0.7); 
          float h2 = (1-h1);

          boolean hor = random(1) < 0.5;
          if (b.w > b.h) hor = true;
          if (b.w < b.h) hor = false;

          w1 *= b.w;
          w2 *= b.w;
          h1 *= b.h;
          h2 *= b.h;
          if (hor) {
            boxes.add(new Box(b.x-b.w*0.5+w1*0.5, b.y, b.z, w1, b.h, b.d));
            boxes.add(new Box(b.x+b.w*0.5-w2*0.5, b.y, b.z, w2, b.h, b.d));
          } else {
            boxes.add(new Box(b.x, b.y-b.h*0.5+h1*0.5, b.z, b.w, h1, b.d));
            boxes.add(new Box(b.x, b.y+b.h*0.5-h2*0.5, b.z, b.w, h2, b.d));
          }
          boxes.remove(ind);
        }

        for (int k = 0; k < boxes.size(); k++) {
          Box b = boxes.get(k);   

          b.d = ss*2.*(0.2+pow(noise(des+x*det*1.2, des+y*det*1.2), 1.2)*0.9 );

          float dd = random(0.5, 1);
          if (random(1) < 0.2) dd = random(0.2, 0.5);

          fill(random(180, 240));
          if (random(1) < 0.1) fill(rcol());

          boolean mondrian = random(1) < 0.04;

          pushMatrix();
          translate(b.x, b.y, b.d*0.5*dd);
          if (mondrian) {
            ArrayList<Box> boxes2 = new ArrayList<Box>();
            boxes2.add(new Box(0, 0, 0, b.w, b.h, b.d*dd));

            int subs = int(random(20));
            for (int l = 0; l < subs; l++) {
              int ind = int(random(boxes2.size()));
              Box b2 = boxes2.get(ind);
              float w1 = random(0.3, 0.7);
              float w2 = (1-w1);
              float h1 = random(0.3, 0.7); 
              float h2 = (1-h1);
              float d1 = random(0.3, 0.7); 
              float d2 = (1-h1);

              float w = b2.w;
              float h = b2.h;
              float d = b2.d;

              w1 *= w;
              w2 *= w;
              h1 *= h;
              h2 *= h;
              d1 *= d;
              d2 *= d;

              boxes2.add(new Box(b2.x-w*0.5+w1*0.5, b2.y-h*0.5+h1*0.5, b2.z-d*0.5+d1*0.5, w1, h1, d1));
              boxes2.add(new Box(b2.x+w*0.5-w2*0.5, b2.y-h*0.5+h1*0.5, b2.z-d*0.5+d1*0.5, w2, h1, d1));
              boxes2.add(new Box(b2.x-w*0.5+w1*0.5, b2.y+h*0.5-h2*0.5, b2.z-d*0.5+d1*0.5, w1, h2, d1));
              boxes2.add(new Box(b2.x+w*0.5-w2*0.5, b2.y+h*0.5-h2*0.5, b2.z-d*0.5+d1*0.5, w2, h2, d1));

              boxes2.add(new Box(b2.x-w*0.5+w1*0.5, b2.y-h*0.5+h1*0.5, b2.z+d*0.5-d2*0.5, w1, h1, d2));
              boxes2.add(new Box(b2.x+w*0.5-w2*0.5, b2.y-h*0.5+h1*0.5, b2.z+d*0.5-d2*0.5, w2, h1, d2));
              boxes2.add(new Box(b2.x-w*0.5+w1*0.5, b2.y+h*0.5-h2*0.5, b2.z+d*0.5-d2*0.5, w1, h2, d2));
              boxes2.add(new Box(b2.x+w*0.5-w2*0.5, b2.y+h*0.5-h2*0.5, b2.z+d*0.5-d2*0.5, w2, h2, d2));

              boxes2.remove(ind);
            }

            for (int l = 0; l < boxes2.size(); l++) {
              Box o = boxes2.get(l);
              pushMatrix();
              translate(o.x, o.y, o.z);
              fill(rcol());
              box(o.w, o.h, o.d);
              popMatrix();
            }
          } else {
            box(b.w, b.h, b.d*dd);

            if (random(1) < 0.8) {
              float xx = b.w*random(-0.3, 0.3);
              float yy = b.h*random(-0.3, 0.3);
              float ww = b.w*random(0.2, 0.3)*random(0.5, 1);
              float hh = b.h*random(0.2, 0.3)*random(0.5, 1);
              float ddd = b.d*random(0.05, 0.18)*random(0.5, 1);

              pushMatrix();
              translate(xx, yy, b.d*dd*0.5+ddd*0.5);
              box(ww, hh, ddd);
              popMatrix();
            }
          }
          popMatrix();
        }
        translate(0, 0, ss*2*noi);
      }


      stroke(0, 30);
      if (build) {


        fill(rcol());
        pushMatrix();
        translate(0, 0, ss*1.2+random(4));

        int x1 = -int(random(i+0));
        int x2 = int(random(cc-i-1));//int(random(cc-i-2));         
        int y1 = -int(random(j+0));
        int y2 = int(random(cc-j-1));

        if (x1 != 0) {
          pushMatrix();
          float dd = ss*x1;
          translate(-ss*0.4, 0);
          translate(dd*0.5, 0, 0);
          box(dd, ss*((random(1) < 0.5)? 0.5 : 0.05), ss*0.05);
          popMatrix();
        }  

        if (x2 != 0) {
          pushMatrix();
          float dd = ss*x2;
          translate(ss*0.4, 0);
          translate(dd*0.5, 0, 0);
          box(dd, ss*((random(1) < 0.5)? 0.5 : 0.05), ss*0.05);
          popMatrix();
        } 


        if (y1 != 0) {
          pushMatrix();
          float dd = ss*y1;
          translate(0, -ss*0.4);
          translate(0, dd*0.5, 0);
          box(ss*((random(1) < 0.5)? 0.5 : 0.05), dd, ss*0.05);
          popMatrix();
        }  
        if (y2 != 0) {
          pushMatrix();
          float dd = ss*y2;
          translate(0, ss*0.4);
          translate(0, dd*0.5, 0);
          box(ss*((random(1) < 0.5)? 0.5 : 0.05), dd, ss*0.05);
          popMatrix();
        }


        //box(ss*((random(1) < 0.5)? 0.5 : 0.05), ss*10, ss*0.05);
        //box(ss*10, ss*((random(1) < 0.5)? 0.5 : 0.05), ss*0.05);

        translate(0, 0, ss*0.4);


        popMatrix();

        translate(0, 0, ss*1.3);        
        box(ss*0.8, ss*0.8, ss*2.6);
        int sub = 10;
        for (int k = 0; k < sub; k++) {

          pushMatrix();
          translate(map(k, 0, sub-1, -ss*0.4, ss*0.4), 0, -ss*0.7);
          box(ss*0.6/sub, ss*0.9, ss*0.8); 
          popMatrix();
          pushMatrix();
          translate(0, map(k, 0, sub-1, -ss*0.4, ss*0.4), -ss*0.7);
          box(ss*0.9, ss*0.6/sub, ss*0.8);
          popMatrix();

          pushMatrix();
          translate(map(k, 0, sub-1, -ss*0.4, ss*0.4), 0, ss*0.75);
          box(ss*0.6/sub, ss*0.9, ss*1); 
          popMatrix();
          pushMatrix();
          translate(0, map(k, 0, sub-1, -ss*0.4, ss*0.4), ss*0.75);
          box(ss*0.9, ss*0.6/sub, ss*1);
          popMatrix();
        }
        translate(0, 0, ss*1.3);

        translate(0, 0, ss*0.02);
        box(ss*0.4, ss*0.4, ss*0.04);
        translate(0, 0, ss*0.02);

        translate(0, 0, ss*0.06);
        box(ss*0.12, ss*0.12, ss*0.12);
        translate(0, 0, ss*0.06);
        
        
        fill(#272928);
        translate(0, 0, ss*0.4);
        box(ss*0.01, ss*0.01, ss*0.8);
        translate(0, 0, ss*0.4);
        
      } else {
        //noStroke();
        if (sand) {
          float dx = 0;
          float dy = 0;
          if (i == 0) dx = -1;
          if (i == cc-1) dx = +1;
          if (j == 0) dy = -1;
          if (j == cc-1) dy = +1;
          translate(ss*0.13*dx, ss*0.13*dy, 0);
          palm(ss*random(0.5, 0.75)*0.6);
        }
      }
      popMatrix();
    }
  }

  //tren(ss);

  pushMatrix();
  translate(0, 0, ss*0.03);
  stroke(255, 240, 120);
  baranda(int(size/8), ss*(cc-1.8), 4.5, false);
  stroke(0, 200);
  baranda(int(size/2), ss*(cc-1.4), 7, true);
  baranda(int(size/2), ss*cc*0.995, 7, true);
  popMatrix();


  stroke(0, 30);
  translate(0, 0, ss*0.1);
  fill(80);
  translate(0, 0, ss*0.01);
  box(ss*(cc-1.4), ss*(cc-1.4), ss*0.02);
  translate(0, 0, ss*0.01);
  fill(200);


  personitas(cc, ss);
  autos(cc, ss);
  //globos();
  nubes();
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int seg = int(max(2, PI*pow(abs(a1-a2), 2)));
  for (int i = 0; i < seg; i++) {
    float v1 = i*1./seg;
    float v2 = (i+1)*1./seg;
    float ang1 = lerp(a1, a2, v1);
    float ang2 = lerp(a1, a2, v2);
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    fill(col, alp2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    endShape(CLOSE);
  }
}

void baranda(int c, float ss, float h, boolean tapa) {
  float des = ss*0.5;
  if (tapa) {
    noFill();
    pushMatrix();
    translate(0, 0, h);
    rect(0, 0, des*2, des*2);
    popMatrix();
  }
  for (int i = 0; i < c; i++) {
    float v = map(i, 0, c-1, -des, des);
    line(+des, v, 0, +des, v, h);
    line(-des, v, 0, -des, v, h);
    line(v, +des, 0, v, +des, h);
    line(v, -des, 0, v, -des, h);
  }
}

void torre(float ss) {

  translate(0, 0, ss*0.03);
  fill(rcol());
  box(ss*0.2, ss*0.2, ss*0.06);
  translate(0, 0, ss*0.03);

  translate(0, 0, ss*0.25);
  fill(rcol());
  box(ss*0.02, ss*0.02, ss*0.5);
  translate(0, 0, ss*0.25);
}

void palm(float ss) {

  translate(0, 0, ss*0.01);
  fill(#BCEBD2);
  box(ss*0.18, ss*0.18, ss*0.02);
  translate(0, 0, ss*0.01);

  //translate(0, 0, ss*0.25);
  int col = farolColor;
  while (col == sandColor) col = rcol();
  fill(col);
  //box(ss*0.02, ss*0.02, ss*0.5);
  //translate(0, 0, ss*0.25);

  pushMatrix();
  noStroke();
  float ms = 1;
  int cc = 20;
  for (int i = 0; i < cc; i++) {
    box(ss*0.05*ms);
    ms *= 0.97;
    translate(0, 0, ss*0.05*ms);
    rotateX(random(-0.03, 0.03));
    rotateY(random(-0.03, 0.03));
    rotateZ(random(-0.03, 0.03));
  }
  float angle = random(TAU);
  float da = TAU/6.;
  for (int i = 0; i < 6; i++) {
    float ang = angle+da*i;
    float xx = cos(ang)*ss*0.3;
    float yy = sin(ang)*ss*0.3;
    fill(col);
    noStroke();
    ellipse(xx, yy, 2, 2);

    float des = ss*2.2;
    stroke(col, 200);
    noFill();
    curve(xx, yy, -des, xx, yy, 0, 0, 0, 0, 0, 0, -des);
  }
  noStroke();
  popMatrix();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#EFF1F4, #81C7EF, #2DC3BA, #BCEBD2, #F9F77A, #F8BDD3, #272928};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
