void personitas(int cc, float ss) {
  for (int i = 0; i < 600; i++) {
    float xx = random(-cc*0.5*ss, cc*0.5*ss)*1;
    float yy = random(-cc*0.5*ss, cc*0.5*ss)*1;
    if (abs(xx) < (cc-1.5)*0.5*ss && abs(yy) < (cc-1.5)*0.5*ss) continue;
    float sca = random(0.8, 1);
    if(random(1) < 0.4){
       sca *= 0.6; 
    }
    pushMatrix();
    translate(xx, yy);
    fill(rcol());
    translate(0, 0, ss*0.1*sca);
    rotate(random(TAU));
    box(ss*0.02*sca, ss*0.04*sca, ss*0.2*sca); 
    popMatrix();
  }
}
