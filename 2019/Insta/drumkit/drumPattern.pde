void drumPattern() {


  int cc = 4;

  float bb = 10;
  float ss = (width-bb*2)*1./cc;

  noFill();
  stroke(40);
  rect(width*0.5, height*0.5, width-bb*2+4, height-bb*2+4);
  rect(width*0.5, height*0.5, width-bb*2+10, height-bb*2+10);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      stroke(120);
      rect(ss*(i+0.5)+bb, ss*(j+0.5)+bb, ss-bb, ss-bb); 
      stroke(40);
      rect(ss*(i+0.5)+bb, ss*(j+0.5)+bb, ss-2, ss-2);
    }
  }
}
