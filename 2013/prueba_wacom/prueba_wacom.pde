/**
Example taken from http://processinghacks.com/hacks:example
Originally from http://processing.org/ (search for "JTablet")
@author Marcello Bastea-Forte
*/
 
import cello.tablet.*;
 
JTablet jtablet = null;
 
void setup() {
  size(640,480);
  frame.setResizable(true);
  try {
    jtablet = new JTablet();
  } catch (JTabletException jte) {
    println("Could not load JTablet! (" + jte.toString() + ").");
  }
  smooth();
}
 
void draw() {
  try {
    // Get latest tablet information
    jtablet.poll();
  } catch (JTabletException jte) {
    println("JTablet Error: " + jte.toString());
  }
 
  ellipseMode(CENTER);  
 
  if (mousePressed && jtablet.hasCursor()) {
    // Get the current cursor
    JTabletCursor cursor = jtablet.getCursor();
    stroke(0);
    strokeWeight(cursor.getPressureFloat() * 20);
    line(mouseX,mouseY,pmouseX,pmouseY);
  }
}
