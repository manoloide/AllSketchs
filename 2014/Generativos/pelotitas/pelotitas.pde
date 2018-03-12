int paleta[] = {
  #F20765, #3F3E3C, #C2C5BC, #AADECB, #F9F0D3
};

void setup() {
  size(600, 800);
  generar();
}

void draw(){}

void keyPressed(){
  if(key == 's') saveImage();
  else generar();
}

void generar(){
  background(paleta[4]);
  lineas(random(4,18));
  noisee();
  noStroke();
  /*
  for (int i = 0; i < 80; i++) {
    float x = random(width);
    float y = random(height);
    float dis = dist(width/2, height/2, x, y);
    float tam = random(50, 520);

    stroke(0, 5);
    noFill();
    for(int j = 1; j < 5; j++){
      strokeWeight(tam/30+j);
      ellipse(x, y, tam, tam);
    }

    logo(x, y, tam);
  }
  */

  float tam = random(10, width-40);
  float bb = tam*random(0.1,0.2);
  float cw = width/(tam+bb)-1;
  float ch = height/(tam+bb)-1;
  for(int j = -int(ch/2); j < ch/2; j++){
    for(int i = -int(cw/2); i < cw/2; i++){
      float x = width/2+(tam+bb)*i;
      float y = height/2+(tam+bb)*j;
      logo(x, y, tam);
    }
  }
}

void logo(float x, float y, float tam){
  int ccuer = rcol();
  int cs = rcol();
  while(ccuer == cs){
    cs = rcol();
  }
  int ca = rcol();
  while(ca == ccuer || ca == cs){
    ca = rcol();
  }


  strokeWeight(tam/30);
  stroke(ca);
  fill(ccuer);
  ellipse(x, y, tam, tam);


  strokeWeight(tam/30);
  strokeCap(SQUARE);
  stroke(cs);
  fill(ca);

  ArrayList<PVector> puntos = new ArrayList<PVector>();
  puntos.add(new PVector(x-tam*0.25,y-tam*0.25));
  puntos.add(new PVector(x+tam*0.25,y-tam*0.25));
  puntos.add(new PVector(x+tam*0.25,y+tam*0.25));
  puntos.add(new PVector(x-tam*0.25,y+tam*0.25));
  puntos.add(new PVector(x,y));
  int cant = int(random(2, 6));
  beginShape();
  for(int i = 0; i < cant; i++){
    int p = int(random(puntos.size()));
    vertex(puntos.get(p).x, puntos.get(p).y);
    puntos.remove(p--);
  }
  endShape();
}

void lineas(float tt){
  stroke(rcol(), 50);
  strokeWeight(1);
  float diag = dist(0,0,width, height)*2;
  for(float i = -int(random(tt)); i < diag; i+=tt){
    line(-2, i, i, -2);
  }
}

void noisee(){
  for (int j = 0; j<height; j++){
    for (int i = 0; i<width; i++){
      color col = get(i,j);
      float bri = random(5);
      set(i, j, color(red(col)+bri, green(col)+bri, blue(col)+bri));
    }
  }
}
int rcol() {
  float r = random(100);
  int col = 0;
  if (r < 8) {
    col = paleta[0];
  } 
  else if (r < 40) {
    col = paleta[1];
  } 
  else if (r < 75) {
    col = paleta[2];
  } 
  else {
    col = paleta[3];
  }
  return col;
}

void saveImage(){
  File f = new File(sketchPath);
  int num = f.listFiles().length-1;
  saveFrame(num+".png");
}