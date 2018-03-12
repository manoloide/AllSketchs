void setup(){
  size(400,400); 
  
}
void draw(){
  for(int xp = 0; xp < 40; xp++){
    for (int yp = 0; yp <40; yp++){
      noStroke();
      fill(random(255),random(255),random(255));
      rect(xp*10,yp*10,10,10); 
     }
  } 
  
}
