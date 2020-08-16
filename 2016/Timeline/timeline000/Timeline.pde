class Timeline {
  
  boolean hide = false;
  //playing and time
  boolean playing = true;
  boolean loop = true;
  float currentTime = 0;
  float sceneTime = 20;
  
  //json
  String jsonName = "data.json";

  Timeline() {
  }

  void update() {
    
    if(playing) {
       currentTime += 1./60;
       if(currentTime > sceneTime){
          if(loop){
             currentTime = 0; 
          }else {
             currentTime = sceneTime; 
          }
       } 
    }
    
    show();
  }

  void show() {
    noStroke();
    fill(60);
    rect(0, height-200, width, 200);
    stroke(250);
    float posX = map(currentTime, 0, sceneTime, 0, width);
    line(posX, height-200, posX, height);
  }
  
  void loadJson(){
    
  }
  
  void saveJson(){
    
  }
}

abstract class Value{
   String name;
   abstract void loadJson(JSONObject json);
   abstract JSONObject saveJson();
}