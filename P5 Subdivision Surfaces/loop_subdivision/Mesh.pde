public class Mesh {
  
  
  
//==========================================================GLOBAL VARS

  public Table corners;
  public Table opposites;
  public Table geometry;
  public ArrayList<PVector> faceColors;
  public int numFaces;
  public int numVertices;
  
  public Table newEdges;

  
  
//==========================================================CONSTRUCTORS

  public Mesh(Table corners,
              Table opposites,
              Table geometry,
              ArrayList<PVector> faceColors,
              int numFaces,
              int numVertices,
              Table newEdges) {
    this.corners = corners;
      this.corners.addColumn("0");
      this.corners.addColumn("1");
      
    this.opposites = opposites;
      this.opposites.addColumn("0");
      this.opposites.addColumn("1");
      this.opposites.addColumn("2");
      
    this.geometry = geometry;
      this.geometry.addColumn("0");
      this.geometry.addColumn("1");
      this.geometry.addColumn("2");
      this.geometry.addColumn("3");
      this.geometry.addColumn("4");
      this.geometry.addColumn("5");
      this.geometry.addColumn("6");
      this.geometry.addColumn("7");
      
    this.faceColors = faceColors;
    this.numFaces = numFaces;
    this.numVertices = numVertices;
    
    this.newEdges = newEdges;
      this.newEdges.addColumn("0");
      this.newEdges.addColumn("1");
  }
  
  public Mesh() {
    this(new Table(),
         new Table(),
         new Table(),
         new ArrayList<PVector>(),
         0,
         0,
         new Table());
  }
  
  
  
//==========================================================HELPER METHODS
  
  public void generate() {
    println("==========================================================Generating:");
    
    println("Num Vertices: " + this.numVertices + "\t\tNum Faces: " + this.numFaces);
    
    generateCorners();
    generateOpposites();
    generateFaceNormals();
    generateVertexNormals();
    generateFaceColors();
    
    println("\n\n========================GEOMETRY TABLE BEGIN========================");
    for (int r = 0; r < this.geometry.getRowCount(); r++) {
      if (r < this.numVertices) {
        print("Vertex:\t");
        for (int dim = 0; dim < 7; dim++) {
          print(this.geometry.getFloat(r, dim) + "\t");
          if (dim == 2) {
            print("\t\t");
          }
          if (dim == 5) {
            print("\t\tCorner:\t");
          }
        }
        println(" ");
      } else {
        print("Face: \t");
        for (int dim = 0; dim < 6; dim++) {
          print(this.geometry.getFloat(r, dim) + "\t");
          if (dim == 2) {
            print("\t\t");
          }
        }
        println(" ");
      }
    }
    println("========================GEOMETRY TABLE END========================\n\n");
    
  }
  
  public void generateCorners() {
    println("Generating Corners: ");
    this.corners = new Table();
      this.corners.addColumn("0");
      this.corners.addColumn("1");
    for (int i = 0; i < this.numFaces; i++) {
      TableRow face = this.geometry.getRow(this.numVertices + i);
      for (int j = 0; j < 3; j++) {
        TableRow row = this.corners.addRow();
        row.setInt(1, i*3 + j);
        row.setInt(0, face.getInt(j));
        this.geometry.setInt(row.getInt(0), 6, row.getInt(1));
      }
    }
    //print corner table
    for (int row = 0; row < this.corners.getRowCount(); row++) {
      for (int dim = 0; dim < 2; dim++) {
        print("\t" + this.corners.getInt(row, dim));
      }
      println(" ");
    }
  }
  
  public void generateOpposites() {
    println("Generating Opposite Table:");
    this.opposites = new Table();
      this.opposites.addColumn("0");
      this.opposites.addColumn("1");
      this.opposites.addColumn("2");
      this.opposites.addColumn("3");
    for (int r = 0; r < this.corners.getRowCount(); r++) {
      this.opposites.addRow();
      this.opposites.setInt(r, 0, r);   //corner no
      this.opposites.setInt(r, 1, this.corners.getInt(r, 0));//corresponding vertex
      this.opposites.setInt(r, 2, -1);  //-1 to show it failed to find an opposite
      this.opposites.setInt(r, 3, 0);
    }
    
    int count = 0;
    
    for (int a = 0; a < this.opposites.getRowCount(); a++) {
      for (int b = 0; b < this.opposites.getRowCount(); b++) {
        if (this.opposites.getInt(cornerNext(a), 1) == this.opposites.getInt(cornerPrev(b), 1)
         && this.opposites.getInt(cornerPrev(a), 1) == this.opposites.getInt(cornerNext(b), 1)
         && this.opposites.getInt(a, 3) < 1
         && this.opposites.getInt(b, 3) < 1) {
           println("Opposite " + count + "  \t");
           count++;
           this.opposites.setInt(a, 2, this.opposites.getInt(b, 0));
           this.opposites.setInt(b, 2, this.opposites.getInt(a, 0));
           this.opposites.setInt(a, 3, 1);
           this.opposites.setInt(b, 3, 1);
         }
      }
    }
    
    //print opposites table
    for (int row = 0; row < this.opposites.getRowCount(); row++) {
      this.opposites.setInt(row, 3, 0);
      for (int dim = 0; dim < 4; dim++) {
        print("\t" + this.opposites.getInt(row, dim));
      }
      println(" ");
    }
  }
  
  public void generateFaceNormals() {
    println("Generating Face Normals");
    for (int i = 0; i < this.numFaces; i++) {
      int[] vertices = new int[3];
      for (int v = 0; v < 3; v++) {
        vertices[v] = this.geometry.getRow(i + this.numVertices).getInt(v);
      }
      PVector A = new PVector(this.geometry.getRow(vertices[0]).getFloat(0),
                              this.geometry.getRow(vertices[0]).getFloat(1),
                              this.geometry.getRow(vertices[0]).getFloat(2));
      PVector B = new PVector(this.geometry.getRow(vertices[1]).getFloat(0),
                              this.geometry.getRow(vertices[1]).getFloat(1),
                              this.geometry.getRow(vertices[1]).getFloat(2));
      PVector C = new PVector(this.geometry.getRow(vertices[2]).getFloat(0),
                              this.geometry.getRow(vertices[2]).getFloat(1),
                              this.geometry.getRow(vertices[2]).getFloat(2));
      PVector dir = (PVector.sub(A, B).cross(PVector.sub(A, C))).normalize();
      
      for (int dim = 3; dim < 6; dim++) {
        this.geometry.getRow(i + this.numVertices).setFloat(dim, dir.array()[dim - 3]);
      }
    }
  }
  
  public void generateVertexNormals() {
    println("Generating Vertex Normals");
    for (int i = 0; i < this.numVertices; i++) {
      float[] vals = new float[3];
      for (int face = 0; face < this.numFaces; face++) {
        for (int v = 0; v < 3; v++) {
          if (this.geometry.getFloat(this.numVertices + face, v) == i) {
            for (int d = 0; d < 3; d++) {
              vals[d] += this.geometry.getFloat(this.numVertices + face, d+3);
            }
          }
        }
      }
      PVector dir = new PVector(vals[0], vals[1], vals[2]);
      dir.normalize();
      for (int dim = 3; dim < 6; dim++) {
        this.geometry.setFloat(i, dim, dir.array()[dim - 3]);
      }
    }
  }
  
  public void generateFaceColors() {
    println("Generating Face Colors");
    this.faceColors = new ArrayList<PVector>();
    for (int i = 0; i < this.numFaces; i++) {
      this.faceColors.add(new PVector(random(255), random(255), random(255)));
    }
  }
  
  public boolean contains(Table t, int a, int b) {
    if (a == b) {
      return true;
    }
    
    for (int row = 0; row < t.getRowCount(); row++) {
      int v1 = t.getRow(row).getInt(0);
      int v2 = t.getRow(row).getInt(1);
      if (v1 == a && v2 == b || v1 == b && v2 == a) {
        return true;
      }
    }
    return false;
  }
  
  public int cornerNext(int c) {
    return (3 * cornerFace(c) + ((c+1) % 3));
  }
  
  public int cornerPrev(int c) {
    return cornerNext(cornerNext(c));
  }
  
  public int cornerFace(int c) {
    return (c/3);
  }
  
  public int cornerLeft(int c) {
    return cornerOpposite(cornerPrev(c));
  }
  
  public int cornerRight(int c) {
    return cornerOpposite(cornerNext(c));
  }
  
  public int cornerSwing(int c) {
    return cornerNext(cornerRight(c));
  }
  
  public int cornerOpposite(int c) {
    return this.opposites.getRow(c).getInt(2);
  }
  
  public void markCornerDone(int n) {
    for (int corner = 0; corner < this.opposites.getRowCount(); corner++) {
      if (this.opposites.getInt(corner, 0) == n || this.opposites.getInt(corner, 2) == n) {
        this.opposites.setInt(corner, 3, 1);
      }
    }
  }
  
  
  
//==========================================================GETTERS

  public Table getCorners() {
    return this.corners;
  }
  public Table getOpposites() {
    return this.opposites;
  }
  public Table getGeometry() {
    return this.geometry;  
  }
  public ArrayList<PVector> getFaceColors() {
    return this.faceColors;
  }
  public int getNumFaces() {
    return this.numFaces;
  }
  public int getNumVertices() {
    return this.numVertices;
  }
  
  
  
//==========================================================SETTERS

  public void setCorners(Table corners) {
    this.corners = corners;
  }
  public void setOpposites(Table opposites) {
    this.opposites = opposites;
  }
  public void setGeometry(Table geometry) {
    this.geometry = geometry;
  }
  public void setFaceColors(ArrayList<PVector> faceColors) {
    this.faceColors = faceColors;
  }
  public void setNumFaces(int numFaces) {
    this.numFaces = numFaces;
  }
  public void setNumVertices(int numVertices) {
    this.numVertices = numVertices;
  }



//==========================================================ADDERS

  public void addCorner(int vertex) {
    TableRow row = this.corners.addRow();
    row.setInt(0, this.corners.getRowCount());
    row.setInt(1, vertex);
  }
  public void addOpposite(float[] opposite) {
    TableRow row = this.opposites.addRow();
    for (int i = 0; i < 3; i++) {
      row.setFloat(i, opposite[i]);
    }
  }
  public void addGeometry(float x, float y, float z) {
    float[] coords = {x, y, z};
    TableRow row = this.geometry.addRow();
    for (int i = 0; i < 3; i++) {
      row.setFloat(i, coords[i]);
    }
  }
  public void addFaceColor(int index, PVector newColor) {
    this.faceColors.add(index, newColor);
  }
  public void incrementNumFaces() {
    this.numFaces += 1;
  }
  public void incrementNumVertices() {
    this.numVertices += 1;
  }

//==========================================================SUBDIVIDE MESH
  
  public void subdivide() {
    println("==========================================================Subdividing:");
    //create new geometry mesh
    Table subdivided = new Table();
    int oldVertices = this.numVertices;
    
    println("Creating new vertices");
    subdivided = createNewVertices();
    
    println("Moving " + this.numVertices + " old vertices");
    subdivided = moveOldVertices(subdivided, this.numVertices);
    this.numVertices = subdivided.getRowCount();
    println("\tTotal vertices, old and new: " + this.numVertices);
    
    println("Generating faces");
    subdivided = addFaces(subdivided, oldVertices);
    println("\tTotal faces: " + (subdivided.getRowCount()-this.numVertices));
    
    //update geometry
    println("Updating geometry");
    this.geometry = subdivided;
    this.generate();
  }

//==========================================================SUBDIVIDE MESH HELPERS
  
  public Table createNewVertices() {
    
    Table subdivided = new Table();                                    //Create temp geometry table
    for(int col = 0; col < 8; col++) {
      subdivided.addColumn(str(col));
    }
    
    Table edges = new Table();                                    //Create temp corners table
    for (int col = 0; col < 2; col++) {
      edges.addColumn(str(col));
    }
    
    for (int v = 0; v < this.numVertices; v++) {                       //Add old vertices to that geometry table
      TableRow row = subdivided.addRow();
      for (int dim = 0; dim < 7; dim++) {
        row.setFloat(dim, this.geometry.getFloat(v, dim));
      }
    }
    
    for (int c = 0; c < this.opposites.getRowCount(); c++) {
      if (this.opposites.getInt(c, 3) < 1) {
        float[] newVertexData = new float[3];
        int[] vert = new int[4];
        vert[0] = this.opposites.getInt(c,                 1);       // 1/8 vert
        vert[1] = this.opposites.getInt(cornerOpposite(c), 1);       // 1/8 vert
        vert[2] = this.opposites.getInt(cornerNext(c),     1);       // 3/8 vert
        vert[3] = this.opposites.getInt(cornerPrev(c),     1);       // 3/8 vert
        
        for (int v = 0; v < 2; v++) {                                              //add the 1/8 vals
          for (int dim = 0; dim < 3; dim++) {
            newVertexData[dim] += (this.geometry.getFloat(vert[v], dim)/8.0);
          }
        }
        
        for (int v = 2; v < 4; v++) {                                              //add the 3/8 vals
          for (int dim = 0; dim < 3; dim++) {
            newVertexData[dim] += (this.geometry.getFloat(vert[v], dim)*3.0/8.0);
          }
        }
        
        TableRow newVertex = subdivided.addRow();
        for (int dim = 0; dim < 3; dim++) {
          newVertex.setFloat(dim, newVertexData[dim]);
        }
        
        TableRow edge1 = edges.addRow();
          edge1.setInt(0, vert[2]);
          edge1.setInt(1, subdivided.getRowCount() - 1);
        TableRow edge2 = edges.addRow();
          edge2.setInt(0, vert[3]);
          edge2.setInt(1, subdivided.getRowCount() - 1);
        
        markCornerDone(c);
      }
    }
    this.newEdges = edges;
    return subdivided;
  }
  
  
  
  public Table moveOldVertices(Table subdivided, int num) {
    Table newVerts = subdivided;
    for (int v = 0; v < num; v++) {
      
      float[] vertex = new float[]{
        this.geometry.getFloat(v, 0),
        this.geometry.getFloat(v, 1),
        this.geometry.getFloat(v, 2)};
      float[] neighbors = new float[3];
      
      int corner = this.geometry.getInt(v, 6);
      int swing = corner;
      int nextVert = 0;
      int n = 0;
      float beta = 3.0/16.0;
      
      while (n== 0 || swing != corner) {
        nextVert = this.opposites.getInt(cornerNext(swing), 1);
        for (int dim = 0; dim < 3; dim++) {
          neighbors[dim] += this.geometry.getFloat(nextVert, dim);
        }
        swing = cornerSwing(swing);
        n++;
      }
      
      if (n > 3) {
        beta = 3.0/(8.0*n);
      }
      for (int dim = 0; dim < 3; dim++) {
        vertex[dim] = (vertex[dim] * (1.0 - n * beta)) + (neighbors[dim] * beta); 
        newVerts.setFloat(v, dim, vertex[dim]);
      }
    }
    return newVerts;
  }
  
  
  
  public Table addFaces(Table subdivided, int num){
    
    this.numFaces = 0;
    
    Table tempGeometry = subdivided;
    
    for (int o = 0; o < this.opposites.getRowCount(); o++) {
      this.opposites.setInt(o, 3, 0);
    }
    
    for (int v0 = 0 ; v0 < num; v0++) {                    //for each old vertex
      int corner = this.geometry.getInt(v0, 6);
      int swing = corner;
      int n = 0;
      
      while (n == 0 || swing != corner) {               //for each corner of that vertex
        if (this.opposites.getInt(swing, 3) < 1) {      //if that corner's face has not yet been traversed
          int next = cornerNext(swing);
          int v1 = this.opposites.getInt(next, 1);
          int prev = cornerPrev(swing);
          int v2 = this.opposites.getInt(prev, 1);
          
          //println("  Tri formed by " + v0 + "\t" + v1 + "\t" + v2);
          //println("  Corners:      " + corner + "\t" + next + "\t" + prev);
          
          int v3 = getMidpoint(v0, v1);
          int v4 = getMidpoint(v1, v2);
          int v5 = getMidpoint(v2, v0);
          
          tempGeometry = addFace(tempGeometry, v0, v3, v5);
          tempGeometry = addFace(tempGeometry, v3, v1, v4);
          tempGeometry = addFace(tempGeometry, v5, v4, v2);
          tempGeometry = addFace(tempGeometry, v3, v4, v5);
          
          this.opposites.setInt(swing, 3, 1);
          this.opposites.setInt(next, 3, 1);
          this.opposites.setInt(prev, 3, 1);
        }
        
        swing = cornerSwing(swing);
        n++;
      }
    }
    
    return tempGeometry;
  }
  
  public int getMidpoint(int a, int b) {
    for (int i = 0; i < this.newEdges.getRowCount(); i++) {
      for (int j = 0; j < this.newEdges.getRowCount(); j++) {
        if (this.newEdges.getInt(i, 0) == a && this.newEdges.getInt(j, 0) == b && i != j && this.newEdges.getInt(i, 1) == this.newEdges.getInt(j, 1)) {
          return this.newEdges.getInt(i, 1);
        }
      }
    }
    return -1;
  }
  
  public Table addFace(Table table, int x, int y, int z) {
    Table temp = table;
    TableRow row = temp.addRow();
    row.setInt(0, x);
    row.setInt(1, y);
    row.setInt(2, z);
    //println("\tAdding Face " + this.numFaces + ":  \t" + x + "\t" + y + "\t" + z);
    this.numFaces++;
    return temp;
  }
}
