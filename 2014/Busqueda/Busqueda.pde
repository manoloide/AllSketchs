import manoloide.Input.Key;
import manoloide.Input.Input;

Input input;
String estado = "buscar";
TextBuscar tb;

void setup() {
  size(800, 600);
  //textMode(SHAPE);
  input = new Input(this);
  tb = new TextBuscar(width/2, height/2-120, 320, 80);
}

void draw() {
  if (frameCount%20 == 0) frame.setTitle("BUSCAR  "+tb.text+"    FPS:"+frameRate);
  background(40);
  if (estado.equals("buscar")) {
    tb.update();
  }
  if(estado.equals("informarcion")){
    
  }
  //cargar();
  input.update();
}

void keyPressed() {
  input.event(true);
}
void keyReleased() {
  input.event(false);
}

void mousePressed() {
  input.mpress();
}
void mouseReleased() {
  input.mreleased();
}

void updInfo() {
  String bus = tb.text.replace(' ', '+');
  JSONArray aux = loadJSONArray("http://suggestqueries.google.com/complete/search?q="+bus+"&client=firefox&hl=es"); 
  tb.info = aux.getJSONArray(1);
}

class TextBuscar {
  float x, y, w, h, dy;
  int pos, tam;
  JSONArray info;
  String text;
  PFont font;
  TextBuscar(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    tam = int(h)-4;
    text = "hola";
    pos = text.length();
    font = createFont("Hncb.otf", tam, true);
    updFont();
    info = null;
  }
  void update() {
    boolean editar = true;
    if (editar) {
      if (input.ENTER.click) editar = false;
      if (pos > 0 && (input.IZQUIERDA.click || (input.IZQUIERDA.press && input.IZQUIERDA.clickCount%3 == 0 && input.IZQUIERDA.clickCount > 30))) pos--;
      if (pos < text.length() && (input.DERECHA.click || (input.DERECHA.press && input.DERECHA.clickCount%3 == 0 && input.DERECHA.clickCount > 30))) pos++;
      if (input.BACKSPACE.click || (input.BACKSPACE.press && input.BACKSPACE.clickCount%3 == 0 && input.BACKSPACE.clickCount > 30)) {
        int lar = text.length();
        if (lar > 0 && pos > 0) {
          text = text.substring(0, pos-1)+text.substring(pos, lar);
          pos--;
          updFont();
          updInfo();
        }
      }
      if (input.kclick) {
        if (key >= 32 && key <= 126) {
          text = text.substring(0, pos)+ key +text.substring(pos);
          pos++;
          updFont();
          updInfo();
        }
      }
    }

    dibujar();
  }
  void dibujar() { 
    rectMode(CENTER);
    if (info != null) {
      float hh = h/3;
      textFont(font);
      textSize(hh*0.9);
      textAlign(LEFT, TOP);
      for (int i = 0; i < info.size (); i++) {
        stroke(120);
        fill(130);
        if(i == info.size()-1) rect(x, y+h/2+(hh/2)+hh*i, w, hh, 0, 0, 2, 2);
        else rect(x, y+h/2+(hh/2)+hh*i, w, hh, 2); 
        fill(10);
        text(info.getString(i), x+2, y+h/2+(hh/2)+hh*i, w, hh);
      }
    }

    stroke(127, 40);
    fill(10, 40);
    rect(x, y, w, h, 2);
    textFont(font);
    textSize(tam);
    textAlign(CENTER, CENTER);
    fill(250, 250);
    text(text, x, y+dy);
    noStroke();
    if (frameCount%60 < 30) rect(x+textWidth(text)/2+2, y, 2, (textAscent()-textDescent()));
  }
  void updFont() {
    int auxtam = int(h)-4;
    textSize(auxtam);
    textFont(font);
    while (textWidth (text) > w-4) {
      auxtam--;
      textSize(auxtam);
    }
    tam = auxtam;
    textSize(tam);
    dy = textDescent()*1.2;
  }
  void updInfo() {
    info = null;
    if (text.length() <= 0) return;
    thread("updInfo");
  }
};

void cargar() {
  float x = width/2;
  float y = height/2;
  float rad = 40;
  int cant = 6;
  float tam = 22;
  noStroke();
  fill(20, 240);
  rectMode(CORNER);
  rect(0, 0, width, height);
  float val = (frameCount%30)/30.;
  float da = TWO_PI/cant;
  noStroke();
  for (int i = 0; i < cant; i++) {
    float alp = map((val*cant-i+cant)%cant, 0, cant, 50, 0);
    fill(250, alp);
    ellipse(x+cos(da*i)*rad, y+sin(da*i)*rad, tam, tam);
  }
}
