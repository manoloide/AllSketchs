void sun(ArrayList<PVector> rects) {

  //background(0);

  int sun = color(#ff335f);//color(255, 35, 85);
  float sx = width*0.5;
  float sy = height*0.5;
  /*
  for (int i = 0; i < rects.size(); i++) {
   PVector r = rects.get(i);
   if (random(1) < 0.4) continue;
   beginShape(LINES);
   strokeWeight(2);
   stroke(sun, 150);
   vertex(sx, sy);
   strokeWeight(1);
   stroke(255, 20);
   vertex(r.x+r.z*0.5, r.y+r.z*0.5);
   endShape();
   }
   */


  noStroke();
  stroke(#FF5B7F);
  fill(sun);
  ellipse(sx, sy, width*0.3, height*0.3);
  noStroke();
  arc2(sx, sy, width*0.3, height*0.4, PI*0.0, TAU, sun, 50, 0);
  //arc2(sx, sy, width*0.3, height*0.4, PI*0.0, TAU, color(255), 30, 0);
  arc2(sx, sy, width*0.3, height*0.32, PI*0.0, TAU, sun, 20, 0);
  arc2(sx, sy, width*0.3, height*0.2, PI*0.0, TAU, color(255), 30, 0);
  arc2(sx, sy, width*0.29, height*0.24, PI*0.0, TAU, color(255), 26, 0);


  /*
  int pink = #F582DA;
   float s = width*0.02;
   noFill();
   stroke(pink, 80);
   float det = random(0.1);
   
   for (int j = 0; j < 10; j++) {
   float aa = random(TAU);
   float xx = sx+cos(aa)*s*0.5;
   float yy = sy+sin(aa)*s*0.5;
   float ia = noise(xx*det, yy*det);
   beginShape();
   for (int i = 0; i < 400; i++) {//random(200, 1000); i++) {
   vertex(xx, yy);
   aa += ((noise(xx*det, yy*det)-ia)*2-1)*HALF_PI;
   xx += cos(aa)*20;
   yy += sin(aa)*20;
   }
   endShape();
   }
   */

  /*
  noStroke();
   fill(pink, 180);
   ellipse(sx, sy, s*1.1, s*1.1);
   ellipse(sx, sy, s, s);
   */

  for (int k = 0; k < 50; k++) {
    float a2 = PI*random(0.2 )*random(1)*random(1);
    float a1 = random(PI, TAU-a2);
    a2 = a1+a2;
    float s1 = width*0.3+1;
    float s2 = s1*random(1.05, random(1.2, 4.4));
    arc2(width*0.5, height*0.5, s1, s2, a1, a2, color(255), random(80, 140)*random(1), 0);
  }
}
