// añadir elementos en tiles
// añadir frutas
// añadir pinches
// añadir plataformas que se caen
// añadir enemigos que se muevan
// añadir habitaciones
// añadir seed 
// añadir fog



Camera camera;
Global global;
Input input;
Player player;
World world;


PShader fogLines, fogColor;

void setup() {
  size(1280, 720, P3D);
  smooth(4);


  fogLines = loadShader("fogLines.glsl");
  fogColor = loadShader("fogColor.glsl");

  global = new Global();
  input = new Input();

  reset();
}

void draw() {

  global.update();
  input.update();


  int feed = -int(cos(global.time)*80+30);
  //blendMode(ADD);
  tint(255, 1);
  copy(feed, feed, width-feed*2, height-feed*2, 0, 0, width, height);
  //blendMode(NORMAL);
  noTint();



  float det = 0.0002;
  int backColor = getColor(noise(player.position.x*det, player.position.z*det, global.time*0.001)*colors.length*2);
  int ligthCol = lerpColor(backColor, color(180), 0.8);
  ambientLight(red(ligthCol), green(ligthCol), blue(ligthCol));
  directionalLight(127, 127, 127, 0, 0, -1);
  lightFalloff(1, 0, 0);
  lightSpecular(0, 0, 0);

  //background(backColor);
  //fog(backColor);



  //background(lerpColor(backCol, color(255), 0.8));//sin(global.time*50)*0.5+0.5));
  //lights();

  camera.update();

  world.update();
  world.show();

  player.update();
  player.show();
}

void fog(int backColor) {

  float fogNear = 1200;
  float fogFar = 4000;
  fogLines.set("fogColor", red(backColor)/256., green(backColor)/256., blue(backColor)/256.);
  fogLines.set("fogNear", fogNear); 
  fogLines.set("fogFar", fogFar);
  shader(fogLines, LINES);
  fogColor.set("fogColor", red(backColor)/256., green(backColor)/256., blue(backColor)/256.);
  fogColor.set("fogNear", fogNear); 
  fogColor.set("fogFar", fogFar);
  shader(fogColor);
}

void reset() {
  camera = new Camera();
  player = new Player(0, -500, 0);
  world = new World();
}

void keyPressed() {
  input.pressed();
}

void keyReleased() {
  input.released();
}
