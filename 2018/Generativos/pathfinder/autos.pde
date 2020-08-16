void autos(int cc, float ss) {
  int c = int(random(200, random(200, 1000)));
  for (int i = 0; i < c; i++) {
    float xx = random(-(cc-1.5)*0.5*ss, (cc-1.5)*0.5*ss)*1;
    float yy = random(-(cc-1.5)*0.5*ss, (cc-1.5)*0.5*ss)*1;

    if (abs(xx) < (cc-1.95)*0.5*ss && abs(yy) < (cc-1.95)*0.5*ss) continue;
    float sca = random(0.8, 1);
    float rot = 0; //int(random(4))
    //if (xx < yy) rot = 1;
    if (xx < -yy) {   
      //rot = 1;
      rot = 1;
    }

    if (-xx+yy > 0) {
      rot += 1;
    }

    pushMatrix();
    translate(xx, yy, ss*0.03*sca);
    rotate(HALF_PI*rot);
    fill(rcol());
    box(ss*0.06*sca, ss*0.2*sca, ss*0.06*sca); 
    popMatrix();
  }
}
