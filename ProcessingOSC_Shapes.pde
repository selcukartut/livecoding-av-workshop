import oscP5.*;
import netP5.*;

OscP5 oscP5;

float rSphere = 0;
float kickAmp;
float hihatPan;
float xCube;

void setup() {
  size(400, 400, P3D);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 8000);
  stroke(255);
  sphereDetail(8);
}

void draw() {
  background(0);
  pushMatrix();
  translate(width*0.5,height*0.5);
  noFill();
  rSphere = lerp(rSphere, 50,0.05);
  sphere(rSphere);
  translate(xCube,0);
  box(40);
  popMatrix();
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  if(theOscMessage.checkAddrPattern("/kick")==true) {
    kickAmp = theOscMessage.get(0).floatValue();
    rSphere = 100 * kickAmp;
  }
  
  if(theOscMessage.checkAddrPattern("/hihat")==true) {
    hihatPan = theOscMessage.get(0).floatValue();
    xCube = width * 0.5 * hihatPan;
  }
  
}
