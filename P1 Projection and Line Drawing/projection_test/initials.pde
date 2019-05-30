/******************************************************************************
Draw your initials here in perspective.
******************************************************************************/

void persp_initials()
{
  gtInitialize();
  gtPerspective(60.0, 1.0, 100.0);
  gtTranslate(0.0,0.0,-150.0);

  gtPushMatrix();
  gtRotateX(-55 + 40*mouseY/height);
  gtRotateY(-15 + 30*mouseX/width);
  
  gtBeginShape();
  
  gtVertex (-50.0, 50.0, 5.0);
  gtVertex (0.0,  50.0, 5.0);

  gtVertex (-25.0, 50.0, 5.0);
  gtVertex ( -25.0, -25.0, 5.0);

  gtVertex (-25.0, -25.0, 5.0);
  gtVertex (-50.0, 0.0, 5.0);

  gtVertex (0.0, 25.0, 5.0);
  gtVertex (50.0, 25.0, 5.0);

  gtVertex (25.0, 25.0, 5.0);
  gtVertex (25.0, -50.0, 5.0);

  gtEndShape();
  gtPopMatrix();
}
