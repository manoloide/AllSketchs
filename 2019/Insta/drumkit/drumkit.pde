int seed = int(random(9999999));

int v = int(random(9999999));

void setup(){
   size(960, 960, P2D); 
   rectMode(CENTER);
   
   generate();
}

void draw(){
  
  background(8);
  
  drumPattern();
  
}

void generate(){
   seed = int(random(9999999)); 
   
   randomSeed(seed);
   
   float cc = 4; 
   
   for(int i = 0; i < 100; i++){ 
   }
}
