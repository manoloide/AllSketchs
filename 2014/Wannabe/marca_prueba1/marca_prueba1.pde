PFont exo;
PShape marca;

void setup(){
   size(1280, 720); 
   marca = loadShape("../marca.svg");
   exo = createFont("Exo Regular", 48, true);
   textFont(exo);
}

void draw(){
  background(#4AFFE0);
  noStroke();
  fill(255, 30);
  rect(0,0,width*0.2+textWidth("loading... "), height);
  fill(255);
  textAlign(LEFT, DOWN);
  float loading = min(frameCount/3, 100);
  text("loading... "+loading+"%", width*0.2, height/3);
  float ww = (textWidth("loading... 100.0%"))*loading/100.;
  fill(255, 120);
  rect(width*0.2,height/3+20, ww, 8);  
  fill(#FFFBCB);
  if(frameCount%30 < 5)
    rect(width*0.2+ww+2,height/3+20, 8, 8); 
  //rect(width/3
  //shape(marca,width/2,height/2);
}
