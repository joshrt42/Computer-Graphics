// Dummy routines for OpenGL commands.
// These are for you to write!
// You should incorporate your matrix stack routines from part A of this project.

//Keep tabs on matrix stack
int top = 0;
int max = 4;
float[][][] matrixStack = new float[max][4][4];
float[][] id3d = {{1, 0, 0, 0},
                  {0, 1, 0, 0},
                  {0, 0, 1, 0},
                  {0, 0, 0, 1}};

//Keep tabs on vector stack
int vTop = 0;
int vMax = 4;
float[][] vectorStack = new float[vMax][4];

//view left, right, top, bottom, near, and far vars
float vL;
float vR;
float vT;
float vB;
float vN;
float vF;
float vK;
boolean orthoMode = false;


// Initializes the matrix stack
void gtInitialize()
{
  top = 0;
  matrixStack[top] = id3d;
}


// Pushes a duplicate of the top onto the top.
// Sizes up the stack with gtDoubleStackSize if needed.
void gtPushMatrix()
{
  if (top >= max-1) {
    gtDoubleMatrixStackSize();
  }
  matrixStack[top+1] = matrixStack[top];
  top+=1;
}


// Pops off the top of the stack
void gtPopMatrix()
{
  if (top==0)
    println("Cannot pop the matrix stack!");
  else
    top-=1;
}





// Translates the matrix at the top of the stack by some amount
void gtTranslate(float x, float y, float z)
{
  float[][] transformMatrix = {{1, 0, 0, x},
                               {0, 1, 0, y},
                               {0, 0, 1, z},
                               {0, 0, 0, 1}};
  matrixStack[top] = gtMatrixMultiply3d(matrixStack[top], transformMatrix);
}


// Scales the matrix at the top of the stack by some amount
void gtScale(float x, float y, float z)
{
  float[][] transformMatrix = {{x, 0, 0, 0},
                               {0, y, 0, 0},
                               {0, 0, z, 0},
                               {0, 0, 0, 1}};
  matrixStack[top] = gtMatrixMultiply3d(matrixStack[top], transformMatrix);
}


// Rotates the matrix at the top of the stack about X by some amount
void gtRotateX(float theta)
{
  float[][] transformMatrix = {{1, 0,                   0,                     0},
                               {0, cos(radians(theta)), 0-sin(radians(theta)), 0},
                               {0, sin(radians(theta)), cos(radians(theta)),   0},
                               {0, 0,                   0,                     1}};
  matrixStack[top] = gtMatrixMultiply3d(matrixStack[top], transformMatrix);
}


// Rotates the matrix at the top of the stack about Y by some amount
void gtRotateY(float theta)
{
  float[][] transformMatrix = {{cos(radians(theta)),   0, sin(radians(theta)), 0},
                               {0,                     1, 0,                   0},
                               {0-sin(radians(theta)), 0, cos(radians(theta)), 0},
                               {0,                     0, 0,                   1}};
  matrixStack[top] = gtMatrixMultiply3d(matrixStack[top], transformMatrix);
}

// Rotates the matrix at the top of the stack about Z by some amount
void gtRotateZ(float theta)
{
  float[][] transformMatrix = {{cos(radians(theta)), 0-sin(radians(theta)), 0, 0},
                               {sin(radians(theta)), cos(radians(theta)),   0, 0},
                               {0,                   0,                     1, 0},
                               {0,                   0,                     0, 1}};
  matrixStack[top] = gtMatrixMultiply3d(matrixStack[top], transformMatrix);
}




// Prints the contents of the matrix on top
void print_ctm()
{
  for (int y=0; y<4; y++) {
    for (int x=0; x<4; x++) {
      if (x == 0)
        print("[ ");
      print(matrixStack[top][y][x]);
      if (x == 3)
        print(" ]");
      else
        print(", ");
    }
    print("\n");
  }
  print("\n");
}


// Multiplies 2 matrices
float[][] gtMatrixMultiply3d(float[][] a, float[][] b)
{
  float[][] c = new float[4][4];
  for (int y = 0; y<4; y++) {
    for (int x = 0; x<4; x++) {
      for (int n = 0; n<4; n++) {
        c[y][x] += a[y][n] * b[n][x];
      }
    }
  }
  return c;
}


// Doubles the size of the matrix stack
void gtDoubleMatrixStackSize()
{
  float[][][] temp = new float[max*2][4][4];
  for (int x = 0; x < max; x++) {
    temp[x] = matrixStack[x];
  }
  matrixStack = temp;
  max*=2;
}


// Doubles the size of the vector stack
void gtDoubleVectorStackSize()
{
  float[][] temp = new float[vMax*2][4];
  for (int x = 0; x < vMax; x++) {
    temp[x] = vectorStack[x];
  }
  vectorStack = temp;
  vMax*=2;
}

//Sets the code to perspective mode!
//Takes in an angle, near, and far viewpoints.
void gtPerspective(float f, float near, float far)
{
  vK = tan(radians(f)/2);
  vN = near;
  vF = far;
  orthoMode = false;
  println("Perspective Mode Enabled!");
}

//Sets the code to orthographic projection mode.
//Takes in left, right, bot, top, near, and far view boundaries.
void gtOrtho(float l, float r, float b, float t, float n, float f)
{
  vL = l;
  vR = r;
  vB = b;
  vT = t;
  vN = n;
  vF = f;
  orthoMode = true;
  println("Orthographic Mode Enabled!");
}

//Begins a shape.
//Sets vector data structure to a new blank slate
//Sets top of vector data structure to 0
void gtBeginShape()
{
  //start a new vertex stack
  vectorStack = new float[vMax][4];
  vTop = 0;
}

//Creates a vertex.
//If full, double size of data structure.
//Set vartex values to xyz1
//Multiplies transformation matrix and vector stack top.
//If ortho mode, apply transformations to x and y
//If persp mode, apply transformations to x and y
//Increment vertex stack top
void gtVertex(float x, float y, float z)
{
  if (vTop >= vMax-1) {
    gtDoubleVectorStackSize();
  }
  vectorStack[vTop][0] = x;
  vectorStack[vTop][1] = y;
  vectorStack[vTop][2] = z;
  vectorStack[vTop][3] = 1;
  vectorStack[vTop] = gtVectorMultiply(matrixStack[top],vectorStack[vTop]);
  if (orthoMode) {
    vectorStack[vTop][0] = (vectorStack[vTop][0]-vL)*width/(vR-vL);
    vectorStack[vTop][1] = (vectorStack[vTop][1]-vB)*height/(vT-vB);
  } else {
    vectorStack[vTop][0] = (vectorStack[vTop][0]/(abs(vectorStack[vTop][2]))+vK)*(width/(2.0*vK));
    vectorStack[vTop][1] = (vectorStack[vTop][1]/(abs(vectorStack[vTop][2]))+vK)*(height/(2.0*vK));
  }
  vTop+=1;
}

//Draw lines by incrementing value by 2 and drawing previous 2 vertices
void gtEndShape()
{
  for (int n = 1; n <= vTop; n += 2) {
    line(vectorStack[n-1][0], height-vectorStack[n-1][1], vectorStack[n][0], height-vectorStack[n][1]);
  }
}

//Multiplies a vector by a transformation matrix
float[] gtVectorMultiply(float[][] m, float[] v)
{
  float[] temp = new float[4];
  for (int row = 0; row < 4; row++) {
    for (int col = 0; col < 4; col++) {
      temp[row] += (m[row][col] * v[col]);
    }
  }
  return temp;
}
