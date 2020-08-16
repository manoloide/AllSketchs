Timeline timeline;

void setup() {
  size(1280, 720);
  timeline = new Timeline();
}


void draw() {
  background(80);



  timeline.update();
}

