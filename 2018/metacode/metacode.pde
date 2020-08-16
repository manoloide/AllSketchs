String src = "test.mc";

void setup() {
  size(960, 960, P2D);
  pixelDensity(2);
  smooth(8);
  frameRate(5);
}

void draw() {
  drawCode(src);
}

// INSTRUCCIONES

// COLOR
// f r g b a -> FILL
// nf -> NOFILL
// ns -> NOSTROKE
// s r g b a -> STROKE
// st s -> STROKEWEIGHT

// GEOMETRIC
// b -> BACKGROUND
// c x y s -> CIRCLE
// e x y w h -> ELLIPSE
// l x1 y1 x2 y2 -> LINE
// p x y -> POINT
// r x y w h -> RECTANGLE

// SHAPE
// bs -> BEGINSHAPE
// es -> ENDSHAPE
// v x y -> VERTEX



// FUTURE
//t x y -> TRANSLATE
//r x -> ROTATE
//pu -> pushMatrix
//po -> popMatrix




void drawCode(String meta) {
  String lines[] = loadStrings(meta);

  int len;
  String aux[], cmd, args[];
  for (int i = 0; i < lines.length; i++) {
    aux = split(lines[i], " ");
    len = aux.length;
    if (len == 0) continue;
    cmd = aux[0];
    args = new String[len-1];
    if (len > 1) {
      for (int j = 0; j < len-1; j++) {
        args[j] = aux[j+1];
      }
    }


    if (cmd.equals("b")) {
      background(g.fillColor);
    } else if (cmd.equals("c") && len == 4) {
      ellipse(float(args[0]), float(args[1]), float(args[2]), float(args[2]));
    } else if (cmd.equals("e") && len == 5) {
      ellipse(float(args[0]), float(args[1]), float(args[2]), float(args[3]));
    } else if (cmd.equals("f")) {
      if (len == 2) fill(float(args[0]));
      if (len == 3) fill(float(args[0]), float(args[1]));
      if (len == 4) fill(float(args[0]), float(args[1]), float(args[2]));
      if (len == 5) fill(float(args[0]), float(args[1]), float(args[2]), float(args[3]));
    } else if (cmd.equals("l")) {
      line(float(args[0]), float(args[1]), float(args[2]), float(args[3]));
    } else if (cmd.equals("nf")) {
      noFill();
    } else if (cmd.equals("ns")) {
      noStroke();
    } else if (cmd.equals("p")) {
      if (len == 3) point(float(args[0]), float(args[1]));
    } else if (cmd.equals("r") && len == 5) {
      rect(float(args[0]), float(args[1]), float(args[2]), float(args[3]));
    } else if (cmd.equals("s")) {
      if (len == 2) stroke(float(args[0]));
      if (len == 3) stroke(float(args[0]), float(args[1]));
      if (len == 4) stroke(float(args[0]), float(args[1]), float(args[2]));
      if (len == 5) stroke(float(args[0]), float(args[1]), float(args[2]), float(args[3]));
    } else if (cmd.equals("sw")) {
      strokeWeight(float(args[0]));
    } else if (cmd.equals("bs")) {
      beginShape();
    } else if (cmd.equals("es")) {
      endShape();
    } else if (cmd.equals("v")) {
      vertex(float(args[0]), float(args[1]));
    }
  }
}