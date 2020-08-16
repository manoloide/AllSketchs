void pasto() {
  int cc = 38000;
  
  int c1 = #A14E24;
  int c2 = #954221;
  int c3 = #562811;
  
  for (int i = 0; i < cc; i++) {
    float x = random(width*random(1)*0.1, width);
    float z = random(1);
    float y = height*lerp(0.78, 1, z);

    float w = random(1, 4)*0.6;
    float mh = pow(map(x, 0, width, 0.22, 0.06), 1.2)*1.6;
    float h = height*random(lerp(0.4, 0.5, map(i, 0, cc, 1, 0)), 0.62)*mh*0.6;
    pushMatrix();
    translate(x, y-h*0.4);
    rotate(random(-0.1, 0.1)*random(1));
    fill(lerpColor(lerpColor(c1, c2, random(1)), c3, random(1)*random(1)), 200);
    //rect(x, y-h*0.5, w, h);
    ellipse(0, 0, w*random(1, 5)*z, h*z);
    
    fill(lerpColor(lerpColor(c1, c2, random(1)), c3, random(1)*random(1)), 200);
    //rect(x, y-h*0.5, w, h); 
    ellipse(0, -h*z*0.5, h*z*0.1, h*z*0.1);
    popMatrix();
  }
}
