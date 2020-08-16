import javax.script.ScriptException;
import controlP5.*;
import javax.script.ScriptEngineManager;
import javax.script.ScriptEngine;
 
ControlP5 cp5;
 
String url1;
 
void setup() {
  size(700, 400);
  cp5 = new ControlP5(this);
  cp5.addTextfield("textInput_1").setPosition(20, 100).setSize(200, 40).setAutoClear(false);
  cp5.addBang("Submit").setPosition(240, 100).setSize(80, 40);    
 
}
 
 
void draw () {
  background(0);
}

 
void Submit() {
  url1 = cp5.get(Textfield.class,"textInput_1").getText();
  ScriptEngineManager mgr = new ScriptEngineManager();
  ScriptEngine engine = mgr.getEngineByName("JavaScript");
  try{
    println(engine.eval(url1));
  } catch (ScriptException e) {
    println("operacion no valida");
  }
  println();
}
