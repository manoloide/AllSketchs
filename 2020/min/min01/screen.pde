class Screen extends Node {

  String txt = "dadasd";
  int back;
  Screen(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void update() {
  }

  void show() {
    fill(0); 
    rect(x+1, y+1, w-2, h-2);
    fill(230);
    String txtShow = txt.replaceAll("\t", "  ");
    text(txtShow, x+2, y+1, w, h);
  }

  void keyPressed() {

    if (key == CODED) {
    } else if (keyCode == BACKSPACE) {
      if (txt.length() > 0)
        txt = txt.substring(0, txt.length()-1);
    } else {
      txt += key;
    }
  }
}
