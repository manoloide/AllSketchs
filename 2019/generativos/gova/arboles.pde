void arboles(){
  

  fill(#220F0F);
  int cc = 70;
  for (int i = 0; i < cc; i++) {
    float x = random(width*random(1)*0.03, width);
    float y = height*(0.78+random(0, 0.22)*random(1)*random(0.3, 1)*random(0.5, 1));

    float w = random(1, 5);
    float mh = pow(map(x, 0, width, 1, 0.3), 1.2);
    float h = height*random(lerp(0.1, 0.5, map(i, 0, cc, 1, 0)), 0.62)*mh*1.3;

    fill(0);
    //rect(x, y-h*0.5, w, h);
    
    fill(255);
    arbol(x, y, x, y-h, 8);
  }
  
}

void arbol(float x1, float y1, float x2, float y2, int sub){ 
  float ax = x1;
  float ay = y1;
  for(int i = 0; i < sub; i++){
    float mix = map(i, 0, sub-1, 0, 1);
    mix = pow(mix, 0.5);
    float x = lerp(x1, x2, mix)+random(-4, 4);
    float y = lerp(y1, y2, mix)+random(-4, 4);
    if(i > 0){
      stroke(0);
       line(ax, ay, x, y); 
    }
    ax = x;
    ay = y;
    ellipse(x, y, 4, 4);
    rect(x, y, 20*(1-mix), 1);
  }
}

void rama(float x1, float y1, float x2, float y2, int sub){ 
  for(int i = 0; i < sub; i++){
    float mix = map(i, 0, sub-1, 0, 1);
    mix = pow(mix, 0.5);
    float x = lerp(x1, x2, mix);
    float y = lerp(y1, y2, mix);
    ellipse(x, y, 4, 4);
    rect(x, y, 20, 1);
  }
}
