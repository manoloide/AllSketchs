import java.io.*;

int paleta[];
boolean devel = false;

void setup() {
  size(displayWidth, displayHeight); 
  //nuevaPaleta();
  //delay(18000);
  generar();
  if(!devel){
    saveImage();
    runScript();
    exit();
  }
}

void draw(){}

void keyPressed(){
   if(key == 's') saveImage();
  else generar(); 
}

void generar() {
  nuevaPaleta();
  if (random(4) < 2) {
    float dw = width/paleta.length;
    noStroke();
    for (int i = 0; i < paleta.length; i++) {
      fill(paleta[i]);
      rect(dw*i, 0, dw, height);
    }
  } else {
    float dh = height/paleta.length;
    noStroke();
    for (int i = 0; i < paleta.length; i++) {
      fill(paleta[i]);
      rect(0, dh*i, width, dh);
    }
  }
  PGraphics deg = createGraphics(width, height);
  deg.beginDraw();
  int c1 = rcol();
  int c2 = rcol();
  if (random(0.8) < 0.4) {
    for (int i = 0; i < width; i++) {
      deg.stroke(lerpColor(c1, c2, map(i, 0, width, 0, 1)), 100);
      deg.line(i, 0, i, height);
    }
  } else {
    for (int i = 0; i < height; i++) {
      deg.stroke(lerpColor(c1, c2, map(i, 0, width, 0, 1)), 100);
      deg.line(0, i, width, i);
    }
  }
  deg.endDraw();
  if(random(2) < 0.8){
    stroke(rcol(), random(20, 200));
    int des = int(random(2, 30));
    strokeWeight(max(1, des*random(0.5)));
    for (int i = int(-random(des)); i < width+height; i+=des) {
      line(i, -2, -2, i);
    }
  }

  float vt = random(0.01,1);
  int cant = int(random(300));
  cruces(cant, vt);

  vt = random(0.01,1);
  cant = int(random(80));
  int da = int(random(1, 32));
  int cc = int(random(-2,9));
  noStroke();
  for(int i = 0; i < cant; i++){
    float x = random(width);
    float y = random(height);
    float t = random(width*0.002, width*0.7)/2*vt;
    float a = (TWO_PI/da)*int(random(da));
    int c = int(random(3, 8));
    fill(rcol());
    poly(x, y, t, c, a);
    
    if( cc <= 0) continue;
    for (float j = 1-1./cc; j > 0; j-=1./cc) {
      fill(rcol());
      poly(x, y, t*j, c, a);
    }
  }


  if(random(0.9) < 0.4){
    noiseee(random(-9, 9));
  }
  image(deg.get(), 0, 0);
}

void poly(float x, float y, float r, int count, float ang){
  float da = TWO_PI/count;
  beginShape();
  for(int i = 0; i < count; i++){
    vertex(x+cos(ang+da*i)*r, y+sin(ang+da*i)*r);
  }
  endShape(CLOSE);
}

void cruces(int cant, float vt){
    for(int i = 0; i < cant; i++){
    float x = random(width);
    float y = random(height);
    float t = random(width*0.002, width*0.08)/2*vt;
    stroke(rcol());
    strokeCap(SQUARE);
    strokeWeight(t*random(0.5, 0.9));
    line(x-t, y-t, x+t, y+t);
    line(x+t, y-t, x-t, y+t);
  }
}

void noiseee(float b){
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      color aux = get(i,j);
      float bri = random(b);
      aux = color(red(aux)+bri, green(aux)+bri, blue(aux)+bri);
      set(i,j,aux);
    }
  }
}
void nuevaPaleta() {
  JSONArray jdata = loadJSONArray("http://www.colourlovers.com/api/palettes/top&format=json");
  JSONArray jpal = jdata.getJSONObject(int(random(jdata.size()))).getJSONArray("colors");
  paleta = new int[jpal.size()];
  for (int i = 0; i < paleta.length; i++) {
    paleta[i] = color(unhex("FF"+jpal.getString(i)));
  }
}

void saveImage() {
  File img = (new File(sketchPath+"/image/"));
  int cant = int(img.listFiles().length);
  println(img, cant);
  saveFrame("image/wallpaper"+cant+".png");
  saveFrame("image/ultimo.png");
  
}

int rcol(){
  return paleta[int(random(paleta.length))];
}

void runScript(){
  String fullPath = sketchPath+"/cambiar.sh";
  String param[] = new String[1];
  param[0] = sketchPath+"/image/ultimo.png";
  fullPath += " "+param[0];
  println(param[0]);
  try {
    Runtime rt = Runtime.getRuntime();
    Process pr = rt.exec(fullPath);
  }
  catch (IOException e) {
    e.printStackTrace();
  }
}
