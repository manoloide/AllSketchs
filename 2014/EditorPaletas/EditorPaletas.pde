import manoloide.Color.Paleta;
import manoloide.Input.Input;

ArrayList<Paleta> paletas, paletascl;
boolean clact;
CampoTexto titulo;
Colorlovers colorLovers;
EditorColor editorColor;
EditorPaleta editorPaleta;
Generativo generativo;
JSONArray jpaletas;
JSONArray jcl;
Input input;
int pestana, cl_pestana;
Lista lista, listacl;
Paleta selecionado;
PFont fontG, fontC;

void setup() {
  size(800, 600);
  smooth(8);
  pestana = 0;
  input = new Input(this);
  cargar();
  lista = new Lista(width-200, 0, 200, height);
  selecionado = paletas.get(2);
  colorLovers = new Colorlovers(8, 8, width-216, 528);
  generativo = new Generativo(8, 8, width-216, 528, selecionado);
  editorColor = new EditorColor();
  editorPaleta = new EditorPaleta(selecionado);
  titulo = new CampoTexto(20, 26, 560, "hola cosa");
  noStroke();
  fontG = createFont("Helvetica Neue Bold", 54, true);
  fontC = createFont("Helvetica Neue Bold", 16, true);

  actCl();
}

void draw() {
  background(80);
  if (pestana == 0) {
    lista.act();
    editorPaleta.act();
    editorColor.act();
    fill(10);
    rect(8, 8, width-216, 80, 10, 10, 0, 0);
    for (int i = 0; i < selecionado.size; i++) {
      fill(selecionado.get(i));
      rect(width-216-(selecionado.size*12)+i*12, 8, 8, 18);
    }
    titulo.val = selecionado.name;
    titulo.act();
    selecionado.name = titulo.val;
  } else if (pestana == 1) {
    lista.act();
    generativo.cambiarPaleta(selecionado);
    generativo.act();
  } else if (pestana == 2) {
    colorLovers.act();
    lista.act();
  }
  strokeWeight(3);
  float dis = 20;
  int cant = 3;
  for (int i = 0; i < cant; i++) {
    float x = (width-200)/2+(dis*i)-(dis*cant)/2;
    float y = height-36;
    if (dist(mouseX, mouseY, x, y) < 8) {
      if (input.click) pestana = i;
    }
    if (pestana == i) {
      stroke(250); 
      fill(160);
    } else {
      stroke(140);
      fill(120);
    }
    ellipse(x, y, 10, 10);
  }
  input.update();
}

void dispose() {
  guardar();
  println("se guardo");
}

void keyPressed() {
  if (key == 's') {
    saveFrame("####");
  }
  /*
  Paleta aux = new Paleta();
   if (aux.load(sketchPath+"/dadas.plt"))
     paletas.add(aux);*/
   input.event(true);
 }
 void keyReleased() {
  input.event(false);
}
void mousePressed() {
  input.mpress();
}
void mouseReleased() {
  input.mreleased();
}

void actCl() {
  colorLovers.actCl();
}

void cargar() {
  if (fileExists(sketchPath+"/paletas.json")) {
    jpaletas = loadJSONArray("paletas.json");
    paletas = new ArrayList<Paleta>();
    for (int i = 0; i < jpaletas.size (); i++) {
      JSONObject paleta = jpaletas.getJSONObject(i);
      Paleta aux = new Paleta(paleta.getString("nombre"));
      JSONArray colores = paleta.getJSONArray("colores");
      for (int j = 0; j < colores.size (); j++) {
        aux.add(colores.getInt(j));
      }
      paletas.add(aux);
    }
  } else {
    paletas = new ArrayList<Paleta>();
    paletas.add(new Paleta("a king&his queen", #03800E, #C1C1C1, #F7FF00, #7F00AC, #000000));
    paletas.add(new Paleta("tea and acoustics", #878971, #787A62, #616648, #383B26, #31351E));
    paletas.add(new Paleta("Quick color sketch49", #4F525F, #FB5772, #FFBF26, #B0E420, #A4E4BF));
  }
}

void guardar() {
  JSONArray nuevo = new JSONArray();
  for (int i = 0; i < paletas.size (); i++) {
    Paleta aux = paletas.get(i);
    JSONObject paleta = new JSONObject();
    paleta.setString("nombre", aux.name);
    JSONArray colores = new JSONArray();
    for (int j = 0; j < aux.size; j++) {
      colores.append(aux.get(j));
    }
    paleta.setJSONArray("colores", colores);
    nuevo.append(paleta);
  }
  saveJSONArray(nuevo, "paletas.json");
}

void cargarPaleta(File f ) {
  if (f != null) {
    Paleta aux = new  Paleta();
    aux.load(f.toString());
    paletas.add(aux);
  }
}

boolean fileExists(String filename) {
  File file = new File(filename);
  if (!file.exists())
    return false;  
  return true;
}

class Colorlovers {
  ArrayList<Paleta> paletascl;
  boolean clact;
  float time_sobre;
  int x, y, w, h, cl_pestana;
  JSONArray jcl;
  String opc[] = {
    "new", "top", "random"
  };
  Colorlovers(int x, int y, int w, int h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
    cl_pestana = 0;
    thread("actCl");
  }
  void act() {
    if (dist(mouseX, mouseY, x+w/2, y+h/2) < 100) {
      time_sobre += 0.06;
      if (time_sobre > 1) time_sobre = 1;
      if (input.click) {
        if (cl_pestana == 2) {
          selecionado = paletascl.get(0);
          lista.sel = paletas.size();
          paletas.add(selecionado);
        }
      }
    } else {
      time_sobre -= 0.06;
      if (time_sobre < 0) time_sobre = 0;
    }
    dibujar();
  }
  void dibujar() {
    float hh = 80; 
    int tt = 48; 
    noStroke();
    if (clact) { 
      for (int i = 0; i < paletascl.size (); i++) {
        fill(10);
        if (i == 0)
          rect(x, y+i*hh, w, hh, 10, 10, 0, 0);
        else
          rect(x, y+i*hh, w, hh);
        Paleta aux = paletascl.get(i);
        for (int j = 0; j < aux.size; j++) {
          fill(aux.get(j));
          rect(width-216-(aux.size*12)+j*12, 8+i*hh, 8, 18);
        }
        fill(250);
        textFont(fontG);
        textAlign(LEFT, TOP);
        text(aux.name, x+20, y+26+i*hh);
      }
      if (cl_pestana == 2) {
        Paleta p = paletascl.get(0);
        int cc = p.size;
        float www = w*1./cc;
        float hhh = h-hh-tt;
        noStroke();
        for (int i = 0; i < cc; i++) {
          fill(p.get(i));
          rect(x+www*i, y+hh, www, hhh);
        }
      }
      fill(250, time_sobre*120);
      circuloCruz(x+w/2, y+h/2, 200, 0.7, 0.3);
    } else {
      float xx = x+w/2;
      float yy = y+h*0.5;
      float rad = 36;
      int cant = 6;
      float tam = 22;
      float val = (frameCount%30)/30.;
      float da = TWO_PI/cant;
      noStroke();
      for (int i = 0; i < cant; i++) {
        float alp = map((val*cant-i+cant)%cant, 0, cant, 50, 0);
        fill(250, alp);
        ellipse(xx+cos(da*i)*rad, yy+sin(da*i)*rad, tam, tam);
      }
    }
    int cant = opc.length;
    float ww = (w-tt*2.)/cant; 
    float yy = y+h-tt;
    for (int i = 0; i < cant; i++) {
      if (cl_pestana == i) fill(10);
      else fill(200);
      if (i == 0)rect(x+i*ww, y+h-tt, ww, tt, 0, 0, 0, 8);
      else rect(x+i*ww, y+h-tt, ww, tt);
      if (cl_pestana == i) fill(200);
      else fill(10);
      textAlign(CENTER, CENTER);
      textFont(fontC);
      text(opc[i].toUpperCase(), x+i*ww, yy, ww, tt);
      if (input.click && mouseX >= x+i*ww && mouseX <y+i*ww+ww && mouseY >= yy && mouseY < yy+tt) {
        cl_pestana = i;
        thread("actCl");
      }
    }
    fill(40);
    rect(x+cant*ww, yy, tt*2, tt, 0, 0, 8, 0);
    fill(250);
    int dd = 14;
    beginShape();
    vertex(x+cant*ww+dd, yy+tt/2);
    vertex(x+cant*ww+dd+tt*0.5, yy+tt/2-tt*0.3);
    vertex(x+cant*ww+dd+tt*0.5, yy+tt/2+tt*0.3);
    endShape(CLOSE);
    beginShape();
    vertex(x+w-dd, yy+tt/2);
    vertex(x+w-dd-tt*0.5, yy+tt/2-tt*0.3);
    vertex(x+w-dd-tt*0.5, yy+tt/2+tt*0.3);
    endShape(CLOSE);
  }
  void actCl() {
    clact = false;
    String a = opc[cl_pestana];
    jcl = loadJSONArray("http://www.colourlovers.com/api/palettes/"+a+"&format=json&numResults=5");
    paletascl = new ArrayList<Paleta>();
    for (int i = 0; i < jcl.size(); i++) {
      JSONObject pal = jcl.getJSONObject(i);
      Paleta aux = new Paleta(pal.getString("title"));
      JSONArray col = pal.getJSONArray("colors");
      for (int j = 0; j < col.size (); j++) {
        String c = col.getString(j);
        int r = unhex(c.substring(0, 2));
        int g = unhex(c.substring(2, 4));
        int b = unhex(c.substring(4));
        aux.add(color(r, g, b));
      }
      paletascl.add(aux);
    }
    clact = true;
  }
};

class EditorColor {
  color col;
  float time_sobre;
  int x, y, w, h;
  Slide red, gre, blu, hue, sat, bri;
  EditorColor() {
    x = 8;
    y = 236;
    w = width-216;
    h = 300;
    red = new Slide(x+320, y+40, 220, 16);
    gre = new Slide(x+320, y+70, 220, 16);
    blu = new Slide(x+320, y+100, 220, 16);
    hue = new Slide(x+320, y+130, 220, 16);
    sat = new Slide(x+320, y+160, 220, 16);
    bri = new Slide(x+320, y+190, 220, 16);
    time_sobre = 0;
  }
  void act() {
    if (dist(mouseX, mouseY, x+h/2-7, y+h/2) < 75) {
      time_sobre += 0.06;
      if (time_sobre > 1) time_sobre = 1;
      if (input.click) {
        editorPaleta.paleta.add(col);
      }
    } else {
      time_sobre -= 0.06;
      if (time_sobre < 0) time_sobre = 0;
    }
    if (editorPaleta.sel != -1) col = editorPaleta.paleta.get(editorPaleta.sel);
    red.act(red(col)/255.);
    if (red.mover) col = color(red.val*255, green(col), blue(col)); 
    gre.act(green(col)/255.);
    if (gre.mover) col = color(red(col), gre.val*255, blue(col)); 
    blu.act(blue(col)/255.);
    if (blu.mover) col = color(red(col), green(col), blu.val*255); 
    pushStyle();
    colorMode(HSB, 256, 256, 256);
    hue.act(hue(col)/255.);
    if (hue.mover) col = color(255*hue.val, saturation(col), brightness(col));
    sat.act(saturation(col)/255.);
    if (sat.mover) col = color(hue(col), 255*sat.val, brightness(col));
    bri.act(brightness(col)/255.);
    if (bri.mover) col = color(hue(col), saturation(col), 255*bri.val);
    popStyle();
    if (input.click) {
      for (int i = 0; i < 4; i++) {
        color ac = color(0);
        if (mouseX >= x+313+i*60 && mouseX < x+313+i*60+55 && mouseY >= y+230 && mouseY < y+230+55) {
          switch(i) {
            case 0:
            ac = color(255-red(col), 255-green(col), 255-blue(col));
            break;
            case 1:
            ac = color(red(col), 255-green(col), 255-blue(col));
            break;
            case 2:
            ac = color(255-red(col), green(col), 255-blue(col));
            break;
            case 3:
            ac = color(255-red(col), 255-green(col), blue(col));
            break;
          }
          col = ac;
        }
      }
    }
    if (editorPaleta.sel != -1) editorPaleta.paleta.set(editorPaleta.sel, col);
    dibujar();
  }
  void dibujar() {
    pushStyle();
    fill(60);
    rect(x, y, w, h);
    strokeWeight(5);
    stroke(255);
    fill(col);
    rect(x+14, y+20, h-40, h-40, 16);
    noStroke();
    if (red(col)+green(col)+blue(col) < 382)
      fill(250, time_sobre*80);
    else 
      fill(5, time_sobre*80);
    circuloCruz(x+h/2-7, y+h/2, 150, 0.7, 0.3);
    popStyle();
    color ac1, ac2;
    ac1 = color(0, green(col), blue(col));
    ac2 = color(255, green(col), blue(col));
    red.dibujar(ac1, ac2);
    ac1 = color(red(col), 0, blue(col));
    ac2 = color(red(col), 255, blue(col));
    gre.dibujar(ac1, ac2);
    ac1 = color(red(col), green(col), 0);
    ac2 = color(red(col), green(col), 255);
    blu.dibujar(ac1, ac2);
    pushStyle();
    colorMode(HSB, 256, 256, 256);
    ac1 = color(0, saturation(col), brightness(col));
    ac2 = color(255, saturation(col), brightness(col));
    hue.dibujar(ac1, ac2);
    colorMode(HSB, 256, 256, 256);
    ac1 = color(hue(col), 0, brightness(col));
    ac2 = color(hue(col), 255, brightness(col));
    colorMode(RGB);
    sat.dibujar(ac1, ac2);
    colorMode(HSB, 256, 256, 256);
    ac1 = color(hue(col), saturation(col), 0);
    ac2 = color(hue(col), saturation(col), 255);
    colorMode(RGB);
    bri.dibujar(ac1, ac2);
    for (int i = 0; i < 4; i++) {
      switch(i) {
        case 0:
        fill(255-red(col), 255-green(col), 255-blue(col));
        break;
        case 1:
        fill(red(col), 255-green(col), 255-blue(col));
        break;
        case 2:
        fill(255-red(col), green(col), 255-blue(col));
        break;
        case 3:
        fill(255-red(col), 255-green(col), blue(col));
        break;
      }
      rect(x+313+i*60, y+230, 55, 55, 8);
    }
    popStyle();
  }
};

class EditorPaleta {
  boolean sobre;
  int x, y, w, h;
  int sel, cant;
  float tam;
  Paleta paleta;
  EditorPaleta(Paleta paleta) {
    this.paleta = paleta;
    x = 8;
    y = 88;
    w = width-216;
    h = 150;
    sel = -1;
    cant = paleta.size;
    tam = 480./cant;
  }
  void act() {
    paleta = selecionado;
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      sobre = true;
    } else sobre = false;
    if (sobre && input.click) {
      for (int i = 0; i < cant; i++) {
        float xx = x+14+tam*i;
        float yy = y+20;
        float ww = tam;
        float hh = 116;
        if (mouseX >= xx && mouseX < xx+ww && mouseY >= yy && mouseY < yy+hh) {
          if (sel == i) {
            sel = -1;
            break;
          }
          sel = i;
        }
      }
      if (dist(mouseX, mouseY, x+540, y+48) < 25) {
        if (sel != -1) sel = paleta.size;
        paleta.add(color(random(255), random(255), random(255)));
      }
      if (dist(mouseX, mouseY, x+540, y+106) < 25) {
        paleta.remove(sel);
        sel--;
        if (sel < 0) sel = 0;
        cant--;
      }
    }
    cant = paleta.size;
    tam = 480./cant;
    dibujar();
  }
  void dibujar() {
    pushStyle();
    fill(40);
    rect(x, y, w, h);
    for (int i = 0; i < cant; i++) {
      fill(selecionado.get(i));
      if (cant == 1) rect(x+14+tam*i, y+20, tam, 116, 16);
      else {
        if (i == 0) rect(x+14+tam*i, y+20, tam, 116, 16, 0, 0, 16);
        else if (i == cant-1) rect(x+14+tam*i, y+20, tam, 116, 0, 16, 16, 0);
        else rect(x+14+tam*i, y+20, tam, 116);
      }
    }

    strokeWeight(5);
    stroke(4);
    noFill();
    rect(x+14, y+20, 480, 116, 16);
    if (sel != -1) {
      stroke(255);
      if (cant == 1) rect(x+14+tam*sel, y+20, tam, 116, 16);
      else {
        if (sel == 0) rect(x+14+tam*sel, y+20, tam, 116, 16, 0, 0, 16);
        else if (sel == cant-1) rect(x+14+tam*sel, y+20, tam, 116, 0, 16, 16, 0);
        else rect(22+tam*sel, y+20, tam, 116);
      }
    }
    noStroke();
    fill(4);
    ellipse(x+540, y+48, 50, 50);
    fill(255);
    rectMode(CENTER);
    rect(x+540, y+48, 8, 36);
    rect(x+540, y+48, 36, 8);
    fill(4);
    ellipse(x+540, y+106, 50, 50);
    fill(255);
    rect(x+540, y+106, 36, 8);
    popStyle();
  }
};

class Generativo {
  boolean render;
  ColorPorcentaje cp;
  float x, y, w, h;
  float porcentaje_render;
  Paleta paleta;
  PGraphics img;
  Generativo(float x, float y, float w, float h, Paleta paleta) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    this.paleta = paleta;
    render = false;
    cp = new ColorPorcentaje(x, y+h-40, w-90, 40, paleta);
    img = createGraphics(int(w-10), int(y+h-60));
    img.beginDraw();
    img.background(255);
    img.endDraw();
    thread("generar");
  }
  void act() {
    cp.x = x;
    cp.y = y+h-40;
    cp.act();
    if (mouseX >= x+w-90 && mouseX < x+w && mouseY >= y+h-40 && mouseY < y+h) {
      if (input.click && !render) thread("generar");
    }
    dibujar();
  }
  void dibujar() {
    stroke(0, 20);
    noFill();
    for (int i = 0; i < 5; i+=2) {
      strokeWeight(i);
      rect(x, y, w, h, 8);
    }
    strokeWeight(1);
    noStroke();
    fill(255);
    rect(x, y, w, h-40, 8, 8, 0, 0);
    img.beginDraw();
    img.endDraw();
    image(img, x+5, y+5);
    fill(2);
    cp.dibujar();
    fill(20);
    if (mouseX >= x+w-90 && mouseX < x+w && mouseY >= y+h-40 && mouseY < y+h) {
      fill(25);
    }
    rect(x+w-90, y+h-40, 90, 40, 0, 0, 8, 0);
    fill(255);
    textAlign(CENTER, CENTER);
    text("GENERAR", x+w-90, y+h-40, 90, 36);
    if (render) {
      noStroke();
      fill(0, 120);
      rect(x, y, w, h, 8);
      stroke(50);
      strokeWeight(26);
      line(w/2-100, h/2, w/2+100, h/2);
      stroke(20);
      strokeWeight(20);
      line(w/2-100, h/2, w/2+100, h/2);
      stroke(140);
      line(w/2-100, h/2, w/2-100+200*porcentaje_render, h/2);
    }
  }
  void cambiarPaleta(Paleta paleta) {
    if (this.paleta != paleta) {
      this.paleta = paleta;
      cp.cambiarPaleta(paleta);
    }
  }
};

class Lista {
  boolean sobre;
  int x, y, w, h;
  int sel;
  Lista(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    sel = 0;
  }
  void act() {
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      sobre = true;
    } else {
      sobre = false;
    }
    int hl = 28;
    if (sobre && input.click) {
      for (int i = 0; i < paletas.size (); i++) {
        if (mouseY >= y+i*hl && mouseY < y+i*hl+hl) {
          sel = i;
          selecionado = paletas.get(sel);
          editorPaleta.sel = -1;
        }
      }

      float tt = (w/4);
      for (int i = 0; i < 4; i++) {
        if (mouseX >= x+tt*i && mouseX < x+tt*i+tt && mouseY >= h-tt && mouseY < h-tt+tt) {
          switch(i) {
            case 0:
            Paleta aux = new Paleta("Nueva sin titulo");
            int cant = int(random(2, 6));
            for (int j = 0; j < cant; j++) {
              aux.add(color(random(256), random(256), random(256)));
            }
            paletas.add(aux);
            sel = paletas.size()-1;
            selecionado = paletas.get(sel);
            break;
            case 1:
            selectInput("Abrir Paleta...", "cargarPaleta");
            break;
            case 2:
            paletas.remove(sel);
            if (sel == paletas.size()) {
              sel--;
              if (sel < 0 && paletas.size() > 0) {
                sel = 0;
              }
            }
            selecionado = paletas.get(sel);
            break;
            case 3:
            selecionado.save(sketchPath(selecionado.name+".plt"));
            break;
          }
        }
      }
    }
    dibujar();
  }
  void dibujar() {
    noStroke();
    textAlign(LEFT, CENTER);
    textFont(fontC);
    int cant = paletas.size();
    int hl = 28;
    for (int i = 0; i < cant; i++) {
      Paleta aux = paletas.get(i);
      if (i == sel) fill(80);
      else fill(90);
      rect(x, y+i*hl, w, hl);
      fill(255);
      text(aux.name, x+6, y+i*hl, w-20, hl);
      int cantcol = aux.size;
      for (int j = 0; j < cantcol; j++) {
        fill(aux.get(cantcol-j-1));
        rect(x+w-((20./cantcol)*(j+1)), y+i*hl, (20./cantcol), hl);
      }
    }
    fill(70);
    rect(x, y+cant*hl, w, h-50-cant*hl);
    fill(60);
    rect(x, h-50, w, 50);

    float tt = (w/4);
    for (int i = 0; i < 4; i++) {
      fill(120-20*i);
      rect(x+tt*i, h-tt, tt, tt);
    }


    float xx = x+tt/2;
    float yy = h-tt/2;
    fill(250);
    beginShape();
    vertex(xx-tt*0.3, yy-tt*0.35);
    vertex(xx-tt*0.3, yy+tt*0.35);
    vertex(xx+tt*0.3, yy+tt*0.35);
    vertex(xx+tt*0.3, yy-tt*0.20);
    vertex(xx+tt*0.15, yy-tt*0.35);
    endShape(CLOSE);

    float dd = 0.18;
    float gg = 0.05;
    fill(5);
    beginShape();
    vertex(xx-tt*dd, yy-tt*gg);
    vertex(xx-tt*dd, yy+tt*gg);
    vertex(xx-tt*gg, yy+tt*gg);
    vertex(xx-tt*gg, yy+tt*dd);
    vertex(xx+tt*gg, yy+tt*dd);
    vertex(xx+tt*gg, yy+tt*gg);
    vertex(xx+tt*dd, yy+tt*gg);
    vertex(xx+tt*dd, yy-tt*gg);
    vertex(xx+tt*gg, yy-tt*gg);
    vertex(xx+tt*gg, yy-tt*dd);
    vertex(xx-tt*gg, yy-tt*dd);
    vertex(xx-tt*gg, yy-tt*gg);
    endShape(CLOSE);


    xx = x+tt/2+tt;
    fill(250);
    beginShape();
    vertex(xx-tt*0.3, yy-tt*0.35);
    vertex(xx-tt*0.3, yy+tt*0.35);
    vertex(xx+tt*0.3, yy+tt*0.35);
    vertex(xx+tt*0.3, yy-tt*0.20);
    vertex(xx+tt*0.15, yy-tt*0.35);
    endShape(CLOSE);

    dd = 0.18;
    gg = 0.05;
    fill(5);    
    beginShape();
    vertex(xx, yy-tt*dd);
    vertex(xx-tt*dd, yy-gg);
    vertex(xx-tt*gg*1.2, yy-gg);
    vertex(xx-tt*gg*1.2, yy+tt*dd);
    vertex(xx+tt*gg*1.2, yy+tt*dd);
    vertex(xx+tt*gg*1.2, yy-gg);
    vertex(xx+tt*dd, yy-gg);
    endShape(CLOSE);

    xx = x+tt/2+tt*2;
    fill(250);
    beginShape();
    vertex(xx-tt*0.3, yy-tt*0.35);
    vertex(xx-tt*0.3, yy+tt*0.35);
    vertex(xx+tt*0.3, yy+tt*0.35);
    vertex(xx+tt*0.3, yy-tt*0.20);
    vertex(xx+tt*0.15, yy-tt*0.35);
    endShape(CLOSE);

    dd = 0.18;
    gg = 0.05;
    fill(5);
    beginShape();
    vertex(xx-tt*dd, yy-tt*gg);
    vertex(xx-tt*dd, yy+tt*gg);
    vertex(xx+tt*dd, yy+tt*gg);
    vertex(xx+tt*dd, yy-tt*gg);
    endShape(CLOSE);

    xx = x+tt/2+tt*3;
    fill(250);
    beginShape();
    vertex(xx-tt*0.3, yy-tt*0.35);
    vertex(xx-tt*0.3, yy+tt*0.35);
    vertex(xx+tt*0.3, yy+tt*0.35);
    vertex(xx+tt*0.3, yy-tt*0.20);
    vertex(xx+tt*0.15, yy-tt*0.35);
    endShape(CLOSE);

    dd = 0.18;
    gg = 0.05;
    fill(5);    
    beginShape();
    vertex(xx+tt*dd, yy);
    vertex(xx+gg, yy-tt*dd);
    vertex(xx+gg, yy-tt*gg*1.2);
    vertex(xx-tt*dd, yy-tt*gg*1.2);
    vertex(xx-tt*dd, yy+tt*gg*1.2);
    vertex(xx+gg, yy+tt*gg*1.2);
    vertex(xx+gg, yy+tt*dd);
    endShape(CLOSE);
  }
};

void generar() {
  PGraphics img = generativo.img;
  generativo.render = true;
  img.beginDraw();
  for (int i = 0; i < 5000; i++) {
    generativo.porcentaje_render = i/5000.;
    float tam = random(10, 60);
    float x = random(img.width);
    float y = random(img.height);
    int r = int(random(3));
    switch(r) {
      case 0:
      img.noFill();
      img.stroke(0, 8);
      for(int j = 1; j < 5; j++){
        img.strokeWeight(j);
        img.ellipse(x, y, tam, tam);
      }
      img.noStroke();
      img.fill(generativo.cp.rcol());
      img.ellipse(x, y, tam, tam);
      break;
      case 1:
      float s = random(1, 8);
      img.stroke(0, 8);
      for(int j = 1; j < 5; j++){
        img.strokeWeight(s+j);
        img.ellipse(x, y, tam, tam);
      }
      img.stroke(generativo.cp.rcol());
      img.strokeWeight(s);
      img.noFill();
      img.ellipse(x, y, tam, tam);
      break;
      case 2:  
      img.strokeCap(PROJECT); 
      float ss = random(1, 8);   
      float ang = random(TWO_PI);
      img.stroke(0, 8);
      for(int j = 1; j < 5; j++){
        img.strokeWeight(ss+j);
        img.line(x+cos(ang)*tam/2, y+sin(ang)*tam/2, x-cos(ang)*tam/2, y-sin(ang)*tam/2);
        img.line(x+cos(ang+PI/2)*tam/2, y+sin(ang+PI/2)*tam/2, x-cos(ang+PI/2)*tam/2, y-sin(ang+PI/2)*tam/2);
      }
      img.stroke(generativo.cp.rcol());
      img.strokeWeight(ss);
      img.line(x+cos(ang)*tam/2, y+sin(ang)*tam/2, x-cos(ang)*tam/2, y-sin(ang)*tam/2);
      img.line(x+cos(ang+PI/2)*tam/2, y+sin(ang+PI/2)*tam/2, x-cos(ang+PI/2)*tam/2, y-sin(ang+PI/2)*tam/2);
      break;
    }
  }
  img.endDraw();
  generativo.render = false;
}


class ColorPorcentaje {
  boolean sobre, mover;
  float x, y, w, h;
  float[] val;
  int cant, sobre_time, sobv;
  Paleta paleta;
  ColorPorcentaje(float x, float y, float w, float h, Paleta paleta) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
    cambiarPaleta(paleta);
  }
  void act() {
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h)
      sobre = true; 
    else
      sobre = false; 
    if (sobre && input.click) {
      sobv = -1;
      for (int i = 0; i < cant-1; i++) {
        if (abs(mouseX-(x+val[i]*w)) < 6) {
          mover = true; 
          sobv = i;
        }
      }
    }
    if (mover) {
      float pos = mouseX;
      float min = (sobv == 0)? x+6 : x+(val[sobv-1]*w)+6;
      float max = (sobv == cant-1)? x+w-6 : x+val[sobv+1]*w-6;
      pos = constrain(pos, min, max);
      val[sobv] = (pos-x)/w;
    }
    if (input.released) {
      mover = false;
    }
  }
  void dibujar() {
    noStroke();
    for (int i = 0; i < cant; i++) {
      fill(paleta.get(i));
      if (i == 0) rect(x, y, val[i]*w, h, 0, 0, 0, 6);
      else rect(x+val[i-1]*w, y, val[i]*w-val[i-1]*w, h);
    }
    if (sobv != -1) {
      float xx = x+val[sobv]*w;
      fill(2);
      rect(xx-3, y, 2, h);
      rect(xx+1, y, 2, h);
      /*
      rect(xx-3, y, 6, h);
       fill(240);
       rect(xx-1, y, 2, h);
       */
     }
     stroke(0, 30);
     noFill();
     rect(x, y, w, h, 0, 0, 0, 6);
   }
   color rcol() {
    color aux = -1;
    float r = random(1);
    for (int i = 0; i < cant; i++) {
      if (r <= val[i]) return paleta.get(i);
    }
    return aux;
  }
  void cambiarPaleta(Paleta paleta) {
    this.paleta = paleta;
    cant = paleta.size;
    val = new float[cant];
    for (int i = 1; i <= cant; i++) {
      val[i-1] = (i*1./cant);
    }
    sobv = -1;
  }
};

/*
class Key { 
 boolean press, click;
 int clickCount;
 void act() {
 if (!focused) release();
 click = false;
 if (press) clickCount++;
 }
 void press() {
 if (!press) {
 click = true; 
 press = true;
 clickCount = 0;
 }
 }
 void release() {
 press = false;
 }
 void event(boolean estado) {
 if (estado) press();
 else release();
 }
 }
 
 class Input {
 boolean click, dclick, press, released, kclick;
 int pressCount, mouseWheel, timepress;
 Key ENTER, BACKSPACE, ALT, CTRL, SHIFT, ARRIBA, ABAJO, IZQUIERDA, DERECHA;
 Input() {
 click = dclick = released = press = false;
 pressCount = 0;
 }
 void act() {
 mouseWheel = 0;
 if (press) {
 pressCount++;
 }
 click = dclick = released = kclick = false;
 
 ENTER.act();
 BACKSPACE.act();
 ALT.act();
 CTRL.act();
 SHIFT.act();
 ARRIBA.act();
 ABAJO.act();
 IZQUIERDA.act();
 DERECHA.act();
 }
 void mpress() {
 click = true;
 press = true;
 pressCount = 0;
 }
 void mreleased() {
 released= true;
 press = false;
 if (millis() - timepress < 400) dclick = true;
 timepress = millis();
 }
 
 void event(boolean estado) {
 if (estado) kclick = true;
 if (keyCode == 10) ENTER.event(estado);
 if (keyCode == 8) BACKSPACE.event(estado);
 if (keyCode == 18) ALT.event(estado);
 if (keyCode == 17) CTRL.event(estado);
 if (keyCode == 16) SHIFT.event(estado);
 if (keyCode == UP) ARRIBA.event(estado);
 if (keyCode == DOWN) ABAJO.event(estado);
 if (keyCode == LEFT) IZQUIERDA.event(estado);
 if (keyCode == RIGHT) DERECHA.event(estado);
 }
}*/
