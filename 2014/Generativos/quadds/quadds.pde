/*
color pallete[] = {
 #211D1E, #5B1027, #FF9F80, #FFCC99, #DBD1C5
 };
 
 color pallete[] = {
 #0E0A0F, #F66A91, #F0BAB1, #E5D0BF, #EDE4DF
 };
 */
color paleta[];
int seed = int(random(9999999));

void setup() {
  size(600, 800);
  generarPaleta();
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveFrame(seed+".png");
  if (key == 'p'){
    generarPaleta();
    randomSeed(seed);
    generar();
  }
  else{
    seed = frameCount;
    randomSeed(seed);
    generar();
  }
}

void generarPaleta() {
  //JSONArray jdata = loadJSONArray("http://www.colourlovers.com/api/palettes/new&format=json");
  JSONArray jdata = loadJSONArray("http://www.colourlovers.com/api/palettes/random&format=json");
  JSONArray jpal = jdata.getJSONObject(int(random(jdata.size()))).getJSONArray("colors");
  paleta = new color[jpal.size()];
  for (int i = 0; i < paleta.length; i++) {
    paleta[i] = color(unhex("FF"+jpal.getString(i)));
  }
}
void generar() {
  background(rcol());
  noiseSeed(seed);
  for (int i = 0; i < 100000; i++) {
    float x = random(width);
    float y = random(height);
    if (true || noise(x*0.004, y*0.004) > 0.6) {
      stroke(bri(rcol(), random(20, 100)));
      line(x+2, y+2, x-2, y-2);
      line(x+2, y-2, x-2, y+2);
    }
  }
  for (int i = 0; i < 8; i++) {
    float x = random(width);
    float y = random(height);
    float dim = random(width*0.01, width*2);
    float def = random(0.4, 1);

    noStroke();
    float dd = dim/30.;
    color col = rcol();
    for (int j = 30; j > 0; j--) {
      randomSeed(j*500);
      if (brightness(col) < 30) fill(bri(col, random(30)));
      else if (brightness(col) > 220) fill(bri(col, random(-30)));
      else fill(sat(col, random(30)));
      quaad(x, y, j*dd, def);
    }
  }

  if (random(1) < 0.5) {
    color c1 = rcol();
    color c2 = rcol();
    float alp = random(80, 200); 
    for (int i = 0; i < width; i++) {
      stroke(lerpColor(c1, c2, map(i, 0, width, 0, 1)), alp);
      line(i, 0, i, height);
    }
  } else {
    color c1 = rcol();
    color c2 = rcol();
    float alp = random(80, 200); 
    for (int i = 0; i < height; i++) {
      stroke(lerpColor(c1, c2, map(i, 0, height, 0, 1)), alp);
      line(0, i, width, i);
    }
  }
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      set(i, j, bri(sat(get(i, j), random(-12, 12)), random(4)));
    }
  }
}
color rcol() {
  return paleta[int(random(paleta.length))];
}
void quaad(float x, float y, float dim, float def) {
  randomSeed(int(x+y));
  float ang = random(TWO_PI);
  int cant = 4;
  float da = TWO_PI/cant;
  float r = dim/2;
  beginShape();
  for (int i = 0; i < cant; i++) {
    float deff = r - r * random(def);
    vertex(x+cos(ang+da*i)*deff, y+sin(ang+da*i)*deff);
  }
  endShape(CLOSE);
}

color hue(color c, float cant) {
  pushStyle(); 
  colorMode(HSB);
  color aux = color(hue(c)+cant, saturation(c), brightness(c));
  popStyle();
  return aux;
}

color sat(color c, float cant) {
  pushStyle(); 
  colorMode(HSB);
  color aux = color(hue(c), saturation(c)+cant, brightness(c));
  popStyle();
  return aux;
}

color bri(color c, float cant) {
  pushStyle(); 
  colorMode(HSB);
  color aux = color(hue(c), saturation(c), brightness(c)+cant);
  popStyle();
  return aux;
}
