import org.processing.wiki.triangulate.*;

import java.util.*;

ArrayList<Person> persons;
ArrayList<PVector> personsPositions, headsPositions, threes;
ArrayList trianglesPositions, trianglesHeads;

int seed = int(random(999999));
float time = 0;

int backColor;
int gridCount;
float gridSize;



void setup() {
  size(720, 720, P2D);
  smooth(8);
  pixelDensity(2);   
  rectMode(CENTER);
  generate();
}

void draw() {

  noiseSeed(seed);

  time = millis()*0.001;
  background(backColor);

  stroke(255, 12);
  for (int i = 0; i <= gridCount; i++) {
    line(i*gridSize, 0, i*gridSize, height);
    line(width, i*gridSize, 0, i*gridSize);
  }

  Collections.sort(persons, new ComparePersons());

  for (int i = 0; i < persons.size(); i++) {
    Person p = persons.get(i);
    p.update();
    p.show();
    //p.showSkeleton();
  }
  
  //rain();

  println(frameRate);
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

  backColor = rcol();
  while (backColor == #2b00be) backColor = rcol();

  gridCount = int(random(40, 60)*0.5);
  gridSize = width*1./gridCount;

  personsPositions = new  ArrayList<PVector>();
  headsPositions = new  ArrayList<PVector>();

  createThrees();

  int countPersons = int(gridCount*1.6);

  persons = new ArrayList<Person>();

  noStroke();
  noFill();
  for (int i = 0; i < countPersons; i++) {
    Person person = new Person();

    boolean add = true;
    for (int j = 0; j < persons.size(); j++) {
      Person other = persons.get(j);
      if (person.position.dist(other.position) < 5) {
        add = false;
        break;
      }
    }

    /*
    for (int j = 0; j < threes.size(); j++) {
     PVector three = threes.get(j);
     if (dist(person.position.x, person.position.y*3, three.x, three.y*3) < three.z*0.5) {
     add = false;
     break;
     }
     }
     */

    if (add) persons.add(person);
  }

  /*
  trianglesPositions = Triangulate.triangulate(personsPositions);
   stroke(0, 28);
   drawTriangles(trianglesPositions);
   */


  noStroke();


  for (int i = 0; i < persons.size(); i++) {
    Person p = persons.get(i);
    fill(rcol());
    ellipse(p.position.x, p.position.y, 2, 1);
  }

  headsPositions = new ArrayList<PVector>();


  /*
  trianglesHeads = Triangulate.triangulate(headsPositions);
   stroke(255, 20);
   noFill();
   drawTriangles(trianglesHeads);
   */

  //rain();
}

void drawTriangles(ArrayList triangles) {
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

void  createThrees() {
  threes = new ArrayList<PVector>();
  /*
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
   */
}

void rain() {
  float des = random(1000);
  float det = random(0.001);

  stroke(#EAFCFF, 60);
  for (int i = 0; i < 400; i++) {
    float x = random(width);
    float y = random(height);
    x += time*random(-0.1, 0.1)*600;
    y += time*random(0.05, 0.1)*600;

    x %= width;
    y %= height;
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

class ComparePersons implements Comparator<Person>
{
  //@Override
  int compare(Person v1, Person v2)
  {
    return int(v1.position.y - v2.position.y);
  }
}
