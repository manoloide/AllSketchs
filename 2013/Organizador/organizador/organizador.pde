/*
Organizador.
 ideas y sugerancias:
 -agregar tareas rapidas... libres o dentro de un proyecto.
 -guardar palabras sueltas rapido muy rapido.
 -agregar trancicion cuando moves un proyecto...
 -pantalla de carga
 -agregar negrita, cursiva, y listas.
 -"sticky notes"forma de marcar las notitas más importantes
 -agregar archivo
 
 bugs:
 -arreglar el icono en linux
 -color seleccion del texto
 
 cosas a hacer:
 -sacar saltos de linea en la mitad de una palabra.
 -icono del exe
 
 -pop up;
 -mejorara rendimiento no re dibujar al pedo
 
 *configuracion:
 -poder ccambiar ubicacion de los datos
 -alto de pantalla
 
 */

import java.awt.AWTException;
import java.awt.event.*;
import java.awt.event.MouseListener;
import java.awt.datatransfer.*;
import java.awt.MenuItem;
import java.awt.PopupMenu;
import java.awt.SystemTray;
import java.awt.TrayIcon;
import java.awt.TrayIcon.MessageType;
import java.awt.Toolkit; 
import javax.swing.ImageIcon;
import javax.swing.JFrame; 

boolean cerrar;
ClipHelper cp;
Eventos e;
EditarProyecto ep;
int count, cantcount;
Menu menu;
String nombre, estado = "menu";
String tconfig[];
PFont font, fontchica;
PGraphics icon;
Proyecto actual;
PShape nuevo, eliminar, config;
XML xml;
XML[] aproyecto;

void setup() {
  tconfig = loadStrings("config.txt");
  size(480, int(tconfig[0]));
  frameRate(60);
  if (int(tconfig[2]) == 1) {
    cerrar = false;
    //exit();
  } else {
    cerrar = true;
    tconfig[2] = "1";
    saveStrings("data/config.txt", tconfig);
  }
  nombre = "Pnombre";
  frame.setTitle(nombre);

  icon = createGraphics(32, 32, JAVA2D);
  icon.beginDraw();
  icon.image(loadImage("logo32.png"), 0, 0);
  icon.endDraw();
  frame.setIconImage(icon.image);

  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
    }
  }
  ); 

  cantcount = 20;

  nuevo = loadShape("iconuevo.svg");
  nuevo.disableStyle();
  eliminar = loadShape("icoeliminar.svg");
  eliminar.disableStyle();
  config = loadShape("icoconfig.svg");
  config.disableStyle();

  font = loadFont("Vrinda-72.vlw");
  fontchica = loadFont("Vrinda-22.vlw");
  textFont(font, 72);
  textAlign(LEFT, TOP);

  cp = new ClipHelper();
  e = new Eventos();
  menu = new Menu();
  cargarTray();
}

void draw() {
  //println(frameRate);
  if (focused) {
    background(245);
    if (estado.equals("menu")) {
      menu.act();
    } else if (estado.equals("proyecto")) {
      ep.act();
    } else if (estado.equals("transicion")) {
      transicion();
    }
    e.act();
  } else {
    e.reset();
  }
}

void keyPressed() {
  e.kpressed(key);
}

void keyReleased() {
  e.kereleased();
}

void mousePressed() {
  e.mpressed(mouseButton);
}

void mouseReleased() {
  e.mreleased(mouseButton);
}

void mouseWheel(int delta) {
  e.rueda(delta);
}

void dispose() {
  if (cerrar) {
    tconfig[2] = "0";
    saveStrings("data/config.txt", tconfig);
  }
  if (actual != null) {
    ep.guardarProyecto();
  }
  try {    
    Thread.sleep(1000);
  }
  catch(Exception e) {
  }
}

class Eventos {
  boolean click, press, released, move, dobleclick, keypress, keyreleased, ctrl, shift, rueda;
  char key;
  int tiempoClick, tDobleClick, tiempoKey, px, py, mrueda; 
  Eventos() {
    reset();
  }
  void act() {
    click = false;
    press = false;
    released = false;
    dobleclick = false;
    keypress = false;
    rueda = false;
    mrueda = 0;
  }
  void reset() {
    click = false;
    press = false;
    released = false;
    dobleclick = false;
    keypress = false;
    keyreleased = false;
    ctrl = false;
    shift = false;
    move = false;
    rueda = false;
    tiempoClick = 0;
    tDobleClick = 0;
    tiempoKey = 0;
    mrueda = 0;
  }
  void kpressed(char k) {
    key = k;
    tiempoKey = millis();
    keypress = true;
    keyreleased = true;
    if (keyCode == CONTROL) {
      ctrl = true;
    } else if (keyCode == SHIFT) {
      shift = true;
    }
  }
  void kereleased() {
    keyreleased = false;
    if (keyCode == CONTROL) {
      ctrl = false;
    } else if (keyCode == SHIFT) {
      shift = false;
    }
  }
  void mpressed(int mb) {
    if (mb == LEFT) {
      px = mouseX;
      py = mouseY;
      move = true;
      press = true;
      tiempoClick = millis();
    }
  }
  void mreleased(int mb) {
    if (mb == LEFT) {
      if (dist(mouseX, mouseY, px, py) < 5) {
        click = true;
      }
      released = true;
      move = false;
      if (millis() - tDobleClick < 250) {
        dobleclick = true;
      }  
      tDobleClick = millis();
    }
  }
  void rueda(int delta) {
    mrueda = delta; 
    rueda = true;
  }
}

class Proyecto {
  boolean sobre, press, moviendo;
  float x, dy, y, w, h;
  int id, tsobre;
  String contenido, nombre, fecha;
  Proyecto(int id, String contenido, String nombre, String fecha) {
    this.id = id;
    this.contenido = contenido;
    this.nombre = nombre;
    this.fecha = fecha;
    x = 0;
    y = id*80;
    w = 456;
    h = 80;
    sobre = false;
    press = false;
    moviendo = false;
  }
  void act() {
    press = false;
    dy = 0;
    if (moviendo) {
      dy = mouseY-e.py;
      if (!e.move) {
        moviendo = false;
      }
      if (tsobre > 0) {
        tsobre -= 1;
      }
      sobre = false;
    } else if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h && mouseY < height-80) {
      sobre = true;
      if (e.click) {
        press = true;
      }
      if (tsobre < 16) {
        tsobre += 1;
      }
      if (!moviendo && e.move && millis()-e.tiempoClick > 120 && e.px >= x && e.px < x+w && e.py >= y && e.py < y+h && e.py < height-80) {
        moviendo = true;
      }
    } else {
      if (tsobre > 0) {
        tsobre -= 1;
      }
      sobre = false;
    }
  }

  void dibujar() {
    float alp = 255;
    if (moviendo) {
      alp = (tsobre/10.) * 128+128;
    } 
    float y = this.y+dy;
    noStroke();
    fill(230+tsobre/2, alp);
    rect(x, y, w, h);
    stroke(240, alp);
    line(x, y, w, y);
    stroke(220, alp);
    line(x, y-1+h, w, y-1+h);
    stroke(128, alp);
    fill(204, alp);
    ellipse(x+40, y+44, 48, 48);
    fill(214, 39, 97, alp);
    stroke(180, alp);
    triangulo(x+40, y+44, 20, 0);
    textFont(font, 72);
    text(nombre, x+80, y+28);
    fill(51, (tsobre/16.)*200);
    textFont(fontchica, 18);
    text(fecha, x+w-textWidth(fecha)-4, y+4);
  }

  void guardar() {
    aproyecto[id].setString("fecha", fecha);
    aproyecto[id].setString("contenido", contenido);
    aproyecto[id].setContent(nombre);
    saveXML(xml, "data/proyectos.xml");
  }
}

class EditarProyecto {
  Boton b1;
  Proyecto pro;
  TextE nombre, texto;
  EditarProyecto(Proyecto pro) {
    this.pro = pro;
    b1 = new Boton(36, 44, 40);
    nombre = new TextE(72, 36, 264, 32, pro.nombre, font, 48, color(214, 39, 97));
    texto = new TextE(30, 104, 420, height-104, pro.contenido, fontchica, 22, color(20));
    texto.tab = true;
  }
  void act() {
    b1.act();
    if (b1.press) {
      estado = "transicion";
      count = cantcount;
      guardarProyecto();
      actual = null;
    }
    nombre.act();
    texto.act();
    dibujar();
  }
  void dibujar() {
    texto.dibujar();
    noStroke();
    fill(230);
    rect(0, 0, 480, 80);
    stroke(240);
    line(0, 0, 480, 0);
    stroke(220);
    line(0, 80, 480, 80);
    stroke(128);
    fill(204);
    //archivo(352, 32, 24, 32, 8);
    //archivo(384, 32, 24, 32, 8);
    //archivo(416, 32, 24, 32, 8);
    //archivo(448, 32, 24, 32, 8);
    b1.dibujar();
    nombre.dibujar();
  }
  void cargarProyecto() {
  }
  void guardarProyecto() {
    aproyecto = xml.getChildren("proyecto");
    //String contenido = aproyecto[id].getString("contenido");
    pro.fecha = "";
    pro.fecha += (day()<10)? "0"+day(): day();
    pro.fecha += "/"+((month()<10)? "0"+month(): month());
    pro.fecha += "/"+((year()<10)? "0"+year(): year());
    pro.fecha += " "+((hour()<10)? "0"+hour(): hour());
    pro.fecha += "."+((minute()<10)? "0"+minute(): minute()); 
    pro.nombre = nombre.text;
    pro.contenido = texto.text;
    pro.guardar();
  }
}

void transicion() {
  count--;
  if (actual != null) {
    float desy = (ep.pro.y)/cantcount;
    float desy2 = (height-(ep.pro.y))/cantcount;
    ep.texto.dibujar(0, int(desy*count));
    for (int i = 0; i < menu.proyectos.size();i++) {
      Proyecto ori = menu.proyectos.get(i); 
      Proyecto aux = new Proyecto(ori.id, ori.contenido, ori.nombre, "");
      aux.w = width;
      aux.dy = ori.dy;
      aux.y = menu.h*i + menu.scroll.val * (menu.y-menu.cant*menu.h);
      if (ori.id <= ep.pro.id) {
        aux.y -= desy*(cantcount-count);
      } else {
        aux.y += desy2*(cantcount-count);
        if (ori.id == ep.pro.id+1) {
          noStroke();
          fill(245);
          rect(0, aux.y, width, height-aux.y);
        }
      }
      aux.y = int(aux.y);
      aux.dibujar();
    }
    noStroke();
    fill(230);
    rect(0, ep.pro.y+3-desy*(cantcount-count), width, 77);
    stroke(220);
    line(0, ep.pro.y-desy*(cantcount-count)+80, width, ep.pro.y-desy*(cantcount-count)+80);
    Boton ba = new Boton(map(count, 0, cantcount, 36, 40), 44+ep.pro.y-desy*(cantcount-count), map(count, 0, cantcount, 40, 44));
    ba.ang = map(count, 0, cantcount, PI/2, 0);
    ba.sobre = count/2;
    ba.dibujar();
    fill(214, 39, 97);
    textFont(font, map(count, 0, cantcount, 48, 72));
    //72, 36
    text(ep.pro.nombre, ep.pro.x+map(count, 0, cantcount, 72, 80), ep.pro.y+map(count, 0, cantcount, 36, 28)-desy*(cantcount-count));
    if (menu.scrolling) {
      menu.scroll.x = 480-20*(count*1./cantcount);
      menu.scroll.dibujar();
    }
    //menu inferior
    noStroke();
    fill(230);
    rect(0, (height-80) + 80 * ((cantcount-count)*1./cantcount), width, 80);
    fill(204);
    noStroke();
    float y = (height-36) + 80 * ((cantcount-count)*1./cantcount);
    shape(nuevo, width/2, y);
    shape(eliminar, 88, y);
    shape(config, width-88, y);
    if (count == 0) {
      estado = "proyecto";
    }
  } else {
    float desy = (ep.pro.y)/cantcount;
    float desy2 = (height-(ep.pro.y))/cantcount;
    ep.texto.dibujar(0, int(desy*(cantcount-count)));
    for (int i = 0; i < menu.proyectos.size();i++) {
      Proyecto ori = menu.proyectos.get(i); 
      Proyecto aux = new Proyecto(ori.id, ori.contenido, ori.nombre, "");
      aux.w = width;
      aux.dy = ori.dy;
      aux.y = menu.h*i + menu.scroll.val * (menu.y-menu.cant*menu.h);
      if (ori.id <= ep.pro.id) {
        aux.y -= desy*(count);
      } else {
        aux.y += desy2*(count);
        if (ori.id == ep.pro.id+1) {
          noStroke();
          fill(245);
          rect(0, aux.y, width, height-aux.y);
        }
      }
      aux.y = int(aux.y);
      aux.dibujar();
    }
    noStroke();
    fill(230);
    rect(0, ep.pro.y+3-desy*(count), width, 77);
    stroke(220);
    line(0, ep.pro.y-desy*(count)+80, width, ep.pro.y-desy*(count)+80);
    Boton ba = new Boton(map(count, 0, cantcount, 40, 36), 44+ep.pro.y-desy*(count), map(count, 0, cantcount, 44, 40));
    ba.ang = map(count, 0, cantcount, 0, PI/2);
    ba.sobre = 10;
    ba.dibujar();
    fill(214, 39, 97);
    textFont(font, map(count, 0, cantcount, 72, 48));
    text(ep.pro.nombre, ep.pro.x+map(count, 0, cantcount, 80, 72), ep.pro.y+map(count, 0, cantcount, 28, 36)-desy*(count));
    if (menu.scrolling) {
      menu.scroll.x = 480-20*((cantcount-count)*1./cantcount);
      menu.scroll.dibujar();
    }
    noStroke();
    fill(230);
    rect(0, (height-80) + 80 * ((count*1.)/cantcount), width, 80);
    fill(204);
    noStroke();
    float y = (height-36) + 80 * ((count*1.)/cantcount) ;
    shape(nuevo, width/2, y);
    shape(eliminar, 88, y);
    shape(config, width-88, y);
    if (count == 0) {
      estado = "menu";
    }
  }
}

class ClipHelper {
  Clipboard clipboard;
  ClipHelper() {
    getClipboard();
  }
  void getClipboard () {
    // this is our simple thread that grabs the clipboard
    Thread clipThread = new Thread() {
      public void run() {
        clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
      }
    };
    if (clipboard == null) {
      try {
        clipThread.setDaemon(true);
        clipThread.start();
        clipThread.join();
      }  
      catch (Exception e) {
      }
    }
  }
  void copyString (String data) {
    copyTransferableObject(new StringSelection(data));
  }
  void copyTransferableObject (Transferable contents) {
    getClipboard();
    clipboard.setContents(contents, null);
  }
  String pasteString () {
    String data = null;
    try {
      data = (String)pasteObject(DataFlavor.stringFlavor);
    }  
    catch (Exception e) {
      System.err.println("Error getting String from clipboard: " + e);
    }
    return data;
  }
  Object pasteObject (DataFlavor flavor)  
  throws UnsupportedFlavorException, IOException {
    Object obj = null;
    getClipboard();
    Transferable content = clipboard.getContents(null);
    if (content != null)
      obj = content.getTransferData(flavor);
    return obj;
  }
}


void cargarTray() {
  if (!SystemTray.isSupported()) {
    System.out.println("SystemTray is not supported");
    return;
  }
  final PopupMenu popup = new PopupMenu();
  final TrayIcon trayIcon = new TrayIcon(icon.image, nombre, popup);
  final SystemTray tray = SystemTray.getSystemTray();
  trayIcon.setImageAutoSize(true);
  try {
    tray.add(trayIcon);
  } 
  catch (AWTException e) {
    System.out.println("TrayIcon could not be added.");
  }
  ActionListener exitListener = new ActionListener() {
    public void actionPerformed(ActionEvent e) {            
      exit();
    }
  };
  ActionListener RestaurarListener = new ActionListener() {
    public void actionPerformed(ActionEvent e) {            
      frame.setVisible(true);
      frame.setExtendedState( JFrame.NORMAL);
    }
  };

  trayIcon.addActionListener(RestaurarListener);

  MenuItem abrirItem = new MenuItem("Abrir");
  abrirItem.addActionListener(RestaurarListener);
  MenuItem salirItem = new MenuItem("Salir");
  salirItem.addActionListener(exitListener);
  popup.add(abrirItem);
  popup.add(salirItem);

  frame.addWindowListener(new WindowAdapter() {
    public void windowIconified(WindowEvent e) {
      frame.setVisible(false);
      trayIcon.displayMessage(nombre, "Esta minimizado.", MessageType.INFO);
    }
  }
  );
}

