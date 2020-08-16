import peasy.PeasyCam;
PeasyCam cam;

ArrayList<Particle> particles;
float time = 0;

void setup() {
  size(960, 540, P3D);
  smooth(8);
  cam = new PeasyCam(this, 900);
  
  generate();
}

void draw() {
  time = millis()*0.001;
  background(0);
  noFill();
  stroke(80);
  box(width*0.8, height*0.8, height*0.8);
  
  for(int i = 0; i < particles.size(); i++){
     Particle p = particles.get(i);
     p.update();
     p.show();
  }
}

void keyPressed(){
  generate();  
}

void generate(){
   particles = new ArrayList<Particle>();
   for(int i = 0; i < 400; i++){
     particles.add(new Particle());
   }
}
