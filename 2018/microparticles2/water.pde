void water(boolean colors) {

  float tt = (globalTime%10.)/10.;

  float amp = 1;
  if (tt < 0.1) amp = map(tt, 0, 0.1, 0, 1);
  if (tt > 0.8) amp = constrain(map(tt, .9, 0.8, 0, 1), 0, 1);

  //randomSeed(seed);
  noiseSeed(seed);
  float time = millis()*0.001;
  float det = 0.02;
  noStroke();
  int col = lerpColor(color(0), getColor(time*0.6), 0.5);
  for (int j = 0; j < letters.length; j++) {
    RShape shape = letters[j];
    RPoint[] points = shape.getPoints();
    if(colors) fill(lerpColor(col, getColor(time*3.1+j*10.8), 0.1));
    beginShape();
    for (int i = 0; i < points.length; i++) {
      RPoint p = points[i];
      float ang = noise(p.x*det, p.y*det, time)*TWO_PI;
      float dis = noise(p.x*det, p.y*det, time+971) * 3;
      float dd = dis;
      float dx = cos(ang)*dd;
      float dy = sin(ang)*dd;
      float xx = p.x+dx;
      float yy = p.y+dy;
      if (amp < 1) {
        xx = lerp(0, xx, Easing.ElasticOut(amp, 0, 1, 1, 0.1, 10));
        yy = lerp(0, yy, Easing.ElasticOut(amp, 0, 1, 1, 0.2, 20));
      }
      yy *= 1.2;
      vertex(xx, yy);
    }
    endShape(CLOSE);
  }
}
