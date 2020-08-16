PImage img1, img2;


/*
  COLORBURN not found
 COLORDODGE not found
 */
void setup() {
  size(600, 600);
  img1 = loadImage("keyfob_orig.png");
  img2 = loadImage("duck_orig.png");
  if (true) {
    pushStyle();
    colorMode(HSB, 360, 100, 100);
    img1.loadPixels();
    img2.loadPixels();
    for (int j = 0; j < img1.height; j++) {
      for (int i = 0; i < img1.width; i++) {
        img1.set(i, j, color(j*1./img1.height*360));
        img2.set(i, j, color(i*1./img1.width*360, 100, 100));
      }
    } 
    img1.updatePixels();
    img2.updatePixels();
    popStyle();
  }
}

void draw() {
}

void keyPressed() {
  if (key >= 48 && key <58) {
    blendMode = key-48;
  }
  if (keyCode == UP) {
    blendMode++;
    if (blendMode >= 18) blendMode = 0;
  }
  if (keyCode == DOWN) {
    blendMode--;
    if (blendMode < 0) blendMode = 17;
  }
  generar();
}

int BLEND = 0;
int REPLACE = 1;

int DARKEN = 2;
int MULTIPLY = 3;
int COLORBURN = 4;
int LINEARBURN = 5;

int LIGHTEN = 6;
int SCREEN = 7;
int COLORDODGE = 8;
int LINEARDODGE = 9;

int OVERLAY = 10;
int SOFTLIGHT = 11;
int HARDLIGHT = 12;
int VIVIDLIGHT = 13;
int LINEARLIGHT = 14;
int PINLIGHT = 15;

int DIFFERENCE = 16;
int EXCLUSION = 17;

int blendMode = 0;

void generar() {
  background(200);
  fill(0);
  text(blendMode, 10, height-30);

  int sx = 20;
  int sy = 20;

  for (int j = 0; j < img1.height; j++) {
    for (int i = 0; i < img1.width; i++) {
      color c1 = img1.get(i, j);
      color c2 = img2.get(i, j);
      color nc = color(0);
      if (blendMode == BLEND) {
        nc = lerpColor(c1, c2, alpha(c2)/256.);
      } else if (blendMode == REPLACE) {
        nc = c2;
      } else if (blendMode == DARKEN) {
        nc = color(min(red(c1), red(c2)), min(green(c1), green(c2)), min(blue(c1), blue(c2)));
      } else if (blendMode == MULTIPLY) {
        nc = color((red(c1)*red(c2))/255, (green(c1)*green(c2))/255, (blue(c1)*blue(c2))/255);
      } else if (blendMode == COLORBURN) {
        float r = 0;
        float g = 0;
        float b = 0;
        if (red(c2) > 0)
          r = 255-(255-red(c1))/red(c2);
        if (green(c2) > 0)
          g = 255-(255-green(c1))/green(c2);
        if (blue(c2) > 0)
          b = 255-(255-blue(c1))/blue(c2);
        //if (r < 0) r = 0;
        //if (g < 0) g = 0;
        //if (b < 0) b = 0;
        nc = color(r, g, b);
      } else if (blendMode == LINEARBURN) {
        float r = (red(c2)+red(c1) < 255 ) ? 0 : red(c2)+red(c1)-255;
        float g = (green(c2)+green(c1) < 255 ) ? 0 : green(c2)+green(c1)-255;
        float b = (blue(c2)+blue(c1) < 255 ) ? 0 : blue(c2)+blue(c1)-255;
        nc = color(r, g, b);
      } else if (blendMode == LIGHTEN) {
        nc = color(max(red(c1), red(c2)), max(green(c1), green(c2)), max(blue(c1), blue(c2)));
      } else if (blendMode == SCREEN) {
        float r = 255-((255-red(c1))*(255-red(c2)))/255;
        float g = 255-((255-green(c1))*(255-green(c2)))/255;
        float b = 255-((255-blue(c1))*(255-blue(c2)))/255;
        nc = color(r, g, b);
      } else if (blendMode == COLORDODGE) {
        float r = 255;
        float g = 255;
        float b = 255;
        if (red(c2) < 255) {
          r = ((red(c1))/(255-red(c2)));
          if (r > 255) r = 255;
        }
        if (green(c2) < 255) {
          g = ((green(c1))/(255-green(c2)));
          if (g > 255) g = 255;
        }
        if (blue(c2) < 255) {
          b = ((blue(c1))/(255-blue(c2)));
          if (g > 255) g = 255;
        }
        nc = color(r, g, b);
      } else if (blendMode == LINEARDODGE) {
        nc = color(min(red(c1)+red(c2), 255), min(green(c1)+green(c2), 255), min(blue(c1)+blue(c2), 255));
      } else if (blendMode == DIFFERENCE) {
        nc = color(abs(red(c2)-red(c1)), abs(green(c2)-green(c1)), abs(blue(c2)-blue(c1)));
      } else if (blendMode == EXCLUSION) {
        float r = red(c2)+red(c1)-2*red(c2)*red(c1)/255.;
        float g = green(c2)+green(c1)-2*green(c2)*green(c1)/255.;
        float b = blue(c2)+blue(c1)-2*blue(c2)*blue(c1)/255.;
        nc = color(r, g, b);
      }
      /*
      else if(blendMode == DIVIDE){
       int r = int(256*red(c2))/int(red(c1)+1);
       int g = int(256*green(c2))/int(green(c1)+1);
       int b = int(256*blue(c2))/int(blue(c1)+1);
       nc = color(r, g, b);
       }else if(blendMode == SCREEN){
       int r = 255-(int(256-red(c1))*int(256-red(c2)))/255;
       int g = 255-(int(256-green(c1))*int(256-green(c2)))/255;
       int b = 255-(int(256-blue(c1))*int(256-blue(c2)))/255;
       nc = color(r, g, b);
       }
       */
      set(sx+i, sy+j, nc);
    }
  }
}

