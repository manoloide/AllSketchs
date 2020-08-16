import java.util.Arrays;
import processing.video.*;

ArrayList<Filter> filters;
Capture video;
PGraphics render;
PShader shader;


public void setup() {
  size(840, 480, P2D);
  frameRate(60);
  video = new Capture(this, width-200, height);
  video.start();
  render = createGraphics(640, 480, P2D);


  filters = new ArrayList<Filter>();
  filters.add(new Filter(loadJSONObject("snippets/displacement.json")));
  filters.add(new Filter(loadJSONObject("snippets/noise.json")));
  filters.add(new Filter(loadJSONObject("snippets/vignette.json")));
  createShader();
}

public void draw() {
  if (video.available()) {
    video.read();
  }
  background(80);
  shader.set("time", millis()/1000.);
  shader.set("mouse", float(mouseX)/width, 1-float(mouseY)/height);
  render.beginDraw();
  render.image(video, 0, 0);
  render.filter(shader);
  render.endDraw();
  image(render, 0, 0);
}

void createShader() {
  String[] vertSource = new String[] {
    "uniform mat4 transform; attribute vec4 vertex;", 
    "attribute vec4 color; varying vec4 vertColor;", 
    "void main() { gl_Position = transform * vertex;", 
    "vertColor = color; }"
  };
  String[] fragSource = new String[] {
    "#define PROCESSING_TEXTURE_SHADER", 
    "uniform sampler2D texture;", 
    "uniform vec2 texOffset;", 
    "varying vec4 vertColor;", 
    "varying vec4 vertTexCoord;", 
    "uniform vec2 resolution;", 
    "uniform vec2 mouse;", 
    "uniform float time;", 
    "void main() {", 
    "vec2 uv = gl_FragCoord.xy / resolution.xy;", 
    "vec4 col = texture2D(texture, uv);",
  };

  ArrayList<String> fragList = (new ArrayList<String>(Arrays.asList(fragSource)));

  for (int i = 0; i < filters.size (); i++) {
    String code[] = filters.get(i).getCode ().split("\n");
    for (int j = 0; j < code.length; j++) {
      fragList.add(code[j]);
    }
  }

  fragList.add("gl_FragColor = vec4(col.rgb, 1.0);"); 
  fragList.add("}");

  fragSource = fragList.toArray(new String[fragList.size()]);

  shader = new PShader(this, vertSource, fragSource);

  shader.set("resolution", float(width-200), float(height));
}

