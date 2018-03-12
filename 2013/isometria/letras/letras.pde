int letras [][] = {{
    0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},{
    1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0},{
    1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0},{
    1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0},{
    1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0},{
    1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0},{
    1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0
  }
};


int count = 0;
int posx = 0;
int posy = 0;
float tam = 20;
float h = sqrt(pow(tam/2, 2)-pow(tam/4, 2))*2;
float h2 = tam*0.5;
void setup() {
  size(800, 600);
  colorMode(HSB);
  noStroke();
  background(0);
}

void draw() {
  if (count == 0) {
    posx = int(random(80)*(h /2));
    posy = int(random(65)*(h2));
    count = int(random(3,6));
  }
  count--;
  //background(30, 26, 40);
  color col = color((count*5+frameCount*2)%256, 256, 220); 
  for (int j = letras.length-1; j >= 0 ; j--) {  
    for (int i = letras[0].length-1; i >= 0 ; i--) {
      float x = (i) *(h /2); 
      float y = (j)*(h2)-(i*h2/2);
      if ((y/h2)%2 == 0) {
        //x += h/2;
      }
      if (letras[j][i] == 1) {
        cubo(x+posx-(h /2)*count, y+posy-h2/2*count, tam, col);
      }
    }
  }
}

void mousePressed(){
   saveFrame("asdasd####.png"); 
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
  fill(hue(col), saturation(col)+10, brightness(col)+20);
  quad(x, y, x+cos(a*0+d)*tam, y+sin(a*0+d)*tam, x+cos(a*1+d)*tam, y+sin(a*1+d)*tam, x+cos(a*2+d)*tam, y+sin(a*2+d)*tam);
  fill(col);
  quad(x, y, x+cos(a*2+d)*tam, y+sin(a*2+d)*tam, x+cos(a*3+d)*tam, y+sin(a*3+d)*tam, x+cos(a*4+d)*tam, y+sin(a*4+d)*tam);
  fill(hue(col), saturation(col)+10, brightness(col)-20);
  quad(x, y, x+cos(a*4+d)*tam, y+sin(a*4+d)*tam, x+cos(a*5+d)*tam, y+sin(a*5+d)*tam, x+cos(d)*tam, y+sin(d)*tam);
  popStyle();
}

void iprisma(float x, float y, float w, float h, float d) {
}

