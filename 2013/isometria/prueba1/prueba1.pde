float tam = 60;
void setup() {
  size(800 , 600);
  colorMode(HSB,256);
  noStroke();
  background(0);
}

void draw() {
  float h = sqrt(pow(tam/2,2)-pow(tam/4,2))*2;
  float x = int(random((width/h)+1))*h;
  float h2 = tam*0.75;
  float y = int(random((height/h2)+1))*h2;
  if((y/h2)%2 == 0){
     x += h/2; 
  }
  color col = color(random(255), random(100,250), 255); 
  cubo(x, y, tam, col);
}

void mousePressed(){
   saveFrame("asda###.png"); 
}

void cubo(float x, float y, float tam, color col) {
  tam = tam/2;
  float a = TWO_PI/6;
  float d = TWO_PI/12+PI;
  pushStyle();
  colorMode(HSB);
  noStroke();
  //strokeWeight(2);
  //stroke(col);
  //stroke(255);
  //stroke(hue(col), saturation(col)+5, brightness(col)+15);
  fill(hue(col), saturation(col)+5, brightness(col)+12);
  quad(x, y, x+cos(a*0+d)*tam, y+sin(a*0+d)*tam, x+cos(a*1+d)*tam, y+sin(a*1+d)*tam, x+cos(a*2+d)*tam, y+sin(a*2+d)*tam);
  fill(col);
  quad(x, y, x+cos(a*2+d)*tam, y+sin(a*2+d)*tam, x+cos(a*3+d)*tam, y+sin(a*3+d)*tam, x+cos(a*4+d)*tam, y+sin(a*4+d)*tam);
  fill(hue(col), saturation(col)+5, brightness(col)-12);
  quad(x, y, x+cos(a*4+d)*tam, y+sin(a*4+d)*tam, x+cos(a*5+d)*tam, y+sin(a*5+d)*tam, x+cos(d)*tam, y+sin(d)*tam);
  popStyle();
}

void iprisma(float x, float y, float w, float h, float d) {
}

