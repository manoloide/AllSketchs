void setup(){
   size(960, 540);
   
   generate();
}

void draw(){
  
}

void keyPressed(){
   generate(); 
}

void generate(){
  int cc = int(random(2, 6));
  float ss = width*1./cc;
  noStroke();
  for(int i = 0; i < cc; i++){
    
    float r = (random(1) < 0.6)? pow(random(0.5, 1), 0.6) : random(0.1);
    float g = (random(1) < 0.6)? pow(random(0.5, 1), 0.6) : random(0.1);
    float b = (random(1) < 0.6)? pow(random(0.5, 1), 0.6) : random(0.1);
    
    float amp = random(0.5, 1.5);
    
    fill(r*255*amp, g*255*amp, b*255*amp);
    rect(ss*i, 0, ss, height);
  }
}
