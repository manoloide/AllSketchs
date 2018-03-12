void agregarOrdenado(ArrayList<Punto> l, Punto d) {
  if (l.size() == 0) {
    l.add(d);
  }
  else {
    int k = 0;
    while (k < l.size () && d.ang >= l.get(k).ang) {
      k++;
    }
    if (k == l.size()) {
      l.add(d);
    }
    else {
      l.add(k, d);
    }
  }
}
