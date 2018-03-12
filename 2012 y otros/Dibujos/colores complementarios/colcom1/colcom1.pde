int col;
void setup() {
  size(600, 600); 
  colorMode(HSB);
  smooth();
  noStroke();
  iniciar();
}

void draw() {
  fill((col+128)%256,255,255,1);
  rect(0,0,width,height);
  float grosor = random(20,100);
  fill(color(col,200,random(100,180)));
  ellipse(mouseX,mouseY,grosor,grosor);
  col += int(random(-1,2));
  col = col%256;
}

void keyPressed(){
   if(key == 'r'){
      iniciar();
   } 
}

void iniciar(){
  col = int(random(256));
  background((col+128)%256,255,255);
}
