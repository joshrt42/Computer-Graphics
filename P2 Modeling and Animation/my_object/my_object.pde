// 3D Scene Example

float time = 0;  // keep track of passing of time

void setup() {
  size(800, 800, P3D);  // must use 3D here !!!
  noStroke();           // do not draw the edges of polygons
}

// Draw a scene with a cylinder, a sphere and a box
void draw() {
  drawSetup();
  //********************ACTUAL DRAWING BEGIN
  
  pushMatrix();
    materialFunky();
    translate(0.0, 23.0, 0.0);
    scale(200.0, 0.01, 200.0);
    box(1);
  popMatrix();
  pushMatrix();
  popMatrix();
  pushMatrix();
    translate(40*cos(time/2), 0.0, 40*sin(time/2));
    rotate(-time/2,0.0,1.0,0.0);
    drawPorygon();
  popMatrix();
  pushMatrix();
    translate(-40*cos(time/2), 0.0, -40*sin(time/2));
    rotate(PI-time/2,0.0,1.0,0.0);
    if(time%(4*PI)<PI) {
      translate(0.0,-20*sin(time),0.0);
    }
    drawPorygon();
  popMatrix();
  if(time%(4*PI)<PI) {
    pushMatrix();
    translate(-30.0, 10.0, -30.0);
    materialBlack();
    sphere(5.1);
      pushMatrix();
        materialRed();
        translate(cos(time*8),sin(time*8), 0.0);
        sphere(5);
      popMatrix();
      pushMatrix();
        materialWhite();
        translate(-cos(time*8),-sin(time*8), 0.0);
        sphere(5);
      popMatrix();
    popMatrix();
  }
  
  //********************ACTUAL DRAWING END
  
  time += 0.03;
}
