ArrayList<Word> words;
String text = "";

void setup() {
  size(800, 600);
  words = new ArrayList<Word>();
}

void draw() {
  background(80);
  for (int i = 0; i < words.size (); i++) {
    Word w = words.get(i);
    w.update();
    if (w.remove) {
      words.remove(i--);
    }
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    words.add(new Word(random(width), -100, text));
    text = "";
  } else {
    text += key;
  }
}

class Word {
  boolean remove;
  color col;
  float x, y; 
  String text;
  Word(float x, float y, String text) {
    this.x = x; 
    this.y = y;
    this.text = text;
    col = color(random(256), random(256), random(256));
  }
  void update() {
    y += 1;
    show();
  }

  void show() {
    fill(col);
    text(text, x, y);
  }
}
