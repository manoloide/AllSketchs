class Scene {
  int frame;
  float time, antTime;
  Scene() {
    frame = 0;
    time = 0;
    antTime = millis();
  }
  void update() {
    frame++; 
    float millis = millis();
    time += (millis-antTime)/1000.;
    antTime = millis;
  }
  void show() {
    
  }
  
  void generate(){ 
    
  }
}
