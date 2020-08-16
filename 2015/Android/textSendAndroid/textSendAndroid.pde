//activar los permisos para usar internet, android/Sketch Permissions/ activar INTERNET

import android.view.inputmethod.InputMethodManager;
import android.view.KeyEvent.*;
import android.content.Context;
import android.widget.EditText;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress address;

InputMethodManager imm;

//poner la ip de la pc en la red
String ipPc = "192.168.0.8";
String txt = ""; 

void setup() {
  orientation(PORTRAIT);

  oscP5 = new OscP5(this, 12001);
  address = new NetAddress(ipPc, 12008);

  imm = (InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
  showVirtualKeyboard();
}

void draw() {
  if (mousePressed) {
    background(255, 128, 0);
  } else {
    background(220);
  }
  textAlign(CENTER, CENTER);
  textSize(48);
  fill(0);
  text(txt, width/2, height/2);
}

void stop() {
  hideVirtualKeyboard();
}


void mousePressed() {
}

void keyPressed() {
  if (keyCode == android.view.KeyEvent.KEYCODE_DEL) {
    if (txt.length() > 0) {
      txt = txt.substring(0, txt.length()-1);
    }
  } else {
    if (key == '\n') {
      sendMessage(txt);
      txt = "";
    } else {
      txt += key;
    }
  }
}

void sendMessage(String msg) {
  OscMessage message = new OscMessage("/test");
  message.add(msg);
  oscP5.send(message, address);
}


void showVirtualKeyboard() {
  imm.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0);
}

void hideVirtualKeyboard() {
  imm.toggleSoftInput(InputMethodManager.HIDE_IMPLICIT_ONLY, 0);
}