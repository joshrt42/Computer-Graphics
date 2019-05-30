/*Helper methods for shapes and light all go here!
 *
 *  workspace
 *
 *  cylinder
 *  setLight
 *  setCamera
 *  resetDraw
 *  drawSetup
 *******************************************************/

//====================WORKSPACE BEGIN



//====================WORKSPACE END


/* Set material to red
 * used in red of body
 *******************************************************/
void materialRed()
{
  fill (220, 100, 100);
  ambient (220, 80, 80);
  specular (25, 25, 25);
  shininess (2.0);
}


/* Set material to blue
 * used in blue of body
 *******************************************************/
void materialBlue()
{
  fill (80, 140, 150);
  ambient (80, 140, 150);
  specular (25, 25, 25);
  shininess (2.0);
}


/* Set material to white
 * used in eye whites
 *******************************************************/
void materialWhite()
{
  fill (240, 240, 240);
  ambient (240, 240, 240);
  specular (25, 25, 25);
  shininess (50.0);
}


/* Set material to black
 * used in pupils
 *******************************************************/
void materialBlack()
{
  fill (10, 10, 10);
  ambient (0, 0, 0);
  specular (10, 10, 10);
  shininess (50.0);
}


/* Set material to blue
 * used in blue of body
 *******************************************************/
void materialFunky()
{
  fill (abs(50*sin(time)), 20, abs(50*cos(time)));
  ambient (0, 0, 0);
  specular (100, 100, 100);
  shininess (0.5);
}


/*  Draw a cone of a given radius, height, and number of sides
 *  The base is on the y=0 plane, and it extends vertically in the y direction.
 *
 *
 *******************************************************/
void cone (float radius, float height, int sides) {
  int i,ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = TWO_PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }
  // bottom end cap
  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, 0.0, 0.0);
    endShape();
  }
  // main body of cone
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    normal (c[i], 0.0, s[i]);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, -height, 0.0);
    endShape(CLOSE);
  }
}


/*  Draw a cylinder of a given radius, height, and number of sides
 *  The base is on the y=0 plane, and it extends vertically in the y direction.
 *
 *
 *******************************************************/
void cylinder (float radius, float height, int sides) {
  int i,ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = TWO_PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }
  // bottom end cap
  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, 0.0, 0.0);
    endShape();
  }
  // top end cap
  normal (0.0, 1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    vertex (0.0, height, 0.0);
    endShape();
  }
  // main body of cylinder
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape();
    normal (c[i], 0.0, s[i]);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    normal (c[ii], 0.0, s[ii]);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    endShape(CLOSE);
  }
}


/*  Called to setup the light in a scene
 *  ambientLight() to create ambient light source
 *  lightSpecular() to set specular light color
 *  directionalLight() to create directional beams of light
 *******************************************************/
void setLight()
{
  // create an ambient light source
  ambientLight (102, 102, 102);

  // create two directional light sources
  lightSpecular (204, 204, 204);
  //directionalLight (255, 255, 255, -0.7, -0.7, -1);
  directionalLight (255, 255, 255, -1, 2, -1);
  directionalLight (abs(255*sin(time)), 0, abs(255*cos(time)), 1, -2, 1);
}


/*  Called to set up the camera
 *  calls perspective to enable perspective projection
 *  calls camera to place the camera in the scene based on time
 *
 *******************************************************/
void setCamera()
{
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);
  camera (150 * cos(time/12) + (mouseX-(width/2))/50,
          -50 + 20*sin(time) + (mouseY-(height/2))/50,
          150 * sin(time/12),
          0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
};


/*  Called to kick off the draw method
 *  calls resetMatrix to set the transformation matrix to the identity
 *  calls background to reset the background color
 *
 *******************************************************/
void resetDraw()
{
  resetMatrix();
  background(abs(25*cos(time)), 10, abs(20*sin(time)));
}


/*  Called to set up draw method
 *  calls resetDraw to handle some bureaucracy
 *  calls setCamera to set the camera position and settings
 *  calls setLight to set light attributes
 *******************************************************/
void drawSetup()
{
  resetDraw();
  setCamera();
  setLight();
}
