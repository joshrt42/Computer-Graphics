//This is where we draw the porygon.

void drawPorygon()
{
  pushMatrix();
    /*body*/
    materialRed();
    pushMatrix();
      scale(0.8,0.8,0.8);
      translate(0.0, 12.5+ sin(8*time)/2, -12.5);
      scale(1.0, 0.6, 1.0);
      rotate(PI/2, 1.0, 0.0, 0.0);
      cylinder(15.0, 25.0, 6);          //red body
        pushMatrix();
          translate(0.0, 12.5, 12.5);
          scale(0.8,0.95,1.0);
          rotate(-PI/4.0, 1.0, 0.0, 0.0);
          box(18);                        //red neck
            pushMatrix();
              materialBlue();
              translate(0.0,1.0,2.0);
              box(17);                      //blue neck
            popMatrix();
          popMatrix();
          pushMatrix();
            translate(0.0, 25.0, 0.0);
            cylinder(15.0, 1.0, 6);         //blue body
          popMatrix();
        popMatrix();
    
    /*legs*/
    pushMatrix();
      rotate(cos(4*time)/5, 1.0, 0.0, 0.0);
      translate(-3.0, 18.0, 0.0);
      scale(1.0, 0.6, 1.2);
      rotate(-PI/2, 0.0, 0.0, 1.0);
      translate(0.0, 12, 0.0);
      cylinder(10.0, 6.0, 5);          //left leg
    popMatrix();
    pushMatrix();
      rotate(-cos(4*time)/5, 1.0, 0.0, 0.0);
      translate(-3.0, 18.0, 0.0);
      scale(1.0, 0.6, 1.2);
      rotate(-PI/2, 0.0, 0.0, 1.0);
      translate(0.0, -12, 0.0);
      cylinder(10.0, 6.0, 5);          //right leg
    popMatrix();
    
    /*tail*/
    pushMatrix();
      translate(0.0, sin(8*time)/2, 0.0);
      translate(0.0, 10.0, -12.0);
      rotate(PI/4, 1.0, 0.5*cos(time/2), 0.0);
      scale(0.8, 1.0, 1.0);
      cone(4.0, 25.0, 4);              //tail
    popMatrix();
    
    /*head red*/
    materialRed();
    pushMatrix();
      rotate(sin(time)*PI/8,0.0,1.0,0.0);
      rotate(sin(time)*PI/8,0.0,0.0,1.0);
      translate(0.0, -9.0, -4.0);
      rotate(9*PI/20,1.0,0.0,0.0);
      scale(1.0, 1.0, 0.6);
      cylinder(12.0, 15.0, 6);         //head red
      pushMatrix();
        materialBlue();
        translate(0.0,15.0,0.0);
        cone(12.0,-15.0,6);            //head blue
        popMatrix();
      materialWhite();
      pushMatrix();
        translate(12.0, 7.0,0.0);
        rotate(PI/2,0.0,0.0,1.0);
        scale(1.0, 1.0, 2.0);
        cylinder(3.0, 24.0, 6);        //eye white
        pushMatrix();
          materialBlack();
          translate(0.0,-0.2,0.0);
          cylinder(0.8, 24.4, 4);      //eye black
        popMatrix();
      popMatrix();
    popMatrix();
  popMatrix();
}

void drawFloor() {
  /*floor*/
  materialWhite();
  pushMatrix();
    translate(0.0,25.0,0.0);
    scale(100.0,0.1,100.0);
    box(1);
  popMatrix();
}
