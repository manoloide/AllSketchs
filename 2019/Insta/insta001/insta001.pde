Camera camera;
Scene scene;

void setup(){
  size(960, 540, P3D);  
  pixelDensity(2);
  smooth(8);¡
  
  camera = new Camera();
  scene = new Scene01();
}


void draw(){
  
  background(0);
  
  camera.begin();
  scene.update();
  scene.show();
  camera.end();
  
}

void keyPressed(){
   if(key == 1) camera.presset(1);
   if(key == 2) camera.presset(1);
   if(key == 3) camera.presset(1); 
}
