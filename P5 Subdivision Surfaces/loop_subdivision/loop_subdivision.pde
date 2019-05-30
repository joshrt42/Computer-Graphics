//==========================================================GLOBAL VARIABLES

//Given global vars:
float time = 0;                   // keep track of passing of time
boolean rotate_flag = true;       // automatic rotation of model?

//Joshmade global vars:
Mesh mesh = new Mesh();
boolean random_color_mode = false;
boolean per_vertex_normals = false;



//==========================================================SETUP
void setup() {
  size(700, 700, OPENGL);  // must use OPENGL here !!!
  noStroke();     // do not draw the edges of polygons
}



//==========================================================DRAW

void draw() {
  
//==========================================================GIVEN SCENE STUFF

  resetMatrix();  // set the transformation matrix to the identity (important!)
  background(0);  // clear the screen to black
  perspective (PI * 0.333, 1.0, 0.01, 1000.0); // set up for perspective projection
  camera (0.0, -1.0, 5.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);  // place camera in scene
  ambientLight(102, 102, 102); // create an ambient light source
  lightSpecular(204, 204, 204); // create two directional light sources
    directionalLight(102, 102, 102, -0.7, -0.7, -1);
    directionalLight(152, 152, 152, 0, 0, -1);
  pushMatrix();
  fill(200, 200, 200);
  ambient (200, 200, 200);
  specular(0, 0, 0);
  shininess(1.0);
  rotate (time, 0.0, 1.0, 0.0);
  
  
  
//==========================================================DRAW MESH HERE
  
  //for face in mesh, set normal
  //for vertices on face, draw vertex
  
  for (int face = 0; face < mesh.getNumFaces(); face++) {
    if (random_color_mode) {
      PVector rgb = mesh.getFaceColors().get(face);
      fill(rgb.x, rgb.y, rgb.z);
    }
    
    TableRow faceRow = mesh.geometry.getRow(face+mesh.numVertices);
    normal (faceRow.getFloat(3), faceRow.getFloat(4), faceRow.getFloat(5));
    beginShape();
    for (int v = 0; v < 3; v++) {
      TableRow vertRow = mesh.geometry.getRow(faceRow.getInt(v));
      if (per_vertex_normals) {
        normal (vertRow.getFloat(3), vertRow.getFloat(4), vertRow.getFloat(5));
      }
      vertex(vertRow.getFloat(0), vertRow.getFloat(1), vertRow.getFloat(2));
    }
    endShape(CLOSE);
  }
  
//==========================================================END MESH DRAWING
  
  
  
  popMatrix();
 
  // maybe step forward in time (for object rotation)
  if (rotate_flag)
    time += 0.02;
}

// handle keyboard input
void keyPressed() {
  if (key == '1') {
    read_mesh ("tetra.ply");
  }
  else if (key == '2') {
    read_mesh ("octa.ply");
  }
  else if (key == '3') {
    read_mesh ("icos.ply");
  }
  else if (key == '4') {
    read_mesh ("star.ply");
  }
  else if (key == '5') {
    read_mesh ("torus.ply");
  }
  else if (key == 'n') {                      // toggle per-vertex normals
    per_vertex_normals = !per_vertex_normals;
    if (per_vertex_normals) {
      println("per vertex normals enabled");
    } else {
      println("per vertex normals disabled");
    }
  }
  else if (key == 'r') {                      // toggle random colors
    if (random_color_mode) {
      random_color_mode = false;
      println("Random color mode disabled");
    } else {
      random_color_mode = true;
      mesh.generateFaceColors();
      println("Random color mode enabled");
    }
  }
  else if (key == 's') {
    mesh.subdivide();
    println("Subdivided!");
  }
  else if (key == ' ') {
    rotate_flag = !rotate_flag;          // rotate the model?
  }
  else if (key == 'q' || key == 'Q') {
    exit();                               // quit the program
  }
}

// Read polygon mesh from .ply file
//
// You should modify this routine to store all of the mesh data
// into a mesh data structure instead of printing it to the screen.
void read_mesh (String filename) {
  int i;
  String[] words;
  String lines[] = loadStrings(filename);
  mesh = new Mesh();
  
  words = split (lines[0], " ");
  mesh.setNumVertices(int(words[1]));
  println ("number of vertices = " + mesh.getNumVertices());
  
  words = split (lines[1], " ");
  mesh.setNumFaces(int(words[1]));
  println ("number of faces = " + mesh.getNumFaces());
  
//==========================================================READ VERTICES
  for (i = 0; i < mesh.getNumVertices(); i++) {
    words = split (lines[i+2], " ");
    mesh.addGeometry(float(words[0]), float(words[1]), float(words[2]));
  }
  
//==========================================================READ FACES
  for (i = 0; i < mesh.getNumFaces(); i++) {
    
    int j = i + mesh.getNumVertices() + 2;
    words = split (lines[j], " ");
    
    int nverts = int(words[0]);
    if (nverts != 3) {
      println ("error: this face is not a triangle.");
      exit();
    }
    mesh.addGeometry(int(words[1]), int(words[2]), int(words[3]));
  }
  mesh.generate();
}
