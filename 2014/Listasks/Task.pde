class Task {
  boolean edit, remove, on, selected;
  float x, y;
  int w, h;
  String creatingTime, lastEdition;
  TextInput title;
  Task() {
    x = 0; 
    y = 0; 
    w = widthMax;
    h = heightTask;
    title = new TextInput(20, (h-titleSize)*0.6, w-20, titleSize, "New Task!");
    creatingTime = getDataTime();
    lastEdition = getDataTime();
    edit = true;
  }
  Task(JSONObject jo) {
    x = 0; 
    y = -10; 
    w = widthMax;
    h = heightTask;
    title = new TextInput(20, (h-titleSize)*0.6, w-20, titleSize, jo.getString("title"));
    creatingTime = jo.getString("creatingTime");
    lastEdition = jo.getString("lastEdition");
  }
  void update() {
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) on = true;
    else on = false;
    title.update(x, y);
    show();
  }
  void show() {
    noStroke();
    fill(20);
    rect(x, y+1, w, h-1);
    stroke(25);
    line(x, y+1, x+w, y+1);
    stroke(10);
    line(x, y+h, x+w, y+h);
    fill(250);
    textFont(ftitle);
    textAlign(LEFT, TOP);
    title.show(x, y);
    //text(title, x+20, y+(h-titleSize)*0.6);
  }
  void move(float mx, float my) {
    //if(x == mx && y == my) return;
    x += (mx-x)*0.7;
    y += (my-y)*0.7;
    //}
  }
  JSONObject getJson() {
    JSONObject aux = new JSONObject();
    aux.setString("title", title.val);
    aux.setString("creatingTime", creatingTime);
    aux.setString("lastEdition", lastEdition);
    return aux;
  }
};

void loadTasks() {
  //cargar tareas
  tasks = new ArrayList<Task>();
  File ft = new File(sketchPath(srcTasks));
  if (ft.exists()) {
    jtasks = loadJSONArray(srcTasks);
  } else {
    jtasks = new JSONArray();
    saveJSONArray(jtasks, srcTasks);
    tasks.add(new Task());
  }
  //agregar las tareas cargadas
  for (int i = 0; i < jtasks.size (); i++) {
    JSONObject jtask = jtasks.getJSONObject(i);
    tasks.add(new Task(jtask));
  }
  //cargar tareas eliminadas
  taskRemove = new ArrayList<Task>();
  File fr = new File(sketchPath(srcRemoved));
  if (fr.exists()) {
    jremoved = loadJSONArray(srcRemoved);
  } else {
    jremoved = new JSONArray();
    saveJSONArray(jremoved, srcRemoved);
  }
  //agregar las tareas eliminadas
  for (int i = 0; i < jremoved.size (); i++) {
    JSONObject jtask = jremoved.getJSONObject(i);
    taskRemove.add(new Task(jtask));
  }
}

void saveTasks() {
  //save task
  JSONArray aux = new JSONArray();
  for (int i = 0; i < tasks.size (); i++) {
    Task t = tasks.get(i);
    aux.append(t.getJson());
  }
  jtasks = aux;
  saveJSONArray(jtasks, srcTasks);
  //save taskremoves
  aux = new JSONArray();
  for (int i = 0; i < taskRemove.size (); i++) {
    Task t = taskRemove.get(i);
    aux.append(t.getJson());
  }
  jremoved = aux;
  saveJSONArray(jremoved, srcRemoved);
}

void removeTask(Task t){
  taskRemove.add(t);
  tasks.remove(t); 
}

//funcion que devuelve un string con datos del tiempo
String getDataTime() {
  return (year()+"-"+month()+"-"+day()+" "+hour()+":"+minute()+":"+second());
}
