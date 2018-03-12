void setup() {
  size(640, 640);
}

void draw() {
  background(0);
  float time = millis()/10000.;
  time = time%2;
  ellipse(cycle(time, 0.25, 0.75)*width, height*0.2, 5, 5); 
  ellipse(cycle(time, 0.75, 0.25)*width, height*0.3, 5, 5);  
  ellipse(cycle(time, 0, 0.5)*width, height*0.4, 5, 5);  
  ellipse(cycle(time, 0.5, 0.0)*width, height*0.5, 5, 5); 
  ellipse((cycle(time, -0.25, 0.25)+0.5)*width, height*0.6, 5, 5); 
  ellipse((cycle(time, 0.25, -0.25)+0.5)*width, height*0.7, 5, 5); 
  ellipse(cycle(time, 0, 1)*width, height*0.8, 5, 5);
  ellipse(cycle(time, 1, 0)*width, height*0.9, 5, 5);
}

float cycle(float v, float l1, float l2) {
  if(l1 < l2) return (v-l1)%(l2-l1);
  return (v-l2)%(l1-l2);
}