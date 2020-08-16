Layout layout;

void setup() {
  size(800, 600);
  frame.setResizable(true);

  layout = new Layout();
  layout.setStyle(layout.VERTICAL);
  Layout v1 = new Layout(layout);
  v1.setMaxHeight(22);
  Layout v2 = new Layout(layout);
  v2.setMaxHeight(28);
  Layout v3 = new Layout(layout);
  Layout v4 = new Layout(layout);
  v4.setMaxHeight(28);
  Layout h1 =  new Layout(v3);
  h1.setMaxWidth(80);
  Layout h2 =  new Layout(v3);
  Layout h3 =  new Layout(v3);
  h3.setMaxWidth(180);
  /*
  layout.setStyle(layout.VERTICAL);
  Layout menuLeft = new Layout(layout);
  Layout center = new Layout(layout);
  Layout menuRight = new Layout(layout);

  menuLeft.setStyle(center.HORIZONTAL);
  Layout l1 = new Layout(menuLeft);
  l1.setMaxWidth(80);
  Layout l2 = new Layout(menuLeft);
  Layout l3 = new Layout(menuLeft);
  Layout l4 = new Layout(menuLeft);
  l4.setMaxWidth(12);

  center.setStyle(center.VERTICAL);
  Layout p1 = new Layout(center); 
  p1.setMaxHeight(20);
  Layout p2 = new Layout(center); 
  Layout p3 = new Layout(center);
  p3.setMinHeight(20);
  p3.setMaxHeight(20);
*/
}

void draw() {
  layout.resize();
  layout.show();
}

class Layoutable {
  final int HORIZONTAL = 0;
  final int VERTICAL = 1;

  color backgroundColor;
  int w, h;
  int left, top;
  int minWidth, maxWidth;
  int minHeight, maxHeight;
  int style;
  Layoutable parent;
  PGraphics render;

  void resize() {
  }
  void show() {
  }

  void addChild(Layoutable child) {
  }

  void setMinWidth(int minWidth) {
    this.minWidth = minWidth;
  }
  void setMaxWidth(int maxWidth) {
    this.maxWidth = maxWidth;
  }
  void setMinHeight(int minHeight) {
    this.minHeight = minHeight;
  }
  void setMaxHeight(int maxHeight) {
    this.maxHeight = maxHeight;
  }

  void setWidth(int w) {
    this.w = w;
  }
  void setHeight(int h) {
    this.h = h;
  }
  void setLeft(int left) {
    this.left = left;
  }
  void setTop(int top) {
    this.top = top;
  }

  void setStyle(int style) {
    this.style = style;
  }

  void setParent(Layoutable parent) {
    this.parent = parent;
  }
  void setBackgroundColor(color col) {
    backgroundColor = col;
  }
}

class Layout extends Layoutable {
  ArrayList<Layoutable> children;
  Layout() {  
    parent = null;
    init();
  }
  Layout(Layoutable parent) {    
    setParent(parent);
    init();
  }
  void init() {
    children = new ArrayList<Layoutable>();
    setBackgroundColor(color(random(200)));//, random(256), random(256)));

    if (parent != null) {
      setLeft(0);
      setTop(0);
      setWidth(20);
      setHeight(20);
      parent.addChild(this);
    }
    resize();
  }
  void resize() {
    if (parent == null) {
      setLeft(0);
      setTop(0);
      setWidth(width);
      setHeight(height);
    } 
    render = createGraphics(w, h);

    int c = children.size();
    if (c > 0) {
      if (style == HORIZONTAL) {
        /*
        int nw = w/c;
         for (int i = 0; i < c; i++) {
         Layoutable l = children.get(i);
         l.setTop(0);
         l.setHeight(h);
         l.setWidth(nw);
         l.setLeft(nw*i);
         l.resize();
         }*/
        int newWidth = w/c;
        int total = 0;
        int rest = w;
        for (int i = 0; i < c; i++) {
          Layoutable l = children.get(i);
          l.setHeight(h);
          l.setTop(0);

          if (l.maxWidth != 0 && newWidth > l.maxWidth) {
            l.setWidth(l.maxWidth);
          } else if (l.minWidth != 0 && newWidth < l.minWidth) {
            l.setWidth(l.minWidth);
          } else {
            total++;
            l.setWidth(0);
          }
          rest -= l.w;
        }
        if (total > 0) {
          newWidth = rest/total;
          int ap = 0;
          for (int i = 0; i < c; i++) {
            Layoutable l = children.get(i);
            l.setLeft(ap);
            if (l.w == 0) {
              l.setWidth(newWidth);
            }
            ap += l.w;
            l.resize();
          }
        }
      } else if (style == VERTICAL) {
        int newHeight = h/c;
        int total = 0;
        int rest = h;
        for (int i = 0; i < c; i++) {
          Layoutable l = children.get(i);
          l.setWidth(w);
          l.setLeft(0);

          if (l.maxHeight != 0 && newHeight > l.maxHeight) {
            l.setHeight(l.maxHeight);
          } else if (l.minHeight != 0 && newHeight < l.minHeight) {
            l.setHeight(l.minHeight);
          } else {
            total++;
            l.setHeight(0);
          }
          rest -= l.h;
        }
        if (total > 0) {
          newHeight = rest/total;
          int ap = 0;
          for (int i = 0; i < c; i++) {
            Layoutable l = children.get(i);
            l.setTop(ap);
            if (l.h == 0) {
              l.setHeight(newHeight);
            }
            ap += l.h;
            l.resize();
          }
        }
      }
    }
    redraw();
  }
  void show() {
    for (int i = 0; i < children.size (); i++) {
      Layoutable l = children.get(i);
      l.show();
    }
    if (parent == null) {
      image(render, 0, 0);
    } else {
      PGraphics ar = parent.render;
      ar.beginDraw();
      ar.image(render, left, top);
      ar.endDraw();
    }
  }

  void redraw() {
    render.beginDraw();
    render.background(backgroundColor);
    render.noStroke();
    render.fill(brightness(backgroundColor)+10);
    render.rect(0, h-1, w, 1);
    render.endDraw();
  }

  void addChild(Layoutable child) {
    children.add(child);
    resize();
  }
}

/*
class Widget extends Layoutable {
 ArrayList<Widget> childrens;
 Widget(Layoutable parent) {
 this.parent = parent;
 }
 void show() {
 noStroke();
 fill(backgroundColor);
 rect(0, 0, w, h);
 stroke(255, 220, 220);
 noFill();
 rect(0+1, 0+1, w-3, h-3);
 }
 }
 */
