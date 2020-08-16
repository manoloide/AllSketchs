//endShape();
void flower(float cx, float cy, float sca, float detCol, float desCol) {
  pushMatrix();
  translate(cx, cy);//width*(0.5+ii*0.16), height*(0.5+jj*0.16));
  sca *= random(random(1), 1)*1.6*lerp(1, map(cy, 0, height, 0.2, 1.2), random(1));
  scale(sca);

  float desAng = random(TAU);
  int cc = int(random(3, 8));
  for (int k = 0; k < cc; k++) {
    //rotateX(random(TAU));
    //rotateY(random(TAU));
    //rotateZ(random(TAU));
    float noi = noise(cx*detCol, cy*detCol)*2*colors.length+desCol+random(random(1), 1)*random(random(1), 1);
    int c1 = lerpColor(getColor(noi), color(255), random(0.1)*random(1));
    int c2 = lerpColor(getColor(noi), color(255), random(0.1)*random(1));
    if (random(1) < 0.2)
    c1 = lerpColor(c1, color(255), random(random(0.8, 1)));
    if (random(1) < 0.2)
    c2 = lerpColor(c2, color(255), random(random(0.8, 1)));

    float amp = random(1, random(2.5, 3.5)*0.8)*1.2;
    float rot = amp*TAU;
    float sub = int(random(4000, 8000)*0.6*amp);

    float r1 = width*random(0.4, 0.6)*0.05*0.5;
    float r2 = width*random(0.7, 0.9)*0.06*0.5;
    float pwrR = random(0.5, 1.5);

    float s1 = width*random(0.3, 0.6)*0.04;
    float s2 = width*random(0.6, 0.8)*0.04;
    float pwrS = random(0.5, 1.5);

    float da = rot/sub;
    noFill();
    //beginShape();
    float oscAmp = random(5, 16)*random(1)*random(2);
    float alt = random(-0.4, 0.4)*random(1);
    for (int i = 0; i < sub; i++) {
      float v = i*1./sub;
      //v += sin(v*TAU);
      float r = pow(lerp(r1, r2, v), pwrR);
      float a = da*i;
      float s = pow(lerp(s1, s2, v), pwrS);
      int col = lerpColor(c1, c2, v);
      float alp = 26*sin(PI*v)*random(0.6, 1)-random(2);
      stroke(col, alp);
      strokeWeight(1.2*pow(sin(PI*v), 1.2));
      //vertex(cos(a)*r, sin(a)*r);


      float det = 0.002*v;
      float a1 = v*TAU;
      a1 = ((float)SimplexNoise.noise(100+cos(a1)*det*r, sin(a1)*det*r, k*10)*2-1)*TAU*4;
      float a2 = v*TAU;
      a2 = ((float)SimplexNoise.noise(cos(a2)*det*r, 100+sin(a2)*det*r, k*10)*2-1)*TAU*4;
      a1 = a1%TAU;
      a2 = a2%TAU;
      float mm = min(a1, a2);
      a2 = max(a2, a1);
      a1 = mm;

      float osc = 1+sin(pow(v, 2.4)*TAU*oscAmp)*0.24+sin(a*6)*0.2;
      pushMatrix();
      float xx = cos(a)*r*osc;
      float yy = sin(a)*r*osc;

      xx += cos(xx*2.01)*1.8;
      yy += sin(yy*2.01)*1.8;
      PVector p = def(xx, yy);
      translate(p.x, p.y);
      //rotateY(-a);
      //rotateY(a);
      //a1 = 0;
      //a2 = TAU;
      arc2(0, 0, s, a1, a2, col, 0, alp*0.6, alt, desAng);
      //arc2(0, 0, s, lerp(a1, a2, 0.3), lerp(a1, a2, 0.5), color(255), 0, alp*0.2, alt);
      blendMode(ADD);
      if (random(1) < 0.2) {
        fill(lerpColor(col, color(255, 0), random(1)), random(60));
        float ss = s*0.012*random(0.4, 0.8);
        a2 *= random(1);
        ellipse(cos(a2)*r, sin(a2)*r, ss, ss);
      }
      blendMode(NORMAL);
      popMatrix();
    }
  }
  popMatrix();
}

void arc2(float x, float y, float s, float a1, float a2, int col, float alp1, float alp2, float alt, float desAng) {
  float r = s*0.5;
  float aa = max(a1, a2);
  a1 = min(a1, a2);
  a2 = aa;

  int res = int((a2-a1)*r*PI*0.1);
  noFill(); 
  beginShape();
  for (int i = 0; i < res; i++) {
    float v = (i*1.)/(res-1);
    float a = lerp(a1, a2, v);
    float alp = lerp(alp1, alp2, v);
    float mod = 1+sin(v*PI)*alt+cos(a*res+desAng)*0.001;
    stroke(col, alp);
    vertex(x+cos(a)*r*mod, y+sin(a)*r*mod);
  }
  endShape();
}
