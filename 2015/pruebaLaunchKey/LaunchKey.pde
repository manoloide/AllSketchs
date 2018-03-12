class Knob {
  int value;
  Knob() {
    init();
  }
  void init() {
    value = 0;
  }
  float get() {
    return value/128.;
  }
  int getValue() {
    return value;
  }
}

class Pad {
  boolean press, click;
  int value;
  Pad() {
    init();
  }

  void init() {
    press = click = false;
    value = 0;
  }

  void update() {
    click = false;
  }

  void pressed(int val) {
    click = true;
    press = true;
    value = val;
  }

  void released(int val) {
    press = false;
    value = val;
  }

  float get() {
    return value/128.;
  }
  int getValue() {
    return value;
  }
}

class Note {
  boolean press, click;
  int note, velocity;
  Note(int note) {
    this.note = note;
    init();
  }

  void init() {
    press = click = false;
    note = velocity = 0;
  }

  void update() {
    click = false;
  }

  void pressed(int vel) {
    click = true;
    press = true;
    velocity = vel;
  }

  void released(int vel) {
    press = false;
    velocity = vel;
  }

  float get() {
    return note;
  }
}

class LaunchKey {
  Pad[] control;
  Knob[] knob;
  Note[] note;
  Pad[] pad;

  LaunchKey() {
    control = new Pad[8];
    for (int i = 0; i < control.length; i++) {
      control[i] = new Pad();
    }
    knob = new Knob[8];
    for (int i = 0; i < knob.length; i++) {
      knob[i] = new Knob();
    }
    note = new Note[128];
    for (int i = 0; i < note.length; i++) {
      note[i] = new Note(i);
    }
    pad = new Pad[16];
    for (int i = 0; i < pad.length; i++) {
      pad[i] = new Pad();
    }
  }

  void update() {
    for (int i = 0; i < control.length; i++) {
      control[i].update();
    }
    for (int i = 0; i < pad.length; i++) {
      pad[i].update();
    }
  }

  void recibe(byte[] data) {
    // You can also use rawMidi(byte[] data, String bus_name)
    // Receive some raw data
    // data[0] will be the status byte
    // data[1] and data[2] will contain the parameter of the message (e.g. pitch and volume for noteOn noteOff)
    int command = (int)(data[0] & 0xFF);
    println("Status Byte/MIDI Command:"+command);
    // N.B. In some cases (noteOn, noteOff, controllerChange, etc) the first half of the status byte is the command and the second half if the channel
    // In these cases (data[0] & 0xF0) gives you the command and (data[0] & 0x0F) gives you the channel
    int[] params = new int[data.length-1];
    for (int i = 1; i < data.length; i++) {
      int param = (int)(data[i] & 0xFF);
      params[i-1] = param;
      println("Param "+(i)+": "+param);
    }

    if (command == 176) {
      if (params[0] >= 21 && params[0] < 29) {
        knob[params[0]-21].value = params[1];
      } else if (params[0] >= 112 && params[0] < 118) {
        if (params[1] == 0) {
          control[params[0]-112].released(params[1]);
        } else {
          control[params[0]-112].pressed(params[1]);
        }
      } else if (params[0] >= 104 && params[0] < 106) {
        if (params[1] == 0) {
          control[params[0]-98].released(params[1]);
        } else {
          control[params[0]-98].pressed(params[1]);
        }
      }
    } else if (command == 144) {
      note[params[0]].pressed(params[1]);
    } else if (command == 128) {
      note[params[0]].released(params[1]);
    } else if (command == 153) {
      if (params[0] >= 36 && params[0] < 52) {
        pad[params[0]-36].pressed(params[1]);
      }
    } else if (command == 137) {
      if (params[0] >= 36 && params[0] < 52) {
        pad[params[0]-36].released(params[1]);
      }
    }
  }
}
