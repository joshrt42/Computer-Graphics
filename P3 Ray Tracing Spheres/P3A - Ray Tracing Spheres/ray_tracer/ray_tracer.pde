// This is the starter code for the CS 3451 Ray Tracing project.
//
// The most important part of this code is the interpreter, which will
// help you parse the scene description (.cli) files.

//========================================================================GLOBAL VARS
float fovAngle;
float dScalar;
float t;
Vector eye;
Vector u;
Vector v;
Vector w;
Color backgroundColor;
Color objectColor;
Material material = new Material();
Light[] lights = new Light[10];
int lightNum = 0;
Sphere[] spheres = new Sphere[10];
int sphereNum = 0;
Sphere hitSphere;
Vector hitOrigin;
Vector hitNormal;
Cone[] cones = new Cone[10];
int coneNum = 0;


//========================================================================SETUP
void setup() {
  size(400, 400);  
  noStroke();
  colorMode(RGB);
  background(0, 0, 0);
}


//========================================================================SCENE RESET METHOD
void reset_scene() {
  //reset your global scene variables here
  fovAngle = 0;
  eye = new Vector();
  u = new Vector();
  v = new Vector();
  w = new Vector();
  backgroundColor = new Color();
  objectColor = new Color();
  material = new Material();
  lights = new Light[10];
  lightNum = 0;
  spheres = new Sphere[10];
  sphereNum = 0;
  hitSphere = new Sphere();
  hitOrigin = new Vector();
  hitNormal = new Vector();
  cones = new Cone[10];
  coneNum = 0;
  dScalar = 0;
  t = 0;
}


//========================================================================KEYPRESS LISTENERS
void keyPressed() {
  reset_scene();
  switch(key) {
    case '1':  interpreter("01_one_sphere.cli"); break;
    case '2':  interpreter("02_three_spheres.cli"); break;
    case '3':  interpreter("03_shiny_sphere.cli"); break;
    case '4':  interpreter("04_one_cone.cli"); break;
    case '5':  interpreter("05_more_cones.cli"); break;
    case '6':  interpreter("06_ice_cream.cli"); break;
    case '7':  interpreter("07_colorful_lights.cli"); break;
    case '8':  interpreter("08_reflective_sphere.cli"); break;
    case '9':  interpreter("09_mirror_spheres.cli"); break;
    case '0':  interpreter("10_reflections_in_reflections.cli"); break;
    case 'q':  exit(); break;
  }
}



//========================================================================INTERPRETER
// this routine helps parse the text in a scene description file
void interpreter(String filename) {
  
  println("Parsing '" + filename + "'");
  String str[] = loadStrings(filename);
  if (str == null) println("Error! Failed to read the file.");
  
  for (int i = 0; i < str.length; i++) {
    
    String[] token = splitTokens(str[i], " "); // Get a line and parse tokens.
    
    if (token.length == 0) continue; // Skip blank line.
    
    if (token[0].equals("fov")) {
      float fov = float(token[1]);
      // call routine to save the field of view
      println("fov in degrees: " + fov);
      fovAngle = radians(fov);
      println("fov in radians: " + fovAngle);
      dScalar = 1.0/(tan(fovAngle/2.0));
    }//========================================================================BACKGROUND
    else if (token[0].equals("background")) {
      float r = float(token[1]);
      float g = float(token[2]);
      float b = float(token[3]);
      // call routine to save the background color
      backgroundColor = new Color(r, g, b);
    }//========================================================================EYE
    else if (token[0].equals("eye")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      // call routine to save the eye position
      eye = new Vector(x, y, z);
    }//========================================================================UVW
    else if (token[0].equals("uvw")) {
      float ux = float(token[1]);
      float uy = float(token[2]);
      float uz = float(token[3]);
      float vx = float(token[4]);
      float vy = float(token[5]);
      float vz = float(token[6]);
      float wx = float(token[7]);
      float wy = float(token[8]);
      float wz = float(token[9]);
      // call routine to save the camera u,v,w
      u = new Vector(ux, uy, uz);
      v = new Vector(vx, vy, vz);
      w = new Vector(wx, wy, wz);
    }//========================================================================LIGHTS
    else if (token[0].equals("light")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float r = float(token[4]);
      float g = float(token[5]);
      float b = float(token[6]);
      // call routine to save light information
      lights[lightNum] = new Light(new Vector(x, y, z), new Color(r, g, b));
      lightNum++;
    }//========================================================================SURFACE MATERIALS
    else if (token[0].equals("surface")) {
      float Cdr = float(token[1]);
      float Cdg = float(token[2]);
      float Cdb = float(token[3]);
      float Car = float(token[4]);
      float Cag = float(token[5]);
      float Cab = float(token[6]);
      float Csr = float(token[7]);
      float Csg = float(token[8]);
      float Csb = float(token[9]);
      float P = float(token[10]);
      float K = float(token[11]);
      // call routine to save surface materials
      material = new Material(new Color(Cdr, Cdg, Cdb), new Color(Car, Cag, Cab), new Color(Csr, Csg, Csb), P, K);
    }//========================================================================SPHERES
    else if (token[0].equals("sphere")) {
      float r = float(token[1]);
      float x = float(token[2]);
      float y = float(token[3]);
      float z = float(token[4]);
      // call routine to save sphere
      spheres[sphereNum] = new Sphere(new Vector(x, y, z), r, material);
      sphereNum++;
    }//========================================================================CONES
    else if (token[0].equals("cone")) {
      float x = float(token[1]);
      float y = float(token[2]);
      float z = float(token[3]);
      float h = float(token[4]);
      float k = float(token[5]);
      // call routine to save cone
      cones[coneNum] = new Cone(new Vector(x, y, z), h, k);
      coneNum++;
    }
    else if (token[0].equals("write")) {
      draw_scene();   // this is where you actually perform the ray tracing
      println("Saving image to '" + token[1] + "'");
      save(token[1]); // this saves your ray traced scene to a PNG file
    }
    else if (token[0].equals("#")) {
      // comment symbol
    }
    else {
      println ("cannot parse line: " + str[i]);
    }
  }
}


//========================================================================SCENE DRAWING
void draw_scene() {
  for(int y = 0; y < height; y++) {
    for(int x = 0; x < width; x++) {
      float uScalar = -1 + ((2.0*x)/width);        //eye ray u
      float vScalar = -1 + ((2.0*y)/height);       //eye ray v
      
      Vector rayOrigin = eye;                                       //creates eye Ray origin @ eye
      Vector rayDirection = w.scalarMultiply(0-dScalar)             //-dw
                            .addVector(u.scalarMultiply(uScalar))   //+uu
                            .addVector(v.scalarMultiply(vScalar));  //+vv
      rayDirection.setY(rayDirection.getY()*(-1));                  //Invert ray direction vector to make it draw properly
      Ray eyeRay = new Ray(rayOrigin, rayDirection);                //Create eye ray from origin to direction vector
        
      fill(255*backgroundColor.getR(), 255*backgroundColor.getG(), 255*backgroundColor.getB());
      rect (x, y, 1, 1);                                            //Fill in background
      
      for (int s = 0; s < sphereNum; s++) {                         //For each sphere,
        t = spheres[s].intersect(eyeRay);                           //Check for intersections
        objectColor = new Color();                                  //And make a new color for the sphere
        if (t != 0.0) {                                                                //If the hit is visible
          hitSphere = spheres[s];                                                      //Save the sphere
          hitOrigin = rayOrigin.addVector(rayDirection.scalarMultiply(t));             //Draw a vector to the hit
          hitNormal = (hitOrigin.subtractVector(hitSphere.getOrigin())).getNormal();   //Find surface normal at the hit location
          for (int l = 0; l < lightNum; l++) {                                                    //For each light in the scene,
            Vector lightVector = (lights[l].getPosition().subtractVector(hitOrigin)).getNormal(); //Make a vector to that point and color accordingly
            objectColor.setR(objectColor.getR() + lights[l].getColor().getR() * max(0, hitNormal.dotProduct(lightVector)));
            objectColor.setG(objectColor.getG() + lights[l].getColor().getG() * max(0, hitNormal.dotProduct(lightVector)));
            objectColor.setB(objectColor.getB() + lights[l].getColor().getB() * max(0, hitNormal.dotProduct(lightVector)));
          }
          objectColor.setR(objectColor.getR() * hitSphere.getMaterial().getDiffuse().getR());      //Color pixel based on material diffuse R and light R
          objectColor.setG(objectColor.getG() * hitSphere.getMaterial().getDiffuse().getG());      //G
          objectColor.setB(objectColor.getB() * hitSphere.getMaterial().getDiffuse().getB());      //B
          //println("R: " + objectColor.getR() * 255+ "    G: " + objectColor.getG() * 255+ "    B: " + objectColor.getB()* 255);
          fill(objectColor.getR() * 255, objectColor.getG() * 255, objectColor.getB() * 255);
          rect(x, y,1, 1);
          //println("hit!");
        }
      }
    }
  }
}

void draw() {
  // nothing should be placed here for this project!
}
