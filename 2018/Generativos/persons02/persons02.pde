import org.processing.wiki.triangulate.*;

import java.util.*;

int seed = int(random(999999));

//paraguas
//lluvia 
//conexiones cabeza


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

void generate() {

  int back = rcol();
  while (back == #2b00be) back = rcol();

  randomSeed(seed);
  noiseSeed(seed);
  background(back);

  int grid = int(random(40, 60));
  float ss = width*1./grid;

  stroke(255, 12);
  for (int i = 0; i <= grid; i++) {
    line(i*ss, 0, i*ss, height);
    line(width, i*ss, 0, i*ss);
  }

  /*
  noStroke();
   for (int i = 0; i < 800; i++) {
   float x = random(width);
   float y = random(height);
   float s = random(1, 16)*random(1)*random(1)*random(1);
   fill(rcol());
   ellipse(x, y, s, s*0.3);
   }
   */

  /*
  stroke(#C4F7FF, 40);
   fill(#C4F7FF, 20);
   for (int i = 0; i < 600; i++) {
   float x = random(width);
   float y = random(height);
   float s = random(1, 8);
   ellipse(x, y, s, s*0.5);
   }
   */


  ArrayList<PVector> threes = new ArrayList<PVector>();
  for (int i = 0; i < 0; i++) {
    float x = random(width);
    float y = random(height);
    float s = ss*random(4, 20);
    PVector three = new PVector(x, y);

    boolean add = true;
    for (int j = 0; j < threes.size(); j++) {
      PVector other = threes.get(j);
      if (dist(x, y, other.x, other.y) < (s+other.z)*0.5) {
        add = false;
        break;
      }
    }
    three.z = s;
    if (add) threes.add(three);
  }

  for (int i = 0; i < threes.size(); i++) {
    PVector t = threes.get(i);
    int col = rcol();
    while (col == back) col = rcol();
    noStroke();
    fill(col);
    ellipse(t.x, t.y, t.z, t.z*0.34);
    fill(0, 30);
    ellipse(t.x, t.y, t.z*0.11, t.z*0.11*0.34);
    fill(rcol());
    ellipse(t.x, t.y, t.z*0.1, t.z*0.1*0.34);

    noFill();    
    stroke(0);
    float s1 = t.z*1.02-2;
    float s2 = t.z*1.02*0.34;
    ellipse(t.x, t.y, s1, s2);
    ellipse(t.x, t.y-34, s1, s2);

    int cc = int(PI*s1*0.1);
    float da = TAU/cc;
    for (int j = 0; j < cc; j++) {
      float xx = t.x+cos(da*j)*s1*0.5;
      float yy = t.y+sin(da*j)*s2*0.5;
      line(xx, yy, xx, yy-34);
    }

    //line(t.x, t.y, t.x, t.y-t.z);
  }



  ArrayList<PVector> persons = new ArrayList<PVector>();

  noStroke();
  noFill();
  for (int i = 0; i < grid*1.6; i++) {
    float x = random(-width*0.1, width*1.1);
    float y = random(-height*0.1, height*1.1);

    x -= x%ss;
    y -= y%ss;
    PVector person = new PVector(x, y);

    boolean add = true;
    for (int j = 0; j < persons.size(); j++) {
      PVector other = persons.get(j);
      if (person.dist(other) < 5) {
        add = false;
        break;
      }
    }

    for (int j = 0; j < threes.size(); j++) {
      PVector other = threes.get(j);
      if (dist(x, y*3, other.x, other.y*3) < other.z*0.5) {
        add = false;
        break;
      }
    }

    if (add) persons.add(person);
  }

  ArrayList triangles = Triangulate.triangulate(persons);

  stroke(255, 28);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    if (random(1) < 0.6) continue;
    Triangle t = (Triangle)triangles.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
  
  noStroke();
  for(int i = 0; i < persons.size(); i++){
     PVector p = persons.get(i);
     fill(rcol());
     ellipse(p.x, p.y, 2, 1);
  }



  Collections.sort(persons, new ComparePersons());

  ArrayList<PVector> heads = new ArrayList<PVector>();

  stroke(0, 8);
  noStroke();

  rectMode(CENTER);

  strokeWeight(2);

  for (int i = 0; i < persons.size(); i++) {
    PVector p = persons.get(i);

    float x = p.x;
    float y = p.y;


    float sca = 0.8;

    if (random(1) < 0.1) sca *= random(0.5, 3);
    float hh = random(0.2, 1);

    noStroke();
    fill(0, 8);
    ellipse(x, y, ss*sca, ss*sca*0.3);
    ellipse(x, y, ss*sca*1.8, ss*sca*0.3*1.8);

    int c1 = rcol();
    while (c1 == back) c1 = rcol();
    int c2 = rcol();
    while (c2 == back || c1 == c2) c2 = rcol();

    noStroke();

    int pants = rcol();
    while (pants == back) pants = rcol();

    fill(pants);
    ellipse(x, y-ss*5*hh*sca, ss*sca, ss*6.2*hh*sca);

    float ang = random(TAU);
    stroke(pants);
    line(x+ss*cos(ang)*0.3, y, x+ss*sin(ang)*0.35, y-ss*5*hh*sca);
    line(x+ss*cos(ang+PI)*0.3, y, x+ss*sin(ang+PI)*0.35, y-ss*5*hh*sca);
    noStroke();

    float b1 = ss*sca*0.4;
    float b2 = ss*sca*0.9;
    fill(c1);
    float ww = ss*sca*random(1, 1.2);
    rect(x, y-ss*5.5*hh*sca, ww, ss*5.2*hh*sca, b1, b1, b2, b2);


    fill(c2);
    float hs = random(0.9, 1.8);
    ellipse(x, y-ss*8.2*hh*sca, ss*random(0.10, 0.14)*sca*hs, ss*0.12*sca*hs);


    float handsSize = ss*0.05*sca*hs;
    PVector hand1 = new PVector(x+ss*random(-2.0, 2.0), y-ss*hh*sca*random(4, 10));
    PVector hand2 = new PVector(x+ss*random(-2.2, 2.2), y-ss*hh*sca*random(2, 8));

    PVector shoulder1 = new PVector(x-ww*0.4, y-ss*7.8*hh*sca);
    PVector shoulder2 = new PVector(x+ww*0.4, y-ss*7.8*hh*sca);

    PVector center1 = hand1.copy().add(shoulder1).div(2);
    PVector center2 = hand2.copy().add(shoulder2).div(2);
    float handDis1 = ss*5.2*hh*sca-hand1.dist(shoulder1);
    float handDis2 = ss*5.2*hh*sca-hand2.dist(shoulder2);

    strokeWeight(1);
    noFill();
    //fill(0, 50);
    stroke(c1);  
    curve(hand1.x, hand1.y+handDis1, hand1.x, hand1.y, shoulder1.x, shoulder1.y, shoulder1.x, shoulder1.y+handDis1);
    curve(hand2.x, hand2.y+handDis2, hand2.x, hand2.y, shoulder2.x, shoulder2.y, shoulder2.x, shoulder2.y+handDis1);

    /*
    beginShape();
     vertex(hand2.x, hand2.y);
     vertex(center2.x, center2.y+handDis2*0.5);
     vertex(shoulder2.x, shoulder2.y);
     endShape();
     */

    noStroke();
    fill(c2);
    ellipse(hand1.x, hand1.y, handsSize, handsSize);
    ellipse(hand2.x, hand2.y, handsSize, handsSize);


    /*
    if (random(1) < 0.5) {
     float da = random(-0.04, 0.04);
     fill(30, 50);
     arc(x, y-ss*(8.2+random(0.6))*hh*sca, ss*1.8*sca, ss*1.8*sca*random(0.8, 1.2), PI+da, TAU+da);
     }
     */

    heads.add(new PVector(x, y-ss*8.2*hh*sca));
  }

  strokeWeight(1);



  triangles = Triangulate.triangulate(heads);
  // draw the mesh of triangles
  stroke(0, 14);
  noFill();
  beginShape(TRIANGLES);

  for (int i = 0; i < triangles.size(); i++) {
    if (random(1) < 0.6) continue;
    Triangle t = (Triangle)triangles.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  float des = random(1000);
  float det = random(0.001);

  stroke(#EAFCFF, 60);
  for (int i = 0; i < 600; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(3, 5);
    float a = noise(des+x*det, des+y*det)*PI;
    line(x, y, x+cos(a)*s, y+sin(a)*s);
    point(x+cos(a)*s, y+sin(a)*s);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#E6E7E9, #F0CA4B, #F07148, #EECCCB, #2474AF, #107F40, #231F20};
int colors[] = {#2B00BE, #2B00BE, #F73859, #9896F1, #D59BF6, #EDB1F0};
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

class ComparePersons implements Comparator<PVector>
{
  //@Override
  int compare(PVector v1, PVector v2)
  {
    return int(v1.y - v2.y);
  }
}
