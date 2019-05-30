/*************************************************
                  DECLARATIONS
 *************************************************/
 
 /*This is some value between 0 and 2 pi,
  *derived from cursor position. Handy
  *for trig if I convert mouseX
  *every frame of the draw function.*/
 float x;
 
 /*These are the x and y locations of each
  *circle. Many of them look to higher ones
  *as parents to determine their own values.*/ 
 float aX;
 float aY;
 float bX;
 float bY;
 float cX;
 float cY;
 float dX;
 float dY;
 float eX;
 float eY;
 
 /*These are the sizes of each circle. Like
  *the x and y locations, they look to higher
  *ones as parents for their own values.*/
 float sA;
 float sB;
 float sC;
 float sD;
 float sE;
 
 
 
 /*************************************************
                     SETUP
 *************************************************/
 void setup(){
    size(800, 800);
    fill(180,255,255,50);
    noStroke();
 }
 
 /*************************************************
                      DRAW
 *************************************************/
 void draw(){
   //Convert mouseX to some value 0 <= x <= 2pi
   x = 2*PI*mouseX/width;
   //Set size of circle relative to larger circle and mouseY
   sA = 0.7*(height-mouseY);
   sB = 0.7*(sA-mouseY*sA/height);
   sC = 0.7*(sB-mouseY*sB/height);
   sD = 0.7*(sC-mouseY*sC/height);
   sE = 0.7*(sD-mouseY*sD/height);
   background(100,25,70);
   ellipse(width/2,height/2,width,height);
   for(int a = 0; a<3; a++){
     aX = (width/2) * (cos(x + a*2*PI/3 - PI/2) + 1) - sA*cos(x + a*2*PI/3 - PI/2)/2;
     aY = (height/2) * (sin(x + a*2*PI/3 - PI/2) + 1) - sA*sin(x + a*2*PI/3 - PI/2)/2;
     ellipse(aX, aY, sA, sA);
     for(int b = 0; b<3; b++) {
       bX = (aX) + (sA/2)*(cos(x + b*2*PI/3 - PI/2)) - sB*cos(x + b*2*PI/3 - PI/2)/2;
       bY = (aY) + (sA/2)*(sin(x + b*2*PI/3 - PI/2)) - sB*sin(x + b*2*PI/3 - PI/2)/2;
       ellipse(bX, bY, sB, sB);
       for(int c = 0; c<3; c++) {
         cX = (bX) + (sB/2)*(cos(x + c*2*PI/3 - PI/2)) - sC*cos(x + c*2*PI/3 - PI/2)/2;
         cY = (bY) + (sB/2)*(sin(x + c*2*PI/3 - PI/2)) - sC*sin(x + c*2*PI/3 - PI/2)/2;
         ellipse(cX, cY, sC, sC);
         for(int d = 0; d<3; d++) {
           dX = (cX) + (sC/2)*(cos(x + d*2*PI/3 - PI/2)) - sD*cos(x + d*2*PI/3 - PI/2)/2;
           dY = (cY) + (sC/2)*(sin(x + d*2*PI/3 - PI/2)) - sD*sin(x + d*2*PI/3 - PI/2)/2;
           ellipse(dX, dY, sD, sD);
           for(int e = 0; e<3; e++) {
             eX = (dX) + (sD/2)*(cos(x + e*2*PI/3 - PI/2)) - sE*cos(x + e*2*PI/3 - PI/2)/2;
             eY = (dY) + (sD/2)*(sin(x + e*2*PI/3 - PI/2)) - sE*sin(x + e*2*PI/3 - PI/2)/2;
             ellipse(eX, eY, sE, sE);
           }
         }
       }
     }
   }
 }
