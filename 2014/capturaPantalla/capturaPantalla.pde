import java.awt.AWTException;
import java.awt.MouseInfo;
import java.awt.Point;
import java.awt.Robot;

Robot robot;
Point mouse;

boolean render = false;

void setup() {
  size(200, 180);
  frameRate(30);
  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    println("Robot class not supported by your system!");
    exit();
  }

  
}

void draw() {
  if (!render) {
    thread("buscar");
  }
}

void buscar() {
  mouse = MouseInfo.getPointerInfo().getLocation();
  render = true;
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      set(i, j, robot.getPixelColor(i+mouse.x, j+mouse.y).getRGB());
    }
  }
  render = false;
}
