void setup(){
  size(400,400);
  background(0);
  smooth();
  circulo(200,200,150,10);
  
}

void circulo(float x, float y, float r, float v){
  noFill();
  float vari = 255/v;
  for(int i = 1; i <= v; i++){
    strokeWeight(i);
    
    stroke(250,180,0,10);
    ellipse(x,y,r,r); 
  }
}
