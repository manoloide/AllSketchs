ArrayList formas;
Forma f;

void setup(){
  size(600,600);  
  frameRate(60);
  smooth(); 
  formas = new ArrayList();
  formas.add(new Forma(width/2,height/2));
}

void draw(){
  background(127);
  for(int i=0; i < formas.size();i++){
    Forma f = (Forma) formas.get(i);
    
    f.cambiar();
    f.draw();
  }
}

