import java.util.List;

public class Icosahedron {

  public List<Float> vertexNormalsList = new ArrayList<Float>();
  public List<Float> vertexList = new ArrayList<Float>();

  final float X = 0.525731112119133606f;
  final float Z = 0.850650808352039932f;

  int ICOSUBDIVISION = 0;

  final float vdata[][] = { 
    { -X, 0.0f, Z }, 
    { X, 0.0f, Z }, 
    { -X, 0.0f, -Z }, 
    { X, 0.0f, -Z }, 
    { 0.0f, Z, X }, 
    { 0.0f, Z, -X }, 
    { 0.0f, -Z, X }, 
    { 0.0f, -Z, -X }, 
    { Z, X, 0.0f }, 
    { -Z, X, 0.0f }, 
    { Z, -X, 0.0f }, 
    { -Z, -X, 0.0f }
  };

  final int tindices[][] = { { 0, 4, 1 }, { 0, 9, 4 }, { 9, 5, 4 }, 
    { 4, 5, 8 }, { 4, 8, 1 }, { 8, 10, 1 }, { 8, 3, 10 }, 
    { 5, 3, 8 }, { 5, 2, 3 }, { 2, 7, 3 }, { 7, 10, 3 }, 
    { 7, 6, 10 }, { 7, 11, 6 }, { 11, 0, 6 }, { 0, 1, 6 }, 
    { 6, 1, 10 }, { 9, 0, 11 }, { 9, 11, 2 }, { 9, 2, 5 }, 
    { 7, 2, 11 } };

  public Icosahedron() {
    
    init();
    
  }
  
  public void init(){

    List<Float> texCoordsList = new ArrayList<Float>();
    List<Integer> indicesList = new ArrayList<Integer>();

    // Iterate over points
    for (int i = 0; i < 20; ++i) {
      subdivide(
        vdata[tindices[i][0]], 
        vdata[tindices[i][1]], 
        vdata[tindices[i][2]], ICOSUBDIVISION );
    }

    // verticesArray = floatListToFloatArray(vertexList);
    // texCoordsArray = floatListToFloatArray(texCoordsList);
    // vertexNormalsArray = floatListToFloatArray(vertexNormalsList);
    // indices = integerListToIntegerArray(indicesList);
    // vertexCount = vertexList.size() / 3;
  }

  private void norm(float v[]) {

    float len = 0;

    for (int i = 0; i < 3; ++i) {
      len += v[i] *  v[i];
    }

    len = (float) Math.sqrt(len);

    for (int i = 0; i < 3; ++i) {
      v[i] /= len;
    }
  }

  private void add(float v[]) {
    for (int k = 0; k < 3; ++k) {
      vertexList.add(v[k]);
      vertexNormalsList.add(v[k]);
    }
  }

  private void subdivide(float v1[], float v2[], float v3[], int depth) {

    if (depth == 0) {
      add(v1);
      add(v2);
      add(v3);
      return;
    }

    float v12[] = new float[3];
    float v23[] = new float[3];
    float v31[] = new float[3];

    for (int i = 0; i < 3; ++i) {
      v12[i] = (v1[i] + v2[i]) / 2f;
      v23[i] = (v2[i] + v3[i]) / 2f;
      v31[i] = (v3[i] + v1[i]) / 2f;
    }

    norm(v12);
    norm(v23);
    norm(v31);

    subdivide(v1, v12, v31, depth - 1);
    subdivide(v2, v23, v12, depth - 1);
    subdivide(v3, v31, v23, depth - 1);
    subdivide(v12, v23, v31, depth - 1);
  }

  void show(float size) {
    PVector f1 = new PVector();
    PVector f2 = new PVector();
    PVector f3 = new PVector();
    for ( int i = 0; i < vertexList.size(); i+=9 ) {
      f1.x = vertexList.get(i+0) * size;
      f1.y = vertexList.get(i+1) * size;
      f1.z = vertexList.get(i+2) * size;
      f2.x = vertexList.get(i+3) * size;
      f2.y = vertexList.get(i+4) * size;
      f2.z = vertexList.get(i+5) * size;
      f3.x = vertexList.get(i+6) * size;
      f3.y = vertexList.get(i+7) * size;
      f3.z = vertexList.get(i+8) * size;
      beginShape();
      vertex( f1.x, f1.y, f1.z );
      vertex( f2.x, f2.y, f2.z );
      vertex( f3.x, f3.y, f3.z );
      endShape( CLOSE );
    }
  }
}
