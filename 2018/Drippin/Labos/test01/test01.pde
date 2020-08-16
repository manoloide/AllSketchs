int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(255);

  ArrayList<PVector> rects = new ArrayList<PVector>();

  rects.add(new PVector(0, 0, height));

  int sub = int(random(0, random(1000)*random(1)));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));
    rects.remove(ind);
  }

  noStroke();

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i); 
    int rnd = 1+int(random(4));
    //rnd = 4;
    if (rnd == 0) {
      fill(rcol());
      rect(r.x, r.y, r.z, r.z);
    } else if (rnd == 1) {
      form1(r.x, r.y, r.z, r.z);
    } else if (rnd == 2) {
      form2(r.x, r.y, r.z, r.z);
    } else if (rnd == 3) {
      form3(r.x, r.y, r.z, r.z);
    } else if (rnd == 4) {
      form4(r.x, r.y, r.z, r.z);
    } else if (rnd == 5) {
      //form5(r.x, r.y, r.z, r.z);
    }
  }
}

void form1(float x, float y, float w, float h) {
  int[] cols = rcols(3);
  PVector ps[] = {new PVector(x, y), new PVector(x+w, y), new PVector(x+w, y+h), new PVector(x, y+h)};

  int init = int(random(4));
  for (int i = 0; i < 3; i++) {
    fill(cols[i]);
    beginShape();
    for (int j = 0; j < 3; j++) {
      int ind = (init+i+j)%4;
      vertex(ps[ind].x, ps[ind].y);
    }
    endShape(CLOSE);
  }
}

void form2(float x, float y, float w, float h) {
  int[] cols = rcols(3);

  fill(cols[0]);
  rect(x, y, w, h);

  float cx = x+w*0.5;
  float cy = y+h*0.5;

  fill(cols[1]);
  ellipse(cx, cy, w, h);

  PVector ps[] = {new PVector(x, y), new PVector(x+w, y), new PVector(x+w, y+h), new PVector(x, y+h)};
  int ind = int(random(4));

  int i1 = (ind+3)%4;
  int i2 = ind;
  int i3 = (ind+5)%4;

  beginShape();
  vertex(lerp(ps[i1].x, ps[i2].x, 0.5), lerp(ps[i1].y, ps[i2].y, 0.5));
  vertex(ps[i2].x, ps[i2].y);
  vertex(lerp(ps[i2].x, ps[i3].x, 0.5), lerp(ps[i2].y, ps[i3].y, 0.5));
  endShape();

  fill(cols[2]);
  ellipse(cx, cy, w*0.45, h*0.45);
}

void form3(float x, float y, float w, float h) {
  int[] cols = rcols(3);
  if (random(1) < 0.5) {
    fill(cols[0]);
    rect(x, y, w*0.5, h);
    fill(cols[1]);
    rect(x+w*0.5, y, w*0.5, h);
    fill(cols[2]);
    if (random(1) < 0.5) {
      ellipse(x+w*0.25, y+h*0.5, w*0.5, h*0.5);
    } else {  
      ellipse(x+w*0.75, y+h*0.5, w*0.5, h*0.5);
    }
  } else {
    fill(cols[0]);
    rect(x, y, w, h*0.5);
    fill(cols[1]);
    rect(x, y+h*0.5, w, h*0.5);

    fill(cols[2]);
    if (random(1) < 0.5) {
      ellipse(x+w*0.5, y+h*0.25, w*0.5, h*0.5);
    } else {  
      ellipse(x+w*0.5, y+h*0.75, w*0.5, h*0.5);
    }
  }
}

void form4(float x, float y, float w, float h) {
  int[] cols = rcols(5);

  fill(cols[0]);
  rect(x, y, w, h);

  PVector ps[] = {new PVector(x, y), new PVector(x+w, y), new PVector(x+w, y+h), new PVector(x, y+h)};
  int ii = int(random(4));

  float amp = random(1);
  amp = 0.65;
  for (int j = 0; j < 2; j++) {
    for (int i = 0; i < 2; i++) {
      int ind = (ii+j+i*2)%4;
      fill(cols[1+ind]);
      int i1 = (ind+3)%4;
      int i2 = (ind)%4;
      int i3 = (ind+5)%4;

      beginShape();
      vertex(lerp(ps[i2].x, ps[i1].x, amp), lerp(ps[i2].y, ps[i1].y, amp));
      vertex(ps[i2].x, ps[i2].y);
      vertex(lerp(ps[i2].x, ps[i3].x, amp), lerp(ps[i2].y, ps[i3].y, amp));
      endShape();
    }
  }
}
/*
void form4(float x, float y, float w, float h) {
  int[] cols = rcols(5);

  fill(cols[0]);
  rect(x, y, w, h);

  PVector ps[] = {new PVector(x, y), new PVector(x+w, y), new PVector(x+w, y+h), new PVector(x, y+h)};
  int ii = int(random(4));

  float amp = random(1);
  amp = 0.65;
  for (int j = 0; j < 2; j++) {
    for (int i = 0; i < 2; i++) {
      int ind = (ii+j+i*2)%4;
      fill(cols[1+ind]);
      int i1 = (ind+3)%4;
      int i2 = (ind)%4;
      int i3 = (ind+5)%4;
      beginShape();
      vertex(lerp(ps[i2].x, ps[i1].x, amp), lerp(ps[i2].y, ps[i1].y, amp));
      vertex(ps[i2].x, ps[i2].y);
      vertex(lerp(ps[i2].x, ps[i3].x, amp), lerp(ps[i2].y, ps[i3].y, amp));
      endShape();
    }
  }
}
*/

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#5741BB, #FD7060, #FDBF67, #34C592, #D8F6DA, #FFFFFF};
int rcol() {
  return colors[int(random(colors.length))];
}
int[] rcols(int cc) {
  cc = constrain(cc, 1, colors.length);
  int[] aux = new int[cc];
  aux[0] = rcol();
  for (int i = 1; i < cc; i++) {
    boolean add = true;
    while (add) {
      add = false;
      aux[i] = rcol();
      for (int j = 0; j < i; j++) {
        if (aux[i] == aux[j]) {
          add = true;
        }
      }
    }
  }
  return aux;
}

int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}