float inc = 0;
float inc2 = 0;
float v = 0;
boolean isPaused = false;
float pauseVal = 0;

char ROTAXIS = 'y';
final int PADDING = 300;
final float END_PLANE = 4*PI;
//y=x.y=x^2,y=x^2/3+5.sing(x)
ArrayList <PShape> shapes = new ArrayList <PShape>();

float f(float x) {
  float y = x * sin(x);
  return -1 * map(y,0,END_PLANE,0,height/2);
} //f

void setup() {
  fullScreen(P3D);
  translate(width/2,height/2);
  background(0);
  stroke(255);
  
} //setup

void draw() {
  camera(map(mouseX,0,width,-width ,width), map(mouseY,0,height,-height/2 - PADDING ,height/2 + PADDING), (height/2.0) / tan(PI*30.0 / 180.0), 
  width/2.0, height/2.0, 0, 0, 1, 1);
  translate(width/2,height/2);
  inc += 0.010;
  
  pushMatrix();
  background(0);
  keyPressed();
  //if(!mousePressed)rotateY(inc);
  if (ROTAXIS == 'x') rotateX(inc);
  else rotateY(inc);
  plotAxes();
  popMatrix();
  
  pushMatrix();
  plotFunc(inc2);
  if (inc2 < TWO_PI) inc2+=0.1;
  popMatrix();
  
  for (PShape p : shapes) 
    shape(p);
} //draw;

PShape plotFunc(float rot) {
  PVector end = new PVector(END_PLANE,END_PLANE);
  
  PShape s = createShape();
  //s.setFill(color(255,255,0,100));
  s.beginShape();
  //s.noStroke();
  s.noFill();
  s.strokeWeight(1);
  s.stroke(255,109,109,255);

  for (float i = .001; i < END_PLANE; i+=0.01) {
    if (f(i) >= -height/2+PADDING && f(i) <= 0) {
      s.vertex(map(i,0,END_PLANE,0,width/2 - PADDING),f(i),0);
      end.set(map(i,0,END_PLANE,0,width/2 - PADDING),f(i));
      v += f(i) * 0.001;
    } //if
  } //for
  
  if (ROTAXIS == 'x') {
    s.vertex(end.x,0,0);
    s.vertex(0,0,0);
  } else {
    s.vertex(0,end.y,0);
    s.vertex(0,f(0),0);
  } //if
  
  s.endShape(CLOSE);
  if (ROTAXIS == 'x') s.rotateX(rot);
  else s.rotateY(rot);
  shapes.add(s);
  return s;
} //plotFunc

void plotAxes() {
  strokeWeight(2);
  stroke(255,0,0);
  line(-END_PLANE - PADDING,0,0,END_PLANE + PADDING,0,0);
  stroke(0,255,0);
  line(0,-END_PLANE - PADDING,0,0,END_PLANE + PADDING,0);
  stroke(0,0,255);
  line(0,0,-END_PLANE - PADDING,0,0,END_PLANE + PADDING);
  strokeWeight(1);
} //plotA

void mousePressed() {
  shapes =  new ArrayList <PShape>();
  inc2 = 0;
}

void keyReleased() {
   if (key == 'r') { 
     shapes =  new ArrayList <PShape>();
     inc2 = 0;
     isPaused = false;
   } else if (key == 'p') {
      if (isPaused) {isPaused = false; inc2 = pauseVal;}
      else {isPaused = true; pauseVal = inc2;inc2 = 100000;}
   }
}
