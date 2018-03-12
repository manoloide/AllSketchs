/*
  Manoloide 2014
  manoloide@gmail.com
  
  lista:
    - Intentar validar shader antes de aplicarlos
    - Agregar scroll para cuando hay muchos shaders;
*/  

import java.awt.Frame;

boolean record, load;
double folderTime;
File folderShader;
float desmouse = 0.5;
String dirFolderShaders;
String[] shadersNames;
String[] shadersPaths;
ViewShader vs1, vs2;

void setup() {
  size(480, 480, P2D);
  frameRate(60);
  record = false;
  
  dirFolderShaders = sketchPath("shaders/");
  loadFolderShader();

  vs1 = new ViewShader(shadersPaths[0]);
  vs2 = new ViewShader(shadersPaths[1]);


  PFrame f = new PFrame();
}

void draw() {
  if (frameCount%20 == 0) frame.setTitle("FPS: "+frameRate);

  vs1.update();
  vs2.update();
  if (desmouse < 0.5) {
    noTint();
    image(vs1.gra, 0, 0);
    tint(255, desmouse*256);
    image(vs2.gra, 0, 0);
  } else {
    noTint();
    image(vs2.gra, 0, 0);
    tint(255, 255-desmouse*256);
    image(vs1.gra, 0, 0);
  }
  if (record) {
    int n = (new File(sketchPath+"/video")).listFiles().length+1;
    saveFrame("video/"+nf(n, 4)+".png");
  }
  if (folderShader.listFiles().length != shadersNames.length) {
    loadFolderShader();
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'r') record = !record;
}

void loadFolderShader() {
  load = true;
  folderShader = new File(dirFolderShaders);
  File files[] = folderShader.listFiles();
  shadersNames = new String[files.length];
  shadersPaths = new String[files.length];
  for (int i = 0; i < files.length; i++) {
    shadersNames[i] = split(files[i].getName(), ".")[0];
    shadersPaths[i] = files[i].getAbsolutePath();
  }
  load = false;
}

void saveImage() {
  int n = (new File(sketchPath+"/export")).listFiles().length+1;
  saveFrame("export/"+nf(n, 4)+".png");
}
