class Face {
  ArrayList<Point> points;
  String imgSrc;
  PImage img;
  Point select;
  Face() {  
    points = new ArrayList<Point>();
    select = null;
  }
  Face(String imgSrc) {
    this.imgSrc = imgSrc;
    img = loadImage(imgSrc);
    points = new ArrayList<Point>();
    select = null;
  }
  void update() {
    if (click && mouseButton == LEFT) {
      float dist = 5;
      for (int i = 0; i < points.size(); i++) {
        Point p = points.get(i);
        float newDist = dist(p.x, p.y, mouseX-cx, mouseY-cy);
        if (newDist < dist) {
          dist = newDist;
          select = p;
        }
      }
      if (select == null) {
        points.add(new Point(mouseX-cx, mouseY-cy, mouseX-cx, mouseY-cy));
      } else if (doubleClick) {
        points.remove(select);
      }
    }
    if (mousePressed && select != null) {
      select.x = select.ux = mouseX-cx; 
      select.y = select.uy = mouseY-cy;
    }
    if (!mousePressed) {
      select = null;
    }

    show();
  }

  void show() {
    image(img, 0, 0);
    for (int i = 0; i < points.size(); i++) {
      Point p = points.get(i); 
      p.show();
    }
  }

  JSONObject getJson() {
    JSONObject json = new JSONObject();
    json.setString("imgSrc", imgSrc);
    JSONArray jarray = new JSONArray();
    for (int i = 0; i < points.size(); i++) {
      JSONObject jp = points.get(i).getJson();
      jarray.append(jp);
    }
    json.setJSONArray("points", jarray);
    return json;
  }

  void loadJson(JSONObject json) {
    imgSrc = json.getString("imgSrc");
    img = loadImage(imgSrc);
    JSONArray jarray = json.getJSONArray("points");
    points = new ArrayList<Point>();
    for (int i = 0; i < jarray.size(); i++) {
      Point p = new Point();
      p.loadJson(jarray.getJSONObject(i));
      points.add(p);
    }
  }
}


class Point {
  float x, y; 
  float ux, uy; 
  Point() {
  }
  Point(float x, float y, float ux, float uy) {
    this.x = x; 
    this.y = y; 
    this.ux = ux; 
    this.uy = uy;
  }

  void update() {
  }

  void show() {
    noStroke(); 
    fill(255, 220, 120); 
    ellipse(x, y, 4, 4);
  }  

  JSONObject getJson() {
    JSONObject json = new JSONObject();
    json.setFloat("x", x);
    json.setFloat("y", y);
    json.setFloat("ux", ux);
    json.setFloat("uy", uy);
    return json;
  }

  void loadJson(JSONObject json) {
    x = json.getFloat("x");
    y = json.getFloat("y");
    ux = json.getFloat("ux");
    uy = json.getFloat("uy");
  }

  PVector getVector() {
    return new PVector(x, y);
  }
}