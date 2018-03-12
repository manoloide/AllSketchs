boolean click, doubleClick;

ArrayList<Face> faces;
Face face;

boolean play = false;
float time = 0;
float totalTime = 2;
int cx = 10, cy = 10;

boolean viewInfo = true;
boolean viewMesh = true;

void setup() {
  size(1280, 720, P2D);
  smooth(8);
  faces = new ArrayList<Face>();
  faces.add(new Face("../face1.jpg"));
  faces.add(new Face("../face2.jpg"));

  face = faces.get(0);
}


enum Section {
  VIEW, FACE
}

Section section = Section.VIEW;

void draw() {

  pushMatrix();
  translate(cx, cy);
  background(10);

  if (section == Section.VIEW) {
    if (play) {
      time += 1./60; 
      if (time > totalTime) {
        time = 0;
      }
    }

    float norTime = time/totalTime;

    Face face1 = faces.get(0);
    Face face2 = faces.get(1);

    image(face1.img, 0, 0);
    tint(255, norTime*255);
    image(face2.img, 0, 0);
    noTint();

    ArrayList<PVector> vertices = new ArrayList<PVector>();
    ArrayList<PVector> verticesIndices = new ArrayList<PVector>();
    for (int i = 0; i < min(face1.points.size(), face2.points.size()); i++) {
      Point p1 = face1.points.get(i);
      Point p2 = face2.points.get(i);
      float xx = map(norTime, 0, 1, p1.x, p2.x);
      float yy = map(norTime, 0, 1, p1.y, p2.y);
      Point p = new Point(xx, yy, xx, yy);
      vertices.add(new PVector(xx, yy));
      verticesIndices.add(new PVector(xx, yy));
    }

    if (vertices.size() > 2) {
      ArrayList<Triangle> triangles = Triangulate.triangulate(vertices);

      if (viewMesh) {
        stroke(255, 220, 120);
      } else {
        noStroke();
      }

      textureMode(IMAGE);
      beginShape(TRIANGLES);
      for (int i = 0; i < triangles.size(); i++) {
        Triangle t = (Triangle)triangles.get(i);
        PVector p1 = null;
        PVector p2 = null;
        PVector p3 = null;
        for (int j = 0; j < verticesIndices.size(); j++) {
          PVector act = verticesIndices.get(j);
          if (t.p1.x == act.x && t.p1.y == act.y) {
            p1 = face1.points.get(j).getVector();
          }
          if (t.p2.x == act.x && t.p2.y == act.y) {
            p2 = face1.points.get(j).getVector();
          }
          if (t.p3.x == act.x && t.p3.y == act.y) {
            p3 = face1.points.get(j).getVector();
          }
        }


        texture(face1.img);
        vertex(t.p1.x, t.p1.y, p1.x, p1.y);
        vertex(t.p2.x, t.p2.y, p2.x, p2.y);
        vertex(t.p3.x, t.p3.y, p3.x, p3.y);

        /*
        stroke(0, 0, 255);
         line(t.p1.x, t.p1.y, p1.x, p1.y);
         line(t.p2.x, t.p2.y, p2.x, p2.y);
         line(t.p3.x, t.p3.y, p3.x, p3.y);
         noStroke();
         fill(255, 0, 0);
         ellipse(t.p1.x, t.p1.y, 4, 4);//, p1.x, p1.y);
         ellipse(t.p2.x, t.p2.y, 4, 4);//, p2.x, p2.y);
         ellipse(t.p3.x, t.p3.y, 4, 4);//, p3.x, p3.y);
         fill(0, 255, 0);
         ellipse(p1.x, p1.y, 4, 4);//, p1.x, p1.y);
         ellipse(p2.x, p2.y, 4, 4);//, p2.x, p2.y);
         ellipse(p3.x, p3.y, 4, 4);//, p3.x, p3.y);
         */
      }
      endShape();


      tint(255, norTime*255);
      beginShape(TRIANGLES);
      for (int i = 0; i < triangles.size(); i++) {
        Triangle t = (Triangle)triangles.get(i);
        PVector p1 = null;
        PVector p2 = null;
        PVector p3 = null;
        for (int j = 0; j < verticesIndices.size(); j++) {
          PVector act = verticesIndices.get(j);
          if (t.p1.x == act.x && t.p1.y == act.y) {
            p1 = face2.points.get(j).getVector();
          }
          if (t.p2.x == act.x && t.p2.y == act.y) {
            p2 = face2.points.get(j).getVector();
          }
          if (t.p3.x == act.x && t.p3.y == act.y) {
            p3 = face2.points.get(j).getVector();
          }
        }

        texture(face2.img);
        vertex(t.p1.x, t.p1.y, p1.x, p1.y);
        vertex(t.p2.x, t.p2.y, p2.x, p2.y);
        vertex(t.p3.x, t.p3.y, p3.x, p3.y);
      }
      endShape();
      noTint();
    }
  } else if ( section == Section.FACE) {
    face.update();
  }

  popMatrix();

  if (viewInfo) {
    String txt = "Play/Stop - SpaceBar\n";
    txt += "ViewMode - 1\n";
    txt += "Face Editor - 2\n";
    txt += "Save Data - s\n";
    txt += "Load Data - l\n";
    txt += "View Info - i\n";
    txt += "View Mesh - m\n";
    txt += "Move Frame - LEFT/RIGHT\n";
    txt += "Change Face - LEFT/RIGHT";

    float ww = textWidth(txt)+20;
    float hh = txt.split("\n").length* (textAscent()+textDescent())+10;
    noStroke();
    fill(10, 80);
    rect(10, 10, ww, hh);
    textAlign(LEFT, TOP);
    fill(255, 240, 220);
    text(txt, 20, 20);
  }

  if (section == Section.VIEW) {
    float px = map(time, 0, totalTime, 0, width);
    noStroke();
    fill(200, 180, 130, 180);
    rect(0, height-40, px, 40);
    fill(80, 180);
    rect(px, height-40, width-px, 40);
    stroke(255, 220, 120);
    line(px, height-40, px, height);
    if (mousePressed && mouseY > height-40) {
      play = false;
      time = map(mouseX, 0, width, 0, totalTime);
    }
  }

  click = doubleClick = false;
}

void keyPressed() {
  if (key == '1') {
    section = Section.VIEW;
  } else if (key == '2') {
    section = Section.FACE;
  }

  if (key == 'l') {
    loadJson();
  }
  if (key == 's') {
    saveJson();
  }

  if (key == ' ') {
    if (section == Section.VIEW) {
      play = !play;
    }
  }
  if (key == 'm') {
    viewMesh = !viewMesh;
  }
  if (key == 'i') {
    viewInfo = !viewInfo;
  }


  if (keyCode == LEFT) {
    if (section == Section.VIEW) {
      time -= 1./60;
    }
    if (section == Section.FACE) {
      int nf = faces.indexOf(face)-1;
      if (nf < 0) {
        nf = faces.size()-1;
      }
      face = faces.get(nf);
    }
  }

  if (keyCode == RIGHT) {
    if (section == Section.VIEW) {
      time += 1./60;
    }
    if (section == Section.FACE) {
      int nf = faces.indexOf(face)+1;
      nf = nf%faces.size();
      face = faces.get(nf);
    }
  }
}

void mouseDragged() {
  if (mouseButton == CENTER) {
    cx += mouseX-pmouseX; 
    cy += mouseY-pmouseY;
  }
}

void mousePressed() {
  click = true;
  if (mouseEvent.getClickCount()==2) { 
    doubleClick = true;
  }
}


void loadJson() {

  JSONObject data = loadJSONObject("data/data.json"); 
  JSONArray jfaces = data.getJSONArray("faces");

  faces = new ArrayList<Face>();
  for (int i = 0; i < jfaces.size(); i++) {
    Face aux = new Face();
    aux.loadJson(jfaces.getJSONObject(i));
    faces.add(aux);
  }
  if (faces.size() > 0)
    face = faces.get(0);
}

void saveJson() {
  JSONObject json = new JSONObject();
  JSONArray jfaces = new JSONArray();
  for (int i = 0; i < faces.size(); i++) {
    jfaces.append(faces.get(i).getJson());
  }
  json.setJSONArray("faces", jfaces);

  saveJSONObject(json, "data/data.json");
}