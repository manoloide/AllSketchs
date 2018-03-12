void setup(){
   size(600,600);
}

void draw(){
  background(0);
  for(int i = 0; i < 100; i++){
    linea();
  }
  
  
}
void linea(){
  
  stroke(random(255),random(255),random(255));
  line(random(600),random(600),random(600),random(600));
  
}
