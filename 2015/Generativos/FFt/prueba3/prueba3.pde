import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

float camDist, camVel;
PVector rotate = new PVector(0, 0, 0);
PFont helve;
PShader glow, vignette;

int channels = 16;
float values[];

int seed = int(random(99999999));

void setup() {
  size(640, 640, P3D);
  frameRate(30);
  glow = loadShader("glow.glsl");
  glow.set("iResolution", float(width), float(height)); 
  vignette = loadShader("vignette.glsl");
  vignette.set("iResolution", float(width), float(height)); 


  helve = createFont("Helvetica Neue Bold", 80, true);

  minim = new Minim(this);
  player = minim.loadFile("../idm1.mp3", 512);
  player.loop();
  fft = new FFT( player.bufferSize(), player.sampleRate());
  fft.linAverages(16);

  values = new float[channels];

  generarCubes();
  changeCamera();
  changeAngle();
}

ArrayList<PVector> cubes;

void draw() {

  fft.forward( player.mix );
  glow.set("iGlobalTime", millis()/1000.);  
  vignette.set("iGlobalTime", millis()/1000.);

  camDist += camVel;

  if (fft.getBand(6) > 22) {
    generarCubes();
  }

  if (fft.getBand(0) > 26) {
    changeCamera();
  }


  rotate.x += random(-1, 1)*fft.getBand(4)*0.001;
  rotate.y += random(-1, 1)*fft.getBand(4)*0.001;
  rotate.z += random(-1, 1)*fft.getBand(4)*0.001;

  background(40);

  lights();
  translate(width/2, height/2, camDist);
  rotateX(rotate.x);
  rotateY(rotate.y);
  rotateZ(rotate.z);

  int tt = 80;
  stroke(0, 8);
  for (int i = 0; i < cubes.size (); i++) {
    PVector pos = cubes.get(i);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    fill(random(220, 256));
    box(tt);    
    popMatrix();
  }

  glow.set("intensity", pow(fft.getBand(2)*0.01, 2));
  filter(glow);
  filter(vignette);
}

void generarCubes() {
  cubes = new ArrayList<PVector>();
  int cc = int(random(3, 100));
  int tt = 80;
  for (int i = 0; i < cc; i++) {
    float x = random(-width/1.2, width/1.2);
    float y = random(-width/1.2, width/1.2);
    float z = random(-width/1.2, width/1.2);
    x -= x%tt;
    y -= y%tt;
    z -= z%tt;
    cubes.add(new PVector(x, y, z));
  }
}

void changeAngle() {
  rotate.x = random(-PI/2, PI/2);
  rotate.y = random(-PI/2, PI/2);
  rotate.z = random(-PI/2, PI/2);
}

void changeCamera() {
  camDist = random(-800, -100);
  camVel = random(-1, 1);
  float fov = PI/(random(1, random(2, 10)));
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*100.0);
}

void keyPressed() {
  if (key == 's') saveImage();
}

void saveImage() {
  int n = (new File(sketchPath+"/export")).listFiles().length+1;
  saveFrame("export/"+nf(n, 4)+".png");
}

