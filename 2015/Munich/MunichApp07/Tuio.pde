void addTuioCursor(TuioCursor cur) {
  touchManager.addTouch(cur.getCursorID(), cur.getX()*width, cur.getY()*height);
}

void updateTuioCursor (TuioCursor cur) {
  touchManager.updateTouch(cur.getCursorID(), cur.getX()*width, cur.getY()*height);
}

void removeTuioCursor(TuioCursor cur) {
  touchManager.removeTouch(cur.getCursorID());
}

void addTuioObject(TuioObject tobj) {
}

void updateTuioObject (TuioObject tobj) {
}

void removeTuioObject(TuioObject tobj) {
}

void addTuioBlob(TuioBlob tblb) {
}

void updateTuioBlob (TuioBlob tblb) {
}

void removeTuioBlob(TuioBlob tblb) {
}

void refresh(TuioTime frameTime) {
}
