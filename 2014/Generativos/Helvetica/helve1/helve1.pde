void setup() {
  size(600, 800);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  textAlign(CENTER,CENTER);
  textFont(loadFont("Helvetica-Bold.vlw"));
  textFont(createFont("Helvetica Bold",90,true));
  for (int i = 0; i < 1000; i++) {
    fill(random(360), random(0,20), 80);
    float x = random(width);
    float y = random(height);
    text("Dormir.", x, y);
  }
  colorMode(RGB,256);
  fill(220);
  textAlign(LEFT,TOP);
  textFont(createFont("Helvetica Bold",128,true));
  for(int i = 0; i < 5; i++){
     text("Dormir.", 30, 30+i*110); 
  }
  rect(0, 0, width, 10);
  rect(0, 0, 10, height);
  rect(width-10, 0, 10, height);
  rect(0, height-30, width, 30);
  saveFrame("dormir");
}
