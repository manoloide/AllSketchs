
int paleta[] = {
  #FCFCFF, 
  #E2E2E2, 
  #373846, 
  #FF655F, 
  #3CDEB4, 
  #2ED148
};
/*
enum Scene {
 MENU, INGAME
 };
 Scene scene;
 */

void setup() {
  //size(270, 480);
  size(800, 800);
  generar();
}

void draw() {
  /*
  background(252);
   fill(paleta[3+(frameCount/300)%3]);
   loader(width/2, height/2, 180, (frameCount/300.)%1);
   bar(20, 20, 20+width-40, 20, 12, (frameCount/400.)%1);
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  background(252);
  for(int i = 0; i < 1000; i++){
     float xx = random(width); 
     float yy = random(height);
     float s = random(10, 380)*random(1);
     fill(paleta[3+int(random(3))]);
     if(random(100) < 80){
       loader(xx, yy, s, random(1));
     }else{
        bar(xx-s/2, yy, xx+s/2, yy, s*random(0.04, 0.12), random(1)); 
     }
  }
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 3)+".png");
}

void bar(float x1, float y1, float x2, float y2, float s, float c) {
  color cl = g.fillColor;
  pushStyle();
  strokeWeight(s);
  stroke(paleta[1]);
  line(x1, y1, x2, y2);
  stroke(cl);
  float dx = (x2-x1)*c;
  float dy = (y2-y1)*c;
  line(x1, y1, x1+dx, y1+dy);
  popStyle();
}

void loader(float x, float y, float s, float c) {
  color cl = g.fillColor;
  pushStyle();
  noStroke();
  fill(226);
  ellipse(x, y, s, s);
  fill(cl);
  arc(x, y, s, s, PI*1.5, PI*(1.5+c*2));
  fill(0, 18);
  ellipse(x, y, s*0.69, s*0.69);
  fill(#373846);
  ellipse(x, y, s*0.6, s*0.6);
  popStyle();
}

