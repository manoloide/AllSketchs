class Person {
  int seed;
  int age;
  Person() {
    age = int(random(0, random(60, random(80, 100)))   );
  }
  void show() {
    float x = width/2*random(0, 2); 
    float y = height/2*random(0, 2); 
    float headSize = random(10, 240);
    noStroke();
    fill(random(50), random(8, 40), random(80, 100));
    ellipse(x, y, headSize, headSize);
    float eyeSize = headSize*random(0.08, 0.18);
    float eyeHeight = headSize*random(-0.08, 0.08);
    float eyeSep = (headSize-eyeSize)*random(0.12, random(0.3, 0.5));
    float eyeShadows = eyeSize*random(1.05, 1.40);
    fill(#28222C, random(80));
    ellipse(x-eyeSep, y+eyeHeight+eyeSize*0.1, eyeShadows, eyeShadows);
    ellipse(x+eyeSep, y+eyeHeight+eyeSize*0.1, eyeShadows, eyeShadows);
    fill(#1A1715);
    ellipse(x-eyeSep, y+eyeHeight, eyeSize, eyeSize);
    ellipse(x+eyeSep, y+eyeHeight, eyeSize, eyeSize);

    noFill();
    stroke(#671616); 
    strokeWeight(headSize*random(0.04, 0.18));
    beginShape();
    curveVertex(x-headSize*0.2, y+headSize*0.25);
    curveVertex(x-headSize*0.2, y+headSize*0.25);
    float amp = random(0.18, 0.32);
    curveVertex(x-headSize*0.07, y+headSize*amp);
    curveVertex(x+headSize*0.07, y+headSize*amp);
    curveVertex(x+headSize*0.2, y+headSize*0.25);
    curveVertex(x+headSize*0.2, y+headSize*0.25);
    endShape();
  }
}

