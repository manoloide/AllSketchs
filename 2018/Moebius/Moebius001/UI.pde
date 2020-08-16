class UI {
  
  ArrayList<UIElement> elements;
  
  UI() {
    
     elements = new ArrayList<UIElement>();
     
  }
  
  void update() {
    for(int i = 0; i < elements.size(); i++){
       UIElement e = elements.get(i);
       e.update();
    }
  }
  
  void show() {
    for(int i = 0; i < elements.size(); i++){
       UIElement e = elements.get(i);
       e.show();
    }
  }
  
  void add(UIElement element) {
      elements.add(element);
  }
}

class UIElement {
  
  float x, y, w, h; 
  int backColor;
  String name;
  UIElement parent;
  
  UIElement() {
    
    parent = null;
    
  }
  
  void update() {
  };
  
  void show() {
  }
  
  boolean onPoint(float px, float py) {
    return (px >= x && px < x+w && py >= y && py < y+h);
  }
  

  UIElement setPosition(float x, float y) {
    this.x = x; 
    this.y = y;
    return this;
  }

  UIElement setSize(float w, float h) {
    this.w = w; 
    this.h = h;
    return this;
  }
  
  UIElement setName(String name) {
    this.name = name;
    return this;
  }
  
  UIElement setParent(UIElement parent) {
     this.parent = parent;
     return this;
  }
}

class UISection extends UIElement {
  
  void show() {
    noStroke();
    fill(255, 0, 0);
    if(onPoint(mouseX, mouseY)) fill(0, 255, 0);
     rect(x, y, w, h);
  }
  
}