import manoloide.Color.Paleta;

Paleta paleta;

void setup() {
  size(800, 800);
  background(255);
  paleta = new Paleta();
  paleta.load(sketchPath("flores.plt"));
  thread("generar");
}

void draw() {
}

void keyPressed() {
  if ( key == 's') saveFrame("######"); 
  else thread("generar");
}

void generar() {
  noStroke();
  fill(255,80);
  //rect(0,0,width,height);
  int cant = int(random(3, 10));
  float ang = random(TWO_PI);
  float tam = random(40, width*0.9);
  float dis = tam*random(0.5, 1.1);
  float da = TWO_PI/cant;
  color c1 = color(random(100, 256), random(100, 256), random(100, 256), random(10, 50));
  color c2 = color(random(100, 256), random(100, 256), random(100, 256), random(10, 50)); 
  //c1 = color(paleta.rcol());
  for (int r = 0; r < 1; r++) {
    for (int i = 0; i < cant; i++) {
      int cc = int(random(10, 40));
      for (int j = 0; j < cc; j++) {
        float t = dis*(1-(j*1./cc));
        float x = width/2;
        x += cos(ang+da*i)*t;
        float y = height/2;
        y += sin(ang+da*i)*t;
        fill(c1);
        fill(lerpColor(c1, c2, j*1./cc));
        ellipse(x, y, t, t);
        fill(random(100, 256), random(100, 256), random(100, 256), 200);
        //fill(paleta.rcol(), 200);
        //fill(c2);
        int cc2 = int(random(3, 14));
        float des = t/2*random(0.2, 0.8);
        float tt = t/2*random(0.01, 0.2);
        float da2 = TWO_PI/cc2;
        for (int k = 0; k < cc2; k++) {
          //ellipse(x+cos(da2*k)*des, y+sin(da2*k)*des, tt, tt);
        }
      }
    }
  }
}
