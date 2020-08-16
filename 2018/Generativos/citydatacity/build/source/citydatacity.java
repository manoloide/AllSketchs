import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class citydatacity extends PApplet {

int seed = PApplet.parseInt(random(999999));

public void setup() {
  
  
  

  generate();
}

public void draw() {
}

public void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = PApplet.parseInt(random(999999));
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

public void generate() {

  randomSeed(seed);

  background(0);

  ArrayList<Rect> rects = new  ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  int sub = PApplet.parseInt(random(1000));
  float max = 20;
  for (int i = 0; i < sub; i++) {
    int ind = PApplet.parseInt(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    float mw = r.w*random(0.3f, 0.7f);
    float mh = r.h*random(0.3f, 0.7f);
    if(mw < max || mh < max || r.w-mw < max || r.h-mh < max) continue;
    rects.add(new Rect(r.x, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y, r.w-mw, mh));
    rects.add(new Rect(r.x+mw, r.y+mh, r.w-mw, r.h-mh));
    rects.add(new Rect(r.x, r.y+mh, mw, r.h-mh));
    rects.remove(ind);
  }


  ArrayList<Rect> rects2 = new ArrayList<Rect>();
  for(int j = 0 ; j < rects.size(); j++){
    Rect r = rects.get(j);
    fill(rcol());
    //ellipse(r.x+r.w*0.5, r.y+r.h*0.5, r.w, r.h);
    rects2.clear();
    rects2.add(new Rect(r.x, r.y, r.w, r.h));
    float max2 = 2;
    float p1 = random(1);
    float p2 = random(1);
    float p3 = random(1);
    float p4 = random(1);
    int sub2 = 3;//int(random(4));
    for(int i = 0; i < sub2; i++){
      int ind = PApplet.parseInt(random(rects2.size()*random(1)));
      Rect r2 = rects2.get(ind);
      float mw = r2.w*random(0.3f, 0.7f);
      float mh = r2.h*random(0.3f, 0.7f);
      if(mw < max2 || mh < max2 || r2.w-mw < max2 || r2.h-mh < max2) continue;
      if(random(1) < p1) rects2.add(new Rect(r2.x,    r2.y,    mw,      mh));
      if(random(1) < p2) rects2.add(new Rect(r2.x+mw, r2.y,    r2.w-mw, mh));
      if(random(1) < p3) rects2.add(new Rect(r2.x+mw, r2.y+mh, r2.w-mw, r2.h-mh));
      if(random(1) < p4) rects2.add(new Rect(r2.x,    r2.y+mh, mw,      r2.h-mh));
      rects2.remove(ind);
    }

    noStroke();
    for(int i = 0; i < rects2.size(); i++){
      Rect r2 = rects2.get(i);
      fill(rcol());
      rect(r2.x, r2.y, r2.w, r2.h);
    }
  }

  /*
  noFill();
  noStroke();
  Rect r;
  for (int i = 0; i < rects.size(); i++) {
    r = rects.get(i);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);
  }
  */
}

public void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

public void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5f;
  float r2 = s2*0.5f;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, PApplet.parseInt(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

//int colors[] = {#EC629E, #E85237, #ED7F26, #C28A17, #114635, #000000};
int colors[] = {0xff34302E, 0xff72574C, 0xff9A4F7D, 0xff488753, 0xffD9BE3A, 0xffD9CF7C, 0xffE2DFDA, 0xffCF4F5C, 0xff368886};
//int colors[] = {#FFFFFF, #000000, #d76280, #f22240};
public int rcol() {
  return colors[PApplet.parseInt(random(colors.length))];
}
public int getColor() {
  return getColor(random(colors.length));
}
public int getColor(float v) {
  v = abs(v);
  v = v%(colors.length);
  int c1 = colors[PApplet.parseInt(v%colors.length)];
  int c2 = colors[PApplet.parseInt((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}
  public void settings() {  size(960, 960, P2D);  smooth(8);  pixelDensity(2); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "citydatacity" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
