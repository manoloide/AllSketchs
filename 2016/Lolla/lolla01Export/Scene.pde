class Scene {
  int frame;
  float time, antTime;
  Scene() {
    frame = 0;
    time = 0;
    antTime = mill;
  }
  void update() {
    frame++; 
    float millis = mill;
    time += (millis-antTime);
    antTime = millis;
  }
  void show() {
  }

  void generate() {
  }
}

int paleta[][] = {
  {
    #0A1A3D, 
    #FF2B67, 
    #FB7A63, 
    #F7C95E
  }
  , 
  {
    #6FE7DD, 
    #3490DE, 
    #6639A6, 
    #521262
  }
  , 
  {
    #303841, 
    #3A4750, 
    #F6C90E, 
    #EEEEEE
  }
  , 
  {
    #FF6138, 
    #FFFF9D, 
    #BEEB9F, 
    #79BD8F
  }
  , 
  {
    #26252C, 
    #E54861, 
    #F2A379, 
    #EFD5B7
  }
  , 
  {
    #08D9D6, 
    #252A34, 
    #FF2E63, 
    #EAEAEA
  }
  , 
  {
    #2C2D34, 
    #E94822, 
    #F2910A, 
    #EFD510
  }
  , 
  {
    #364F6B, 
    #3FC1C9, 
    #F5F5F5, 
    #FC5185
  }
  , 
  {
    #3EC1D3, 
    #F6F7D7, 
    #FF9A00, 
    #FF165D
  }
  , 
  {
    #EFF2DD, 
    #FCDA05, 
    #EE4848, 
    #5C3551
  }
};
int palet = int(random(paleta[0].length)); 

int rcol() {
  return paleta[palet][int(random(paleta[0].length))];
}