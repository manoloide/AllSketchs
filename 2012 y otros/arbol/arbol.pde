void setup(){
  size(600,600);
  arbol(300,500,150,270,10);
}

void draw(){
  
}

void arbol(float x, float y, float lar,float ang,int v){
  float x1 = x + lar * cos(radians(ang));
  float y1 = y + lar * sin(radians(ang));
  strokeWeight(v/1.5);
  line(x,y,x1,y1);
  if (v > 1){
     lar /= random(10,30)/10;
     arbol(x1,y1,lar,ang-random(10,40),v-1);
     arbol(x1,y1,lar,ang+random(10,40),v-1);
  }
}
