// camera in the map
// añadir puntos en el mundo, y añadir indicador en el mapa para que te den ganas de juntarlos.
// mejorar el hud
// arreglar el culling, optimizar el terreno, dibujar solo un side.
// añadir texture shader, fixed fog
// añadir movimiento mas spacial 3d
// generar naves
// crear ciudades
// añadir disparos
// añadir fade culling 
// añadir portales a otros mundos, crear arbol de universos.
// añadir time in/out en los tiles para poder añadir animaciones de entrada y salida
// añadir mapa isometrico, fondo oscuro, dibujar doble puntos para senscion de luz
// guardar los puntos de la nave y trazar las linea en el mapa, probar gradient
// añadir zonas y definirlas con un color, hacer fade con el color de fondo, ejemplo rosa es zona amigable, azul es la oscuridad, amarillo es toxica pero hay dinero.
// probar hacer las naves por dentro, camara hud, vista top, 3d, 
// escape abre el menu, volumen, y settings
// añadir intro animada interactiva, ir de los simple a lo complejo, probar arrancas con un punto e ir abriendolo
// añadir colisiones con el terreno
// seleccionar paleta al comenzar el juego




import org.processing.wiki.triangulate.*;
import peasy.PeasyCam;

ArrayList<Chunk> chunks;
ArrayList<Gem> gems;
Camera camera;
Hud hud;
Ship ship;
String scene = "GAME";
Particles particles;
World world;

float globalTime;
float size = 6000;
boolean activeParticles = true;

PeasyCam cam;
PFont font;
PShader fogLines, fogColor;
int keyPress = key;


AudioData audio;
Minim minim;


PJOGL pgl;
//GL2ES2 gl;

void setup() {

  size(1280, 720, P3D);
  //size(960, 540, P3D);
  //fullScreen(P3D);
  smooth(4);
  hint(ENABLE_STROKE_PERSPECTIVE);
  hint(DISABLE_DEPTH_SORT);
  imageMode(CENTER);
  rectMode(CENTER);

  pgl = (PJOGL) beginPGL();  
  //pgl.gl.
  //gl = pgl.gl.getGL2ES2();
  cam = new PeasyCam(this, 400);
  cam.setMinimumDistance(180);
  cam.setMaximumDistance(900);

  minim = new Minim(this);
  audio = new AudioData();

  fogLines = loadShader("fogLines.glsl");
  fogColor = loadShader("fogColor.glsl");

  font = createFont("fonts/Chivo-Light.ttf", 200, true);
  textFont(font);
  textAlign(CENTER, CENTER);
  textSize(200);

  changeScene("GAME");

  generate();
}

void generate() {
  randPallet();
  camera = new Camera();
  cam.reset();
  hud = new Hud();
  ship = new Ship(0, 0, 0);
  particles = new Particles();
  world = new World();

  chunks = new ArrayList<Chunk>();
  //chunks.add(new Chunk(0, 0, 0));
  for (int k = -1; k < 2; k++) {
    for (int j = -1; j < 2; j++) {
      for (int i = -1; i < 2; i++) {
        chunks.add(new Chunk(i, j, k));
      }
    }
  }

  gems = new ArrayList<Gem>();  
  for (int i = 0; i < 100; i++) {
    float xx = random(-10000, 10000);
    float yy = random(-10000, 10000);
    float zz = random(-10000, 10000);
    gems.add(new Gem(xx, yy, zz));
  }
}


void draw() {



  globalTime = millis()*0.001;
  audio.update();




  if (scene.equals("GAME")) {
    //if (frameCount%(60*10) == 0) world.generate();

    pushMatrix();
    background(world.backColor);
    fog();
    //lights();
    camera.update();
    world.update();


    for (int i = 0; i < chunks.size(); i++) {
      Chunk c = chunks.get(i);
      c.update();
      c.show();
    }

    ship.update();
    ship.show();

    if (activeParticles) {
      particles.update();
      particles.show();
    }

    for (int i = 0; i < gems.size(); i++) {
      Gem g = gems.get(i);
      g.update(); 
      g.show();
      if (g.remove) gems.remove(i--);
    }


    //TITLES
    String titles[] = {"Manoloide", "presents:", "NODATA"};
    textSize(70);
    fill(0);
    for (int i = 0; i < 3; i++) {
      text(titles[i], 0, -220, (-i-1)*size);
    }


    popMatrix();
  } else if (scene.equals("MAP")) {
    background(10);
  }



  cam.beginHUD();
  //map.update();
  //map.show();

  hud.update();
  hud.show();

  cam.endHUD();
}

void keyPressed() {

  if (key == 'w') ship.up = true;
  if (key == 's') ship.down = true;
  if (key == 'a') ship.left = true;
  if (key == 'd') ship.right = true;
  if (key == 'q') ship.in = true;
  if (key == 'e') ship.out = true;

  if (key == 'p') activeParticles = !activeParticles;

  if (key == 'c') saveImage();
  if (key == 'r') generate();
  if (key == 'g') world.generate();
  if (key == 'm') hud.map.active();
}

void keyReleased() {

  if (key == 'w') ship.up = false;
  if (key == 's') ship.down = false;
  if (key == 'a') ship.left = false;
  if (key == 'd') ship.right = false;
  if (key == 'q') ship.in = false;
  if (key == 'e') ship.out = false;
}

void changeScene(String newScene) {
  //CameraState state = camera.getState(); 
  scene = newScene;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  timestamp = timestamp+"-"+world.seed+".png";
  hud.message("Save Capture: "+timestamp, 6);
  saveFrame(timestamp);
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
//int colors[] = {#0E1619, #024AEE, #FE86F0, #FD4335, #F4F4F4};
//int colors[] = {#F7DF04, #EAE5E5, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
int colors[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6, #fac62a}; 

//https://coolors.co/ff8eff-f7f718-92ccbc-0c0002-1544a3
//int colors[];
int colors1[] = {#ff8eff, #f7f718, #92ccbc, #0c0002, #1544a3};
int colors2[] = {#060B06, #0806A8, #8ABCF9, #FBDADE, #FF2705};
int colors3[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6, #fac62a};

void randPallet() {
  int rnd = int(random(3));
  if (rnd == 0) colors =  colors1;
  if (rnd == 1) colors =  colors2;
  if (rnd == 2) colors =  colors3;
}
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v); 
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 3));
}

void fog() {

  float fogNear = 2000;
  float fogFar = 8000;

  int backColor = world.backColor;
  fogLines.set("fogColor", red(backColor)/256., green(backColor)/256., blue(backColor)/256.);
  fogLines.set("fogNear", fogNear); 
  fogLines.set("fogFar", fogFar);
  shader(fogLines, LINES);
  fogColor.set("fogColor", red(backColor)/256., green(backColor)/256., blue(backColor)/256.);
  fogColor.set("fogNear", fogNear); 
  fogColor.set("fogFar", fogFar);
  shader(fogColor);
}
