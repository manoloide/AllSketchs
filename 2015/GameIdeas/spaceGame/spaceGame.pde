/*
Scenes: 
- intro
- menu
- ingame
- result
- store
- missions
*/

Controller controller;
Stars stars;

float x, y;

void setup(){
  
  orientation(PORTRAIT);
  smooth();
  controller = new Controller();
  stars = new Stars();
  
  x = width/2;  //<>//
  y = height/2;
}

void draw(){
  
  background(#131114);
  stars.update();
  
  x += controller.stick.vx*4;
  y += controller.stick.vy*4;
  
  ellipse(x, y, 48, 48);
  
  controller.update();
  
}