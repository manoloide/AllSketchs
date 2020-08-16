class Hud {

  Map map;

  String message;
  float timeMessage;
  float alphaMessage;

  Hud() {
    map = new Map();
  }
  void update() {
    map.update();
    updateMessage();
  }
  void show() {

    audio.show();
    
    fill(lerpColor(world.backColor, color(0), 0.6));
    textSize(20);
    textAlign(LEFT, TOP);
    text("FPS: "+nf(frameRate, 2, 2), 20, 20);

    if (alphaMessage > 0) {
      fill(0, alphaMessage*256);
      textAlign(LEFT, TOP);
      text(message, 20, 40);
    } 

    map.show();
  }

  void updateMessage() {
    timeMessage -= 1./60;

    if (timeMessage > 0) alphaMessage = lerp(alphaMessage, 1, 0.1);
    else alphaMessage = lerp(alphaMessage, 0, 0.1);
  }

  void message(String msg, float time) {
    message = msg;
    timeMessage = time;
  }
}
