class Tiles{
  int groupSize;
  int cw, ch;
  Tile tiles[][];
  Tiles(int groupSize){
     this.groupSize = groupSize;
     cw = width/groupSize;
     ch = height/groupSize;
     tiles = new Tile[cw][ch];
     for(int j = 0; j < ch; j++){
        for(int i = 0; i < cw; i++){
           tiles[i][j] = new Tile(cw, ch); 
        }
     }
  }
}

class Tile {
  ArrayList<Node> nodes;
  int ix, iy;
  Tile(int ix, int iy) {
    this.ix = ix;
    this.iy = iy;
    nodes = new ArrayList<Node>();
  }

  void clear() {
    nodes.clear();
  }
}
