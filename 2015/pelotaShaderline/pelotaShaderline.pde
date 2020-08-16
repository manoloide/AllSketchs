PShader vintage, glitch; //<>//
PFont foslo16, foslo32, foslo160;
PImage noisee;

int seed;
boolean rec = false;

String text1, text2;

void setup() {
  size(800, 600, P3D);
  smooth(8);
  frameRate(30);
  noisee = imageNoise();
  foslo16 = createFont("Stockholm Mono", 16, true);
  foslo32 = createFont("Oslo II Bold", 32, true);
  foslo160 = createFont("Stockholm Mono", 92, true);
  vintage = loadShader("vintage.glsl");
  vintage.set("iResolution", float(width), float(height));
  glitch = loadShader("glitch.glsl");
  glitch.set("iResolution", float(width), float(height));

  text1 = "PRUEBA1";
  text2 = "Holasas";
}

void draw() {
  vintage.set("iGlobalTime", millis() / 1000.0);
  glitch.set("iGlobalTime", millis() / 1000.0);
  glitch.set("noise", imageNoise());
  hint(DISABLE_DEPTH_TEST);
  background(10);
  //fill(10, 100);
  noStroke();
  //rect(0, 0, width, height);

  hint(ENABLE_DEPTH_TEST);
  float temblor = 0.4;
  translate(random(-temblor, temblor), random(-temblor, temblor));
  pushMatrix();

  fill(#BFBBCE, 30);
  stroke(#BFBBCE, 250);
  translate(width/2, height/2);
  //scale((frameCount%50)/30.+0.3);
  float velRot = 0.001;
  rotateX(frameCount*0.45*velRot);
  rotateY(frameCount*0.137*velRot);
  rotateZ(frameCount*0.047*velRot);
  if (keyPressed) {
    seed = int(random(999999999));
  }
  superPelota(seed, 320+40*cos(frameCount*0.04*velRot)+10*cos(frameCount*0.23*velRot), 200);//frameCount%60);
  popMatrix();
  fill(#BFBBCE);
  textFont(foslo32);
  if (frameCount%2 == 0) {   
    int pos = int(random(text1.length()));
    char nue = (char)int(random(97, 123));
    text1 = text1.substring(0, pos)+nue+text1.substring(pos+1);


    pos = int(random(text2.length()));
    nue = (char)int(random(97, 123));
    text2 = text2.substring(0, pos)+nue+text2.substring(pos+1);
  }
  textAlign(LEFT, TOP);
  text(text1, 108, 108);
  textFont(foslo16);
  text(text2, 108, 142); 
  fill(#BFBBCE, 30);
  rectCon(100, 100, 120, 60, 5);
  /*
  strokeWeight(2);
  stroke(#BFBBCE, 120);
  line(width-40, height/2-30, width-20, height/2);
  line(width-40, height/2+30, width-20, height/2);

  line(40, height/2-30, 20, height/2);
  line(40, height/2+30, 20, height/2);
  strokeWeight(1);
  */
  
  /*
  noStroke();
  rect(0, height/2-80, width, 160);
  fill(#BFBBCE);
  textAlign(CENTER, CENTER);
  textFont(foslo160);
  text("states 1", width/2, height/2);
  */
  
  filter(vintage);
  //filter(vintage);
  filter(glitch);

  for (int i = 0; i < 4; i++) {
    float ang = frameCount*0.2/i;
    float sep = 10;
    //ellipse(mouseX+cos(ang)*sep, mouseY+sin(ang)*sep, pow(3, 1+i*0.42), pow(3, 1+i*0.42));
  }

  if (rec) {
    saveFrame("export/#####.png"); 
    if (frameCount > 30*16) {
      exit();
    }
  }
}

void keyPressed() {
  if (key == 's') saveFrame("######.png");
}

void superPelota(int seed, float d, int cant) {
  float r = d*0.5;
  int ar = (int)random(100000000);
  randomSeed(seed);
  ArrayList<PVector> puntos = new ArrayList<PVector>();
  for (int i = 0; i < cant; i++) {
    float a1 = random(TWO_PI);
    float a2 = random(TWO_PI);
    float rr = r;//r * cos(a1*5)+ r * cos(a2*5);
    puntos.add(new PVector(sin(a1)*cos(a2)*rr, sin(a1)*sin(a2)*rr, cos(a1)*rr));
  }
  sphereDetail(4);
  for (int i = 0; i < cant; i++) {
    pushMatrix();
    PVector p = puntos.get(i);
    for (int j = 0; j < i; j++) {
      PVector p2 = puntos.get(j);
      if (dist(p.x, p.y, p.z, p2.x, p2.y, p2.z) < r*0.2) {
        line(p.x, p.y, p.z, p2.x, p2.y, p2.z);
      }
    }
    translate(p.x, p.y, p.z);
    pushStyle();
    fill(g.strokeColor);
    noStroke();
    sphere(2); 
    if(dist(p.x, p.y, mouseX-width/2, mouseY-height/2) < 10){
      fill(g.fillColor, 30);
      stroke(g.fillColor, 180);
      sphere(20);  
    }
    popStyle();
    popMatrix();
  }
  randomSeed(ar);
}

void rectCon(float x, float y, float w, float h, float t) {
  pushStyle();
  noStroke();
  rect(x, y, w, h);
  popStyle();
  line(x+t, y, x, y);
  line(x, y, x, y+t);
  line(x+w-t, y, x+w, y);
  line(x+w, y, x+w, y+t);
  line(x+w-t, y+h, x+w, y+h);
  line(x+w, y+h, x+w, y+h-t);
  line(x+t, y+h, x, y+h);
  line(x, y+h, x, y+h-t);
}

PImage imageNoise() {
  PImage aux = createImage(width, height, RGB); 
  aux.loadPixels();
  for (int i = 0; i < width; i++) {
    for (int j = 0; j< height; j++) {
      aux.set(i, j, color(random(140, 250)));
    }
  }
  aux.updatePixels();
  return aux;
}
