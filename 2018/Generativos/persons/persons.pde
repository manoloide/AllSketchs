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

  ArrayList<PVector> persons = new ArrayList<PVector>();

  noStroke();
  noFill();
  for (int i = 0; i < grid*2; i++) {
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

    if (add) persons.add(person);
  }

  ArrayList triangles = Triangulate.triangulate(persons);

  stroke(255, 30);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    if (random(1) < 0.6) continue;
    Triangle t = (Triangle)triangles.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();



  Collections.sort(persons, new ComparePersons());

  ArrayList<PVector> heads = new ArrayList<PVector>();

  stroke(0, 8);
  noStroke();
  for (int i = 0; i < persons.size(); i++) {
    PVector p = persons.get(i);

    float x = p.x;
    float y = p.y;


    float sca = 0.8;
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
    fill(c1);
    ellipse(x, y-ss*5*hh*sca, ss*sca, ss*6.2*hh*sca);
    

    fill(c2);
    ellipse(x, y-ss*8.2*hh*sca, ss*0.2*sca, ss*0.2*sca);
    
    float ang = random(TAU);
    
    stroke(c1);
    line(x+ss*cos(ang)*0.3, y, x+ss*sin(ang)*0.35, y-ss*5*hh*sca);
    line(x+ss*cos(ang+PI)*0.3, y, x+ss*sin(ang+PI)*0.35, y-ss*5*hh*sca);

    heads.add(new PVector(x, y-ss*8.2*hh*sca));
  }



  triangles = Triangulate.triangulate(heads);
  // draw the mesh of triangles
  stroke(0, 10);
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
