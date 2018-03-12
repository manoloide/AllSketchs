void setup()
{
  size(400, 400, P3D);
  colorMode(RGB, 1.0);
  frameRate(60);
}

float xoffset = 0.0;
float yoffset = 0.0;
float zoffset = 0.0;
float zoom    = 0.01;

final float hi2Thresh = 0.7;
final float hiThresh  = 0.505;
final float loThresh  = 0.495;
final float lo2Thresh = 0.3;

boolean bPaused = false;

void keyPressed() {
  bPaused = !bPaused;
}

void draw()
{
  final color colInside2  = color(0.6, 0.8, 0.0);
  final color colInside   = color(0.3, 0.4, 0.0);
  final color colOutside  = color(0, 0.55, 0.75);
  final color colOutside2 = color(0, 0.225, 0.375);
  final color colIso      = color(1.0, 1.0, 1.0);
  int   index;
  float pnoise;

  if ( mousePressed ) {
    if ( mouseButton == LEFT ) {
      xoffset -= 0.001 * ((width /2.0) - mouseX);
      yoffset -= 0.001 * ((height/2.0) - mouseY);
    } 
    else if ( mouseButton == RIGHT ) {
      zoom -= 0.00001 * ((height/2.0) - mouseY);
      if ( zoom < 0.001 ) {
        zoom = 0.001;
      } 
      else if ( zoom > 0.05 ) {
        zoom = 0.05;
      }
    }
  }

  loadPixels();
  for (int y=0; y < height; y++) {
    for (int x=0; x < width; x++) {
      index = width * y + x;
      pnoise = noise(zoom*x +xoffset, zoom*y +yoffset, zoffset);
      if ( pnoise > hi2Thresh ) {
        pixels[index] = colInside2;
      } 
      else if ( pnoise > hiThresh ) {
        pixels[index] = colInside;
      } 
      else if ( pnoise > loThresh ) {
        pixels[index] = colIso;
      } 
      else if ( pnoise > lo2Thresh ) {
        pixels[index] = colOutside;
      } 
      else {
        pixels[index] = colOutside2;
      }
    }
  }
  updatePixels();
  if ( !bPaused ) {
    zoffset += 0.005;
  }
}

