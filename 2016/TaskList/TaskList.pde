ArrayList<Task> tasks;
PFont roboto16, roboto20;
PShape icon_menu, icon_search;

void setup() {
  size(320, 720);

  loadResources();

  tasks = new ArrayList<Task>();
  tasks.add(new Task("asdasd"));
  tasks.add(new Task("asdasd"));
  tasks.add(new Task("asdasd"));
  tasks.add(new Task("asdasd"));
  tasks.add(new Task("asdasd"));
}

void draw() {
  background(#303030);
  noStroke();
  fill(#FF4081);
  rect(0, 0, width, 56);
  shape(icon_menu, 16, 16);
  //shape(icon_search, width-icon_search.width-16, 16);
  fill(255);
  textSize(20);
  textFont(roboto20);
  textAlign(LEFT, TOP);
  text("Title", 72, 16);

  for (int i = 0; i < tasks.size(); i++) {
    Task t = tasks.get(i);
    t.y = 56*(i+1);
    t.update();
    t.show();
  }
}

void loadJson() {
}

void saveJson() {
}

void loadResources() {
  roboto16 = createFont("fonts/Roboto-Regular.ttf", 16, true);
  roboto20 = createFont("fonts/Roboto-Medium.ttf", 20, true);
  icon_menu = loadShape("icons/ic_menu_black_48px.svg");
  icon_menu.scale(0.5);
  /*
  icon_search = loadShape("icons/ic_search_black_48px.svg");
   icon_search.scale(0.5);
   */
}