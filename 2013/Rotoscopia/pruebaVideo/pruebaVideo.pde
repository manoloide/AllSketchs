import processing.video.*;

Capture video;
Movie mov;

int fotograma;

void setup() {
  size(displayWidth, displayHeight);
  frame.setResizable(true);

  mov = new Movie(this, "transit.mov");
  mov.speed(0.2);
  mov.loop();
  mov.play();
  mov.jump(0);
  mov.pause();
}

void draw() {
  if (mov.available()) {
    mov.read();
    mov.play();
    //mov.jump(fotograma);
    //mov.pause();
    println(mov.time());
  }  
  line(0,0,random(width),random(height));
  image(mov, 100, 100); 
}

void keyPressed() {
  if (keyCode == LEFT) {
    fotograma--;
    if (fotograma < 0) {
      fotograma = 0;
    }
  }
  if (keyCode == RIGHT) {
    fotograma++;
    if (fotograma > mov.duration()) {
      fotograma = int(mov.duration());
    }
  }
}

