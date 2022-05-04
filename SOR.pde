/* USER PARAMETERS*/
char ROTAXIS = 'y';           //OPTIONS: x OR y
final float END_PLANE = 10; //RAIDUS OF COORD PLANE
final float DELTA_R = 0.02;    //REVOLN PRECISION (HIGHER = WORSE)
final float FR = 60;          //FRAME RATE

/* GENERAL GLOBAL VARS */
float inc = 0;
float inc2 = 0;
final int PADDING = 0;
boolean isPaused = false;
float pauseVal = 0;
ArrayList <PShape> shapes = new ArrayList <PShape>();

/** FUNCTION TO GRAPH
   @param x input val
*/
float f(float x) {
  float y = sin(x);
  return -1 * map(y,0,END_PLANE,0,height/2);
} //f

void setup() {
  colorMode(HSB);
  strokeWeight(2);
  fullScreen(P3D); 
  frameRate(FR);
  translate(width/2,height/2); 
  background(0);
  stroke(255);
} //setup

void draw() {
  camera(map(mouseX,0,width,-width ,width), map(mouseY,0,height,-height/2 - PADDING ,height/2 + PADDING), 
  (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 1); //user-defined mouse control
  translate(width/2,height/2); 
  background(0); //refresh background
  inc += 0.010; 

  //AXIS ANIMATION
  pushMatrix();
  keyPressed();
  if(!mousePressed) //stop axis rotation on mouseDown
    if (ROTAXIS == 'x') rotateX(inc);
    else rotateY(inc);
  //plotAxes();
  popMatrix();
  
  //FACE REVOLUTION
  pushMatrix();
  plotFunc(inc2);
  if (inc2 < TWO_PI) inc2 += DELTA_R;
  popMatrix();
  
  //FACE DRAWING
  for (PShape p : shapes) 
    shape(p);
} //draw;

PShape plotFunc(float rot) {
  PVector end = new PVector(END_PLANE,END_PLANE);
  
  PShape s = createShape();
  //s.setFill(color(255,80,80,100));
  s.beginShape();
  s.noFill();
  s.strokeWeight(1);
  //s.stroke(map(rot,0,TWO_PI,0,255),109,109,255);
  s.strokeWeight(2);
  //ADD VERTICES ALONG FUNCTION
  for (float i = .001; i < END_PLANE; i+=0.01) {
    if (f(i) >= -height/2+PADDING && f(i) <= 0) {
      s.stroke(map(i,0.001,END_PLANE,0,255),map(i,0.001,END_PLANE,255,100),map(i,0.001,END_PLANE,255,100));
      s.vertex(map(i,0,END_PLANE,0,width/2 - PADDING),f(i),0);
      end.set(map(i,0,END_PLANE,0,width/2 - PADDING),f(i));
    } //if
  } //for
  
  //CLOSE SHAPE ON AXES
  if (ROTAXIS == 'x') {
    s.vertex(end.x,0,0);
    s.vertex(0,0,0);
  } else {
    s.vertex(0,end.y,0);
    s.vertex(0,f(0),0);
  } //if
  s.endShape(CLOSE);
  
  //ROTATE FACE
  if (ROTAXIS == 'x') s.rotateX(rot);
  else s.rotateY(rot);
  
  shapes.add(s);
  return s;
} //plotFunc

void plotAxes() {
  strokeWeight(2);
  stroke(255,0,0); //X = R
  line(-END_PLANE - PADDING,0,0,END_PLANE + PADDING,0,0);
  stroke(0,255,0); //Y = B
  line(0,-END_PLANE - PADDING,0,0,END_PLANE + PADDING,0);
  stroke(0,0,255); //Z = G
  line(0,0,-END_PLANE - PADDING,0,0,END_PLANE + PADDING);
  strokeWeight(1);
} //plotA


void keyReleased() {
   //REFRESH ANIM
   if (key == 'r') { 
     shapes =  new ArrayList <PShape>();
     inc2 = 0;
     isPaused = false;
   //PAUSE ANIM
   } else if (key == 'p') {
      if (isPaused) {isPaused = false; inc2 = pauseVal;}
      else {isPaused = true; pauseVal = inc2;inc2 = 100000;}
   } //if
} //keyReleased
