class Person {
  float size;
  PVector position, newPosition;
  int pants, skin, shirt;

  PVector foot1, foot2;
  PVector pelvis1, pelvis2;
  PVector hip;

  PVector body;
  float widthBody, heightBody;
  float hh;
  float headWidth, headHeight;

  PVector hand1, hand2, shoulder1, shoulder2;
  float handDis1, handDis2, handsSize;
  PVector head;

  float angle, rotAngle, handsVel;

  Person() {
    init();
  }
  void init() {

    float x = random(-width*0.1, width*1.1);
    float y = random(-height*0.1, height*1.1);
    size = gridSize*0.8;
    if (random(1) < 0.1) size *= random(0.5, 2.4);

    hh = random(0.2, 1);
    widthBody = size*random(1, 1.3);
    heightBody = size*5.2*hh;

    headWidth = size*0.12;
    headHeight = size*0.12;

    handsSize = size*0.06;

    x -= x%gridSize;
    y -= y%gridSize;
    position = new PVector(x, y);
    newPosition = new PVector(x, y);

    pants = rcol();
    while (pants == backColor) pants = rcol();
    shirt = rcol();
    while (shirt == backColor) shirt = rcol();
    skin = rcol();
    while (skin == backColor || shirt == skin) skin = rcol();

    personsPositions.add(position);
    headsPositions.add(head);

    angle = 0;//random(TAU);
    rotAngle = random(0.04, 0.1)*20*((random(1) < 0.5)? -1 : 1);
    handsVel = random(-0.8, 0.8);
  }

  void update() {

    angle = time*handsVel*10;


    if (position.dist(newPosition) < 1 && random(1) < 0.03) {
      float nx = random(-width*0.1, width*1.1);
      float ny = random(-height*0.1, height*1.1);
      newPosition = new PVector(nx, ny);
    } else {
      PVector mov = newPosition.copy().sub(position);
      float mag = constrain(mov.mag(), 0, 0.3);
      mov.setMag(mag);
      position.add(mov);
    }



    float x = position.x;
    float y = position.y;

    float rotx1 = cos(angle);
    float rotx2 = cos(angle+PI);
    float roty1 = sin(angle);
    float roty2 = sin(angle+PI);

    //body = new PVector(0, -size*5.5*hh);
    //hip = new PVector(0, body.y+heightBody*0.45);
    
    float dy = cos(time*10)*hh*5;
    
    hip = new PVector(0, -size*3*hh+dy);
    body = new PVector(0, hip.y-+heightBody*0.45);
    head = new PVector(0, -size*8.2*hh+dy);
    //headsPositions.add(head);

    //ang = 0;
    //rotAng = 0;
    foot1 = new PVector(size*rotx1*0.3, size*roty1*0.1);
    foot2 = new PVector(size*rotx2*0.3, size*roty2*0.1);

    pelvis1 = new PVector(size*cos(angle)*0.35, hip.y);
    pelvis2 = new PVector(size*cos(angle+PI)*0.35, hip.y);
    /*
     */

    shoulder1 = new PVector(+widthBody*cos(angle)*0.4, -size*(7.8*hh+sin(angle)*0.1)+dy);
    shoulder2 = new PVector(+widthBody*cos(angle+PI)*0.4, -size*(7.8*hh+sin(angle+PI)*0.1)+dy);


    noiseDetail(2);

    /*
    float tt = time*handsVel;
     float det = 0.01;
     hand1 = new PVector(size*map(noise(x*det, y*det+1, tt), 0, 1, -2.2, 2.2), -size*hh*map(noise(x*det+3, y*det, tt), 0, 1, 4, 12));
     hand2 = new PVector(size*map(noise(x*det, y*det+3, tt), 0, 1, -2.2, 2.2), -size*hh*map(noise(x*det+5, y*det, tt), 0, 1, 2, 10));
     */

    hand1 = new PVector(size*2.2*cos(angle), -size*(7.8*hh+sin(angle))+dy);
    hand2 = new PVector(size*2.2*cos(angle+PI), -size*(7.8*hh+sin(angle+PI))+dy);

    handDis1 = size*5.2*hh-hand1.dist(shoulder1);
    handDis2 = size*5.2*hh-hand2.dist(shoulder2);
  }

  void show() {

    pushMatrix();
    translate(position.x, position.y);

    noStroke();
    fill(0, 8);
    ellipse(0, 0, size, size*0.3);
    ellipse(0, 0, size*1.8, size*0.3*1.8);

    strokeWeight(1.2);

    stroke(pants);
    line(foot1.x, foot1.y, pelvis1.x, pelvis1.y);
    line(foot2.x, foot2.y, pelvis2.x, pelvis2.y);
    noStroke();
    fill(pants);

    float ampWidth = (0.9+cos(angle*2)*0.1);
    ellipse(hip.x, hip.y, size*0.8*ampWidth, size*0.8);

    fill(shirt);
    rect(body.x, body.y, widthBody*ampWidth, heightBody, size*0.4, size*0.4, size*0.9, size*0.9);


    noStroke();
    fill(skin);
    ellipse(head.x, head.y, headWidth, headHeight);

    strokeWeight(1);
    noFill();
    //fill(0, 50);
    stroke(shirt);  
    curve(hand1.x, hand1.y+handDis1, hand1.x, hand1.y, shoulder1.x, shoulder1.y, shoulder1.x, shoulder1.y+handDis1);
    curve(hand2.x, hand2.y+handDis2, hand2.x, hand2.y, shoulder2.x, shoulder2.y, shoulder2.x, shoulder2.y+handDis1);
    noStroke();
    fill(skin);
    ellipse(hand1.x, hand1.y, handsSize, handsSize);
    ellipse(hand2.x, hand2.y, handsSize, handsSize);


    popMatrix();
  }

  void showSkeleton() {

    float size = 3;

    pushMatrix();
    translate(position.x, position.y);

    stroke(0, 255, 0, 200);
    line(foot1.x, foot1.y, pelvis1.x, pelvis1.y);
    line(foot2.x, foot2.y, pelvis2.x, pelvis2.y);
    line(pelvis1.x, pelvis1.y, pelvis2.x, pelvis2.y);


    line(pelvis1.x, pelvis1.y, shoulder1.x, shoulder1.y);
    line(pelvis2.x, pelvis2.y, shoulder2.x, shoulder2.y);

    line(hand1.x, hand1.y, shoulder1.x, shoulder1.y);
    line(hand2.x, hand2.y, shoulder2.x, shoulder2.y);


    noStroke();
    fill(0, 255, 0);
    ellipse(0, 0, 2, 2);

    ellipse(foot1.x, foot1.y, size, size);
    ellipse(foot2.x, foot2.y, size, size);

    ellipse(pelvis1.x, pelvis1.y, size, size);
    ellipse(pelvis2.x, pelvis2.y, size, size);


    ellipse(hip.x, hip.y, size, size);
    ellipse(body.x, body.y, size, size);

    ellipse(head.x, head.y, size, size);

    ellipse(shoulder1.x, shoulder1.y, size, size);
    ellipse(shoulder2.x, shoulder2.y, size, size);
    ellipse(hand1.x, hand1.y, size, size);
    ellipse(hand2.x, hand2.y, size, size);
    ellipse(hand2.x, hand2.y, size, size);

    popMatrix();
  }
}
