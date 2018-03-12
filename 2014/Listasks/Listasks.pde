import javax.swing.JFrame;

int heightTask = 28;
int widthMax = 240;
int widthMin = 20;

String titleFont = "HelveticaBold.otf";
int titleSize = 18;
String srcTasks = "tasks.json";
String srcRemoved = "removed.json";

int timeHide = 40;
int velHide = 20;

void init() {
  //frame.setType(JFrame.Type.UTILITY);
  frame.removeNotify(); 
  frame.setUndecorated(true);
  frame.addNotify(); 
  super.init();
  config();
}

ArrayList<Task> tasks, taskRemove;
boolean hide = false;
JSONArray jtasks, jremoved;
Input input;
int timeFocus, widthLocation = widthMax;
PFont ftitle;
Task selection;

void setup() {
  size(widthMax, displayHeight);
  ftitle = createFont(titleFont, titleSize, true);
  input = new Input();
  selection = null;
  loadTasks();
}

void draw() {
  updateWindow();
  if(!focused) return;
  background(5);
  for (int i = 0; i < tasks.size (); i++) {
    Task t = tasks.get(i);
    t.move(0, heightTask*i);
    t.update();
    if (selection == null && input.click && t.on) {
      selection = t;	
      t.selected = true;
    }
  }
  //add new task
  if (selection == null && input.dclick) {
    tasks.add(new Task());
  }
  //remove task
  if(selection != null && input.released && input.amouseX-mouseX > widthMax/2){
    removeTask(selection);
    selection = null;
  }
  if (selection != null && !tasks.contains(selection)) {
    selection.update();
    if (input.released ) {
      int i = int(selection.y+heightTask/2)/heightTask;
      if (i < 0) tasks.add(0, selection);
      else if (i < tasks.size()) tasks.add(i, selection);
      else tasks.add(selection);
      selection.selected = false;
      selection = null;
    }
  }
  input.act();
}

void dispose() {
  saveTasks();
}

void keyPressed() {
  input.event(true);
}

void keyReleased() {
  input.event(false);
}
void mouseDragged() {
  if (selection != null) {
    tasks.remove(selection);
    selection.x -= pmouseX-mouseX;	
    selection.y -= pmouseY-mouseY;
  }
}
void mousePressed() {
  input.mpress();
  //if (mouseEvent.getClickCount() == 2) tasks.add(new Task());
}
void mouseReleased() {
  input.mreleased();
}

void updateWindow() {
  //frame.setExtendedState(JFrame.NORMAL);
  if (frameCount == 1) frame.setLocation(displayWidth-widthLocation, 0);
  timeFocus++;
  if (focused && hide) {
    hide = false;
    timeFocus = timeHide;
  }
  if (!focused && !hide) {
    hide = true;
    timeFocus = 0;
  }
  if (timeFocus > timeHide) {
    if (hide && widthLocation != widthMin) { 
      widthLocation-=velHide;
      frame.setLocation(displayWidth-widthLocation, 0);
    }
    if (!hide && widthLocation != widthMax) {
      widthLocation+=velHide; 
      frame.setLocation(displayWidth-widthLocation, 0);
    }
  }
}
void config() {
  File file = new File(sketchPath("config"));
  if (file.exists()) {
    JSONObject jconfig = loadJSONObject("config");
  } else {
    JSONObject jconfig = new JSONObject();
    saveJSONObject(jconfig, "config");
  }
}
