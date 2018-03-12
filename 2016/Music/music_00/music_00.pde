void setup() {
  size(960, 640);
  generate();
}


void draw() {
}

void keyPressed() {
  generate();
}

void generate() {
  background(26);

  float bb = 40;

  fill(30);
  stroke(46);
  for (int i = 0; i < 24; i++) {
    rect(bb, bb+i*8, width-bb*2, 8);
  }
  for (int i = 1; i < 4; i++) {
    float dx = (width-bb*2)/4; 
    line(bb+dx*i, bb, bb+dx*i, bb+8*24);
  }

  generateSong();
}

String noteNames[] = {
  "c", "c#", "d", "d#", "e", "f", "f#", "g", "g#", "a", "a#", "b"
};

String getNote(int num) {
  return noteNames[num%12];
}

void generateSong() {
  int tone = int(random(12));
  int chords[] = {
    1, 2, 3, 4, 5, 6, 7
  };
  int scale[] = {
    0, 2, 4, 5, 7, 9, 11
  };


  int a[] = new int[int(random(1, 3.1))*4];
  int b[] = new int[int(random(1, 3.2))*4];
  int c[] = new int[4]; 

  print("A: ");
  float ww = (width-80)/4;
  for (int i = 0; i < a.length; i++) {
    a[i] = int(random(chords.length));
    int note = scale[a[i]];
    int ter = scale[(a[i]+2)%7]+((a[i]+2)/7)*12;
    int qui = scale[(a[i]+4)%7]+((a[i]+4)/7)*12;
    fill(255, 128, 0);
    rect(40+ww*i, 40+24*8-(note+1)*8, ww, 8);
    rect(40+ww*i, 40+24*8-(ter+1)*8, ww, 8);
    rect(40+ww*i, 40+24*8-(qui+1)*8, ww, 8);
    print(getNote(note), " ");
  }
  print("B: ");
  for (int i = 0; i < b.length; i++) {
    b[i] = chords[int(random(chords.length))];
    print(getNote(scale[b[i]-1]), " ");
  }
  print("C: ");
  for (int i = 0; i < c.length; i++) {
    c[i] = chords[int(random(chords.length))];
    print(getNote(scale[c[i]-1]), " ");
  }
}

