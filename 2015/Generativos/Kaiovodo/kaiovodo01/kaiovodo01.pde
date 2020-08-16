import processing.pdf.*;

int seed = 10;

void setup() {
  size(851 , 315);//, PDF, "pdf.pdf");
}

void draw() {
  randomSeed(seed);
  noiseSeed(seed);

  background(255);
  int sep = 40; 
  float bb = 80; 
  int cc = 3; 
  float ss = (width-bb*(cc-1)-bb*3)/cc;

  {
    float s = 60;
    float h = (sqrt(3)*s)/2;
    int cw = int(width/s)+1;
    int ch = int(height/h)+1;
    float def = 5;
    float det = 0.05;
    for (float j = 0; j < ch; j++) {
      for (float i = 0; i < cw; i++) {
        float xx = i*s+s*0.5*(j%2)+(noise(i*det, j*det)-0.5)*s*def;
        float yy = j*h+(noise(i*det, j*det)-0.5)*h*def;
        noStroke();
        fill(0, 180);
        ellipse(xx, yy, 5, 5);
        stroke(0, 40);
        if ((j+1)%2 == 0)
          line(xx, yy, (i+1)*s+s*0.5*((j+1)%2)+(noise((i+1)*det, (j+1)*det)-0.5)*s*def, (j+1)*h+(noise((i+1)*det, (j+1)*det)-0.5)*h*def);
        else 
          line(xx, yy, (i-1)*s+s*0.5*((j+1)%2)+(noise((i-1)*det, (j+1)*det)-0.5)*s*def, (j+1)*h+(noise((i-1)*det, (j+1)*det)-0.5)*h*def);
        line(xx, yy, (i)*s+s*0.5*((j+1)%2)+(noise(i*det, (j+1)*det)-0.5)*s*def, (j+1)*h+(noise(i*det, (j+1)*det)-0.5)*h*def);
        line(xx, yy, (i+1)*s+s*0.5*((j)%2)+(noise((i+1)*det, j*det)-0.5)*s*def, (j)*h+(noise((i+1)*det, j*det)-0.5)*h*def);
      }
    }
  }

  {
    float det = 0.006;
    for (int i = 0; i < 2000000; i++) {
      float x = random(width);
      float y = random(height);
      float n = noise(x*det, y*det);
      float a = n*TWO_PI;
      float d = map(n, 0, 1, 0, 32); 
      line(x, y, x+cos(a)*d, y+sin(a)*d);
    }
  }


  {
    stroke(0, 200);
    fill(255);
    float det = 0.005;
    for (int i = 0; i < 60000; i++) {
      float x = random(width);
      float y = random(height);
      float n = noise(x*det, y*det); 
      float dif = x-y+n*110;
      if (dif < 0) continue;
      float tt = n*40;
      if (dif < 800) tt *= sin(map(dif, 0, 800, 0.1, PI/2));
      cross(x, y, tt, n*TWO_PI, random(0.12, 0.4));
    }
  }

  {
    fill(255);
    float det = 0.005;
    for (int i = 0; i < 10000; i++) {
      float x = random(width);
      float y = random(height);
      float s = noise(x*det, y*det)*80-40;
      if (s > 0) {
        //ellipse(x, y, s, s);
        circle(x, y, s, 5);
        float ls = s*random(0.04, 0.16);
        line(x-ls, y-ls, x+ls, y+ls);
        line(x+ls, y-ls, x-ls, y+ls);
      }
    }
  }
  /*
  {
   float det = 0.008;
   for (int i = 0; i < 10000; i++) {
   float x = random(width);
   float y = random(height);
   float s = pow(noise(x*det, y*det)*140, 1.2)-100;
   if (s < 0 || x-y > 0) continue;
   circle(x, y, s, int(random(3, 6)));
   float a = -PI/4;
   float d = s*0.22;
   fill(0);
   circle(x+cos(a)*d, y+sin(a)*d, s*random(0.32, 0.43), int(random(3, 5)));
   fill(255);
   circle(x+cos(a)*(d*1.22), y+sin(a)*(d*1.22), s*random(0.12, 0.2), int(random(3, 5)));
   }
   }*/


  /*
  noFill();
   for (int j = 0; j < cc; j++) {
   for (int i = 0; i < cc; i++) {
   float x = bb*1.5+(bb+ss)*i;
   float y = bb*1.5+(bb+ss)*j;
   rect(x, y, ss, ss);
   }
   }*/
/*
  noStroke();
  fill(255);
  rect(0, bb*1.5, bb*1.5, height-bb*3);
  rect(width-bb*1.5, bb*1.5, bb*1.5, height-bb*3);
  rect(0, 0, width, bb*1.5);
  rect(0, height-bb*1.5, width, bb*1.5);
 */
  saveFrame("export.png");
  exit();
}

void circle(float x, float y, float d, int sec) {
  float r = d*0.5;
  float da = TWO_PI/sec;
  float kappa = 0.5522847498;
  float k = 4*kappa/sec;
  PVector points[] = new PVector[sec];

  for (int i = 0; i < sec; i++) {
    points[i] = new PVector(x+cos(da*i)*r+r*random(-0.1, 0.1), y+sin(da*i)*r+r*random(-0.1, 0.1));
  }

  stroke(0);
  beginShape();
  vertex(points[0].x, points[0].y);
  for (int i = 0; i < sec; i++) {
    bezierVertex(
    points[i].x+cos(da*i+PI/2)*r*k, points[i].y+sin(da*i+PI/2)*r*k, 
    points[(i+1)%sec].x+cos(da*(i+1)-PI/2)*r*k, points[(i+1)%sec].y+sin(da*(i+1)-PI/2)*r*k, 
    points[(i+1)%sec].x, points[(i+1)%sec].y
      );
  }
  endShape(CLOSE);
}

void cross(float x, float y, float d, float a, float s) {
  PGraphics gra = g;
  float r = d*0.5;
  float sep = r*s;
  float r2 = dist(sep, 0, 0, sep);
  float da = TWO_PI/4;
  gra.beginShape();
  for (int i = 0; i < 4; i++) {
    float ang = a+da*i;
    gra.vertex(x+cos(ang-PI/4)*r2, y+sin(ang-PI/4)*r2);
    float sx = cos(ang-PI/2)*sep; 
    float sy = sin(ang-PI/2)*sep;
    float xx = x+cos(ang)*r;
    float yy = y+sin(ang)*r;
    gra.vertex(xx+sx, yy+sy);
    gra.vertex(xx-sx, yy-sy);
  }
  gra.endShape(CLOSE);
}

void poly(float x, float y, float d, int c, float a) {
  PGraphics gra = g;
  float r = d*0.5;
  float da = TWO_PI/c;
  gra.beginShape();
  for (int i = 0; i < c; i++) {
    gra.vertex(x+cos(da*i+a)*r, y+sin(da*i+a)*r);
  }
  gra.endShape(CLOSE);
}

