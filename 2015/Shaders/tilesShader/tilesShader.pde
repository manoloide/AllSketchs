import javax.media.opengl.GL;
import javax.media.opengl.GL2;
 

int paleta[] = {
  #000000, 
  #956830, 
  #7BBF5A, 
  #838383
};
int tileSize = 20;
int colorSel;
PImage tiles;

PGraphics render;
PShader shaderTile;

void setup() {
  size(800, 600, P2D);  
  tiles = createImage(32, 32, RGB);
  createTiles();
  render = createGraphics(width, height, P2D);
  shaderTile = loadShader("shaderTile3.glsl");
  shaderTile.set("iResolution", float(width), float(height));
  shaderTile.set("tilesResolution", float(tiles.width), float(tiles.height));
  shaderTile.set("tileSize", float(tileSize));
  
  PGraphicsOpenGL pgl = (PGraphicsOpenGL)g;  
  
  GL gl = ((PJOGL)beginPGL()).gl.getGL();
  
  //gl.glDisable(GL.GL_DEPTH_TEST);
  gl.glDisable(GL.GL_BLEND);
  endPGL();
  //gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE);

  
}

void draw() {
  frame.setTitle("fps: "+frameRate);
  background(80);
  drawTiles();
  drawGui();
}

void mouseClicked() {
  int xx = mouseX/tileSize;
  int yy = mouseY/tileSize; 
  tiles.loadPixels();
  tiles.set(xx, yy, paleta[colorSel]);
  tiles.updatePixels();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  colorSel = int(colorSel-e)%paleta.length;
  if (colorSel < 0) colorSel = paleta.length-1;
}

void drawTiles() {
  shaderTile.set("iGlobalTime", millis() / 1000.0);
  shaderTile.set("tiles", tiles);
  render.beginDraw();
  render.background(100);
  render.filter(shaderTile);
  render.endDraw();
  image(render, 0, 0);
  
  tint(256, 100);
  image(tiles, 0, 0, tiles.width*tileSize, tiles.height*tileSize);
  noTint();
}

void drawGui() {
  for (int i = 0; i < paleta.length; i++) {
    float tt = 40;
    float sep = 10;
    float dx = (sep*paleta.length+tt*(paleta.length-1))/2;
    float x = width/2 + i*(tt+sep)-dx;
    float y = height-sep-tt;
    strokeWeight(2);
    stroke(140);
    if (i == colorSel) {
      strokeWeight(4);
      stroke(200);
    }
    fill(paleta[i]);
    rect(x, y, tt, tt, 3);
  }
  image(tiles, 20, 20);
}

void createTiles() {
  tiles.loadPixels();
  for (int j = 0; j < tiles.height; j++) {
    for (int i = 0; i < tiles.width; i++) {
      color col = color(paleta[int(random(paleta.length))]);
      col = paleta[(i+j)%paleta.length];
      tiles.set(i, j, col);
    }
  }
  tiles.updatePixels();
}
