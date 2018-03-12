import android.view.inputmethod.InputMethodManager;
import android.content.Context;
import android.widget.EditText;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress address;

InputMethodManager imm;

String txt = ""; 

void setup() {
  orientation(PORTRAIT);

  oscP5 = new OscP5(this, 12001);
  address = new NetAddress("192.168.0.8", 12008);

  imm = (InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
  showVirtualKeyboard();
}

void draw() {
  if (mousePressed) {
    background(255, 128, 0);
  } else {
    background(220);
  }

  text(txt, width/2, height/2);
}


void mousePressed() {
}

void keyPressed() {
  if (keyCode == BACKSPACE) {
    if (txt.length() > 0) {
      txt = txt.substring(0, txt.length()-1);
    }
  }
  if (keyCode == ENTER) {
    sendMessage(txt);
    txt = "";
  } else {
    txt += key;
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