ColorRamp cr;
int seed;
PImage textures[];
PShader post;

void setup() {
  size(640, 640, P2D);
  smooth(8);
  cr = new ColorRamp();
  cr.addColor(#FF0C3A, 0.5, true);
  cr.addColor(#11A8FF, 0.62, true);
  cr.addColor(#17FC78, 0.76, false);
  cr.addColor(#FFE617, 1.0, true);
  post = loadShader("post.glsl");
  post.set("resolution", float(width), float(height));

  generate();
  createTextures();
}


void draw() {
  post.set("time", millis()/1000.);

  if(frameCount%120 == 0){
    //generate();
  }

  noiseSeed(seed);
  randomSeed(seed);

  background(6);

  stroke(10);
  strokeWeight(1);
  grid(0, 0, width, height, 32, 32);
  stroke(14);
  grid(0, 0, width, height, 16, 16);
/*
  tint(cr.getColor(random(1)));
  image(textures[(frameCount/120)%textures.length], 0, 0);
  noTint();
  */
  //blendMode(BLEND);

  for(int i = 0; i < random(2, 8); i++){
    float xx = width/2; 
    float yy = height/2; 
    float s = width*random(0.2, 0.8);
    float r = random(1.9);
    if(r < 1){
      strokeWeight(random(0.5, 5));
      stroke(cr.getColor(random(1)));
      noFill();
      ellipse(xx, yy, s, s);
    }
    else if(r < 1.4){
      noStroke();
      fill(cr.getColor(random(1)));
      float v = random(-0.01, 0.01);
      circleCircles(xx, yy, s*0.5, random(1, 4), frameCount*v, int(random(2, 10)), int(random(1, 6)), int(random(0, 6)));
    }
    else {
      float v = random(-0.005, 0.005);
      stroke(cr.getColor(random(1)));
      strokeWeight(random(0.5, 2.5));
      circleLines(xx, yy, s*0.5, s*0.5+random(2, 18), int(random(4, 40)), random(1), frameCount*v);
    }
  }

  {
    color c = cr.getColor(random(1)); 
    tint(c);
    float x = width/2;
    float y = height/2; 
    float r1 = width*random(0.1, 0.3);
    float r2 = r1*random(1.08, 1.6);
    float v = random(-0.01, 0.01);
    arcTex(x, y, r1, r2, 0, TWO_PI, frameCount*v, 60, textures[int(random(textures.length))]);
    noTint();
    stroke(c);
    noFill();
    strokeWeight(random(1, 5));
    ellipse(x, y, r2*2, r2*2);
  }

  if(random(1) < 0.7){
    int cc = int(random(1, 10));
    float h = random(3, random(6, 12));
    float w = h*random(3, 6);
    float sx = width*random(0.05, 0.38);
    float sh = h*random(1.8, 4.6);
    float dy = height/2-sh*((cc-1)/2.);
    rectMode(CENTER);
    noStroke();
    fill(cr.getColor(random(1)));
    for(int i = 0; i < cc; i++){
      rect(width/2-sx, dy+sh*i, w, h, 1);
      rect(width/2+sx, dy+sh*i, w, h, 1);
    }

  }

  for(int i = 0; i < int(random(-3, 8)); i++){
    float ang = random(TWO_PI);
    float d = width*random(0.4);
    float x = width/2+cos(ang)*d;
    float y = height/2+sin(ang)*d;
    float s = random(18, 48);
    stroke(cr.getColor(random(1)));
    noFill();
    icon(x, y, s, int(random(4)));
  }

  for(int i = 0; i < int(random(-4, 4)); i++){
    float ang = random(TWO_PI);
    float dist = width*random(0.04, 0.38);
    float x = width/2+cos(ang)*dist;
    float y = height/2+sin(ang)*dist;
    float w = 40;
    float h = 20;
    boolean l = (width/2 < x)? true : false;
    strokeWeight(2);
    noFill();
    marker(x, y, w, h, l);
  }

  filter(post);
  
  //cr.show(20, 20, width-40, 30);
  
}

void arcTex(float x, float y, float r1, float r2, float a1, float a2, float a, int res, PImage tex){
  float da = (a2-a1)/res;
  beginShape();
  texture(tex);
  noStroke();
  for(int i = 0; i <= res; i++){
    float ang = a1+da*i;
    float xx = x+cos(ang)*r2;
    float yy = y+sin(ang)*r2;
    vertex(x+cos(a+ang)*r2, y+sin(a+ang)*r2, xx, yy);
  }
  for(int i = 0; i <= res; i++){
    float ang = a1+da*i;
    float xx = x+cos(ang)*r1;
    float yy = y+sin(ang)*r1;
    vertex(x+cos(a+ang)*r1, y+sin(a+ang)*r1, xx, yy);
  }
  endShape(CLOSE);
}

void circleCircles(float x, float y, float s, float t, float a, int c, int cc, int sep){
  int ccc = int(c*(cc+sep));
  float da = TWO_PI/ccc;
  for(int i = 0; i < ccc; i++){
    if(i%(cc+sep) < cc){
      float ang = da*i+a;
      ellipse(x+cos(ang)*s, y+sin(ang)*s, t, t);
    }
  }
}

void circleLines(float x, float y, float s1, float s2, int c, float amp, float a){
  float da = TWO_PI/c;
  strokeCap(SQUARE);
  for(int i = 0; i < c; i++){
    float ang = da*i+a;
    line(x+cos(ang)*s1, y+sin(ang)*s1, x+cos(ang)*s2, y+sin(ang)*s2);
  }
}

void croos(float x, float y, float s, float r, float a){
  float da = TWO_PI/4;
  float ss = s*0.5*r;
  float diag = dist(0, 0, ss, ss);
  beginShape();
  for(int i = 0; i < 4; i++){
    float ang = a+da*i;
    float a1 = ang+HALF_PI;
    float dx = cos(ang)*s; 
    float dy = sin(ang)*s;
    vertex(x+dx-cos(a1)*ss, y+dy-sin(a1)*ss);
    vertex(x+dx, y+dy);
    vertex(x+dx+cos(a1)*ss, y+dy+sin(a1)*ss);
    vertex(x+cos(ang+PI/4.)*diag, y+sin(ang+PI/4.)*diag);
  }
  endShape(CLOSE);
}

void grid(float x, float y, float w, float h, int cw, int ch){
  float dw = w/cw;
  float dh = h/ch;
  for(int i = 0; i < cw; i++){
    line(x+i*dw, y, x+i*dw, y+h);
  }
  for(int j = 0; j < ch; j++){
    line(x, y+j*dh, x+w, y+j*dh);
  }
  
}

void icon(float x, float y, float s, int v){
    strokeWeight(s*0.08);
    ellipse(x, y, s, s);
    if(v == 0){
      int c = 4; 
      float a = HALF_PI/2*int(random(2));
      float da = TWO_PI/c;
      float r1 = s*0.64;
      float r2 = s*0.4;
      strokeWeight(s*0.04);
      for(int i = 0; i < c; i++){
        float ang = a+da*i;
        line(x+cos(ang)*r1, y+sin(ang)*r1, x+cos(ang)*r2, y+sin(ang)*r2);
      }
    }else if (v == 1){
      fill(g.strokeColor);
      noStroke();
      croos(x, y, s*0.28, 0.7*random(0.6, 1), PI/4);
    }else {
      int cc = int(random(2, 5));
      float r = s/(cc);
      for(int i = 1; i < cc; i++){
        strokeWeight(s*map(i, 0, cc, 0.03, 0.07));
        ellipse(x, y, r*i, r*i);
      }
    }
}

void marker(float x, float y, float w, float h, boolean l){
  beginShape();
  vertex(x-w/2, y-h/2);
  vertex(x+w/2, y-h/2);
  if(!l)vertex(x+w/2+h/3, y);
  vertex(x+w/2, y+h/2);
  vertex(x-w/2, y+h/2);
  if(l)vertex(x-w/2-h/3, y);
  endShape(CLOSE);
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  seed = int(random(99999999)+frameCount);
  //createTextures();
}

void createTextures(){
  textures = new PImage[12];
  float diag = dist(0, 0, width, height);
  for(int i = 0; i < textures.length; i++){
    PGraphics gra = createGraphics(width, height);
    gra.beginDraw();
    float r = random(2);
    if(r < 0.8){
      float t = random(2, 14)*random(0.5, random(1));
      float s = t*random(1.5, 12);
      float amp = (random(1) < 0.5)? random(1) : 1;
      int cc = int((diag/2)/s)+1;
      gra.translate(width/2, height/2);
      if(random(1) > 0.5)
        gra.rotate(random(TWO_PI));
      gra.noStroke();
      gra.fill(255);
      for(int yy = -cc; yy <= cc; yy++){
        for(int xx = -cc; xx <= cc; xx++){
          float tt = t;
          if((xx+yy)%2 == 0) tt *= amp;
          gra.ellipse(xx*s, yy*s, tt, tt);
        }
      }
    }
    else {
      float s = random(3, 28);
      int cc = int((diag/2)/s)+1;
      gra.translate(width/2, height/2);
      if(random(1) > 0.5)
        gra.rotate(random(TWO_PI));
      gra.stroke(255);
      gra.strokeWeight(random(1, 2.5));
      for(int xx = -cc; xx <= cc; xx++){
        gra.line(xx*s, -diag/2, xx*s, diag/2);
      }
      if(random(1) < 0.5){
        for(int yy = -cc; yy <= cc; yy++){
          gra.line(-diag/2, yy*s, diag/2, yy*s);
        }
      }
    }
    gra.endDraw();
    textures[i] = gra.get();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

class Color {
  color col;
  float pos;
  boolean solid;
  Color (int col, float pos, boolean solid) {
    this.col = color(col);
    this.pos = pos;
    this.solid = solid;
  }
  Color (int col, float pos) {
    this(col, pos, false);
  }
}

class ColorRamp {
  ArrayList<Color> colors;
  ColorRamp () {
    colors = new ArrayList<Color>();
  }

  void addColor(int c, float p, boolean s){
    p = constrain(p, 0, 1);
    int ind = 0;
    for(int i = 0; i < colors.size(); i++){
      ind = i;
      if(p >= colors.get(i).pos){
        break;
      }
    }
    colors.add(ind, new Color(c, p, s));
  }

  void addColor(int c, float p){
    addColor(c, p, false);
  }

  color getColor(float p){
    p = constrain(p, 0, 1);
    color col = color(0);

    if(colors.size() > 0){
      col = colors.get(colors.size()-1).col;
    } 
    

    for(int i = 1; i < colors.size(); i++){
      if(p >= colors.get(i).pos){
        Color ant = colors.get(i-1);
        Color act = colors.get(i);
        if(ant.solid) col = ant.col;
        else col = lerpColor(ant.col, act.col, map(p, ant.pos, act.pos, 0, 1));
        break;
      }
    }
    return col;
  }

  void show(float x, float y, float w, float h){
    for(int i = 0; i < w; i++){
      stroke(getColor(i*1./w));
      line(x+i, y, x+i, y+h);
    }
  }

}

