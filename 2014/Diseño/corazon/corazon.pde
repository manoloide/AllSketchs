/* 
-agregar moviimiento camara suavizado
-agregar demas objetos en la ubicacion correcta
-re acomodar todo
*/


color paleta[];
float camaraX, camaraY;
PFont pcanter, pflex, plight;

void setup() {
  size(600, 800);
  smooth(8);
  plight = loadFont("light.vlw");
  pcanter = loadFont("canter.vlw");
  pflex = loadFont("flex.vlw");
  paleta = new color[5];
  paleta[0] = color(#433E3E);
  paleta[1] = color(#FF4D4D);
  paleta[2] = color(#313030);
}

void draw() {
  //camaraX += (width/2-mouseX)/100.;
  //camaraY += (height/2-mouseY)/100.;
  translate(camaraX ,camaraY);
  background(paleta[0]);

  float x = width/2;
  float y = height/2;
  noStroke();
  fill(paleta[1]);
  ellipse(x, y, 220, 220);
  fill(paleta[2]);
  ellipse(x, y, 200, 200);
  stroke(#FBFBFB, 200);
  noFill();
  int cant = 100;
  float da = TWO_PI/cant;
  for (int i = 0; i < cant; i++) {
    if (random(100) > 2) {
      line(x+cos(da*i)*70, y+sin(da*i)*70, x+cos(da*i)*90, y+sin(da*i)*90);
    }
    else {
      float dist = random(140, 280);
      line(x+cos(da*i)*70, y+sin(da*i)*70, x+cos(da*i)*dist, y+sin(da*i)*dist);
      ellipse(x+cos(da*i)*(dist+5), y+sin(da*i)*(dist+5), 8, 8);
    }
  }
  textFont(plight, 30);
  textAlign(CENTER, CENTER);
  noStroke();
  fill(#FBFBFB);
  text("CORAZON", x, y);
}
