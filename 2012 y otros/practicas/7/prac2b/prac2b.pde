int cant[] = new int[10];

void setup() {
  size(400, 400);
}

void draw() {
}

void keyPressed() {
  if ( key >= '0' && key <= '9') {
    cant[int(key)-48]++;
  } 
  for (int i = 0; i < cant.length; i++) {
    println(i +": " + cant[i]);
  }
}

