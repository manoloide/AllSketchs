class Task {

  ArrayList<Task> tasks;  
  float y;
  String name;

  Task() {
    tasks = new ArrayList<Task>();
  }

  Task(String name) {
    this.name = name;
    tasks = new ArrayList<Task>();
  }

  void update() {
  }

  void show() {
    noStroke();
    fill(#f5f5f5);
    rect(0, y, width, 56);  
    fill(0, 220);
    textSize(20);
    textFont(roboto16);
    textAlign(LEFT, TOP);
    text("Title", 72, y+20);

    boolean check = true;
    if (check) {
      stroke(255);
      strokeWeight(2);
      fill(255);
      rect(19, y+19, 18, 18, 2);
    } else {
      stroke(255);
      strokeWeight(2);
      noFill();
      rect(19, y+19, 18, 18, 2);
    }
  }

  JSONObject getJson() {
    JSONObject json = new JSONObject();
    json.setString("name", name);
    return json;
  }

  void setJson(JSONObject json) {
    name = json.getString("name");
  }
}