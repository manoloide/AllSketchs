int margin = 0; 
int border = 0; 
int amount = 1;

ColourLovers cl;
PFont helve;

void setup() {
  size(800, 400);
  cl = new ColourLovers();
  helve = createFont("Helvetica Neue Bold", 120, true);
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveFrame();
  else generar();
}

void generar() {
  float ww = (width-margin*2.);
  float hh = (height-margin*2.-border*(amount-1))/amount;

  for (int i = 0; i < amount; i++) {
    PGraphics aux = visual(int(ww), int(hh));
    image(aux, margin, margin+(hh+border)*i);
  }
}

PGraphics visual(int w, int h) {
  PGraphics vi = createGraphics(w, h);
  PGraphics mask = createGraphics(w, h);
  PGraphics cruces = createGraphics(w, h);
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.textAlign(CENTER, CENTER);
  mask.textFont(helve);
  mask.textSize(random(80, 120));
  mask.text("MANOLOIDE", w/2, h/2);
  mask.filter(BLUR, random(4));
  mask.endDraw();

  int[] pallete = cl.getRandomPalette();
  cruces.beginDraw();
  for(int i = 0; i < 100; i++){
     cruces.stroke(pallete[int(random(1, pallete.length))]);
     float x = random(w);
     float y = random(h);
     float t = random(3, 20); 
     cruces.strokeCap(SQUARE);
     cruces.strokeWeight(t*random(0.4,0.8));
     cruces.line(x-t, y-t, x+t, y+t);
     cruces.line(x-t, y+t, x+t, y-t);
  }
  cruces.endDraw();
  
  vi.beginDraw();
  vi.noStroke();
  vi.background(pallete[0]);
  int des = int(random(2, 10));
  vi.stroke(pallete[1]);
  for (int i = -int(random (des)); i < w+h; i+=des) {
    vi.line(i, -2, -2, i);
  }  
  vi.blendMode(int(pow(2, int(random(8))+1)));
  vi.tint(255, random(20, 200));
  vi.image(cruces, 0, 0);
  vi.noTint();
  vi.blendMode(int(pow(2, int(random(8))+1)));
  for (int i = 0; i < 40000; i++) {
    float x = random(w);
    float y = random(h);
    float d = random(1, 12) * brightness(mask.get(int(x), int(y)))/256;
    int cant = int(random(3, 8));
    float ang = random(TWO_PI);
    vi.noStroke();
    vi.fill(pallete[int(random(1, pallete.length))]);
    poly(vi, x, y, d, cant, ang);
  }
  vi.endDraw();
  return vi;
}

void poly(PGraphics gra, float x, float y, float d, int cant, float ang) {
  float r = d/2; 
  float da = TWO_PI/cant;
  gra.beginShape();
  for (int i = 0; i < cant; i++) {
    gra.vertex(x+cos(ang+da*i)*r, y+sin(ang+da*i)*r);
  }
  gra.endShape(CLOSE);
}

class  ColourLovers {
  int[] getRandomPalette() {
    return getPalette("random");
  }
  int[] getTopPalette() {
    return getPalette("random");
  }

  int[] getPalette(String opcion) {
    int pallete[] = null;
    JSONArray jcl = loadJSONArray("http://www.colourlovers.com/api/palettes/"+opcion+"&format=json&numResults=1");
    for (int i = 0; i < jcl.size (); i++) {
      JSONObject pal = jcl.getJSONObject(i);
      JSONArray col = pal.getJSONArray("colors");
      pallete = new int[col.size()];
      for (int j = 0; j < col.size (); j++) {
        String c = col.getString(j);
        int r = unhex(c.substring(0, 2));
        int g = unhex(c.substring(2, 4));
        int b = unhex(c.substring(4));
        pallete[j] = color(r, g, b);
      }
    }
    return pallete;
  }
}
