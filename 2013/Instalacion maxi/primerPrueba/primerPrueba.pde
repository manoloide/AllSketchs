PImage[] pics;
float px = 0;
float zoom = 0;

void setup() {
  size(800, 600);
  frameRate(30);
  String path = sketchPath+"\\data"+"\\"; 
  File[] files = listFiles(path);
  //print(path+"\n"); 

  pics=new PImage[files.length];
  for (int i=0;i<files.length;i++) {
    println(files[i]); 
    pics[i]=loadImage(files[i].getAbsolutePath());
  }
  //blendMode(SCREEN );
}

void draw() {
  float iw = 2500; 
  px -= (mouseX-width/2)/10;
  if (px >= iw) {
    px -= iw;
  }
  else if (px < 0) {
    px += iw;
  }
  if (mousePressed) {
    zoom += 0.01;
  }
  else if (zoom > 0) {
    zoom -= 0.02;
  }
  else if ( zoom < 0) {
    zoom = 0;
  }
  int val = int(random(pics.length));
  float zw = iw + iw*zoom;
  float zh = height + height*zoom;
  float py = map(mouseY, 0, height, 0, -(height*zoom));
  image(pics[val], px, py, zw, zh);
  image(pics[val], px-iw, py, zw, zh);
  image(pics[val], px+iw, py, zw, zh);
  println(py);
}

File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } 
  else {
    return null;
  }
}

