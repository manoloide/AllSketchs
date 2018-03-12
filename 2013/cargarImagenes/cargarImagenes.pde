import java.awt.datatransfer.*;
import java.awt.Toolkit; 

ClipHelper cp = new ClipHelper();

boolean control;
PImage img[]; 
String url = ""; 

void setup() {
  size(800, 600);
  frame.setResizable(true); 
  img = new PImage[10];
}

void draw() {
  //background(0); 
  if (img[0] != null) {
    float es = map(dist(mouseX, mouseY, width/2, height/2),0,height,0.1,1); 
    image(img[0], mouseX-img[0].width/2*es, mouseY-img[0].height/2*es, img[0].width*es, img[0].height*es);
  }
  text(url, 20, 20);
}

void keyPressed() {
  if (keyCode == CONTROL) {
    control = true;
  }
  if (keyCode == ENTER) {
    cargarImagen(url); 
    url = "";
  }
  if (control && (keyCode == 'v' || keyCode == 'V')) {
    url = cp.pasteString();
  }
}

void keyReleased() {
  if (keyCode == CONTROL) {
    control = false;
  }
}

void cargarImagen(String url) {
  for (int i = img.length-1; i > 0; i--) {
    img[i] = img[i-1];
  }
  img[0] = loadImage(url);
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

    // start the thread as a daemon thread and wait for it to die
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
    throws UnsupportedFlavorException, IOException
  {
    Object obj = null;
    getClipboard();

    Transferable content = clipboard.getContents(null);
    if (content != null)
      obj = content.getTransferData(flavor);

    return obj;
  }
}
