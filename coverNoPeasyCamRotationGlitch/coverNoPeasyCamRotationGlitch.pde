// todo
// roter 2D icon i 3D space? så de ikke aligner med grid, mere 2,5D vibe
// fade fra billede / generer billede
// leg mere med perspektiv

import processing.pdf.*;
import controlP5.*;

ControlP5 cp5;

PImage title, icon;

int offSetX = 500, offSetY = 500, offSetZ = 50;
int compX = 50, compY = 7, compZ = 2;
int entropy1 = 30, entropy2 = 3, entropy3 = 2;
float rotationX = 0, rotationY = 0, rotationZ = 0;
float scaling = 0.29;
float ran1 = random(1, 100), ran2 = random(1, 10), ran3 = random(1, 10);
boolean exporting = false, hideGUI = false;

float camX, camY, camZ, lookX, lookY, lookZ;
boolean lookat = false;

void setup() {

  size(440, 720, P3D);

  cp5 = new ControlP5(this);
  cp5.addSlider("offSetX").setRange(-5000, 5000).setSize(200, 9).setPosition(10, 10);
  cp5.addSlider("offSetY").setRange(-5000, 5000).setSize(200, 9).setPosition(10, 20);
  cp5.addSlider("offSetZ").setRange(-5000, 5000).setSize(200, 9).setPosition(10, 30);
  cp5.addSlider("compX").setRange(1, 200).setSize(200, 9).setPosition(10, 40);
  cp5.addSlider("compY").setRange(1, 200).setSize(200, 9).setPosition(10, 50);
  cp5.addSlider("compZ").setRange(1, 200).setSize(200, 9).setPosition(10, 60);
  cp5.addSlider("rotationX").setRange(-180, 180).setSize(200, 9).setPosition(10, 70);
  cp5.addSlider("rotationY").setRange(-180, 180).setSize(200, 9).setPosition(10, 80);
  cp5.addSlider("rotationZ").setRange(-181, 180).setSize(200, 9).setPosition(10, 90);
  cp5.addSlider("scaling").setRange(0, 5).setSize(200, 9).setPosition(10, 100);
  cp5.setAutoDraw(false);

  title = loadImage("title.png");
  icon = loadImage("notebook.png");
  camX = width/2;
  camY = width/2;
  camZ = 800;

  lookX = camX;
  lookY = camY;
  lookZ = 0;
}

void draw() {
  background(200);

  pushMatrix();

  camera(camX, camY, camZ, lookX, lookY, lookZ, 0.0, 1.0, 0.0);
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  drawNoteBooks();

  popMatrix();

  titleAndGui();
}

void drawNoteBooks() {
  pushMatrix();
  //translate(width/2, height/2);
  for (int k = 0; k<compX; k++) {
    translate(offSetX, 0, 0);
    if (true) {
      pushMatrix();
      for (int j = 0; j<compY; j++) {
        translate(0, offSetY, 0);
        if (true) {
          pushMatrix();
          for (int i = 0; i<compZ; i++) {
            translate(0, 0, -offSetZ);
            if (true) {
              rotateX(radians(rotationX));
              rotateY(radians(rotationY));
              rotateZ(radians(rotationZ));
              image(icon, 0, 0, icon.width*scaling, icon.height*scaling);
            }
          }
          popMatrix();
        }
      }
      popMatrix();
    }
  }
  popMatrix();
}

void binding() {
  //binding
  fill(#480B0B);
  noStroke();
  rect(0, 0, 50, height);
  stroke(#2C0606);
  rect(35, 0, 5, height);
}

void title() {
  imageMode(CORNER);
  image(title, 104, 195, 212, 78);
}

void mouseClicked() {
  println(mouseX+","+mouseY);
}

void keyPressed() {
  if (key == 'e') {
    saveFrame("cover####.png");
  }
  if (key == 'h') {
    hideGUI = !hideGUI;
  }
  if (key == 'r') {
    ran1 = random(1, 100);
    ran2 = random(1, 10);
    ran3 = random(1, 10);
    println("new randoms: "+ran1+" "+ran2+" "+ran3);
  }
  if (key == 'l') {
    lookat = !lookat;
  }
}

void titleAndGui() {
  //hint(DISABLE_DEPTH_TEST);
  //cam.beginHUD();

  title();
  binding();
  if (!hideGUI) cp5.draw();

  //cam.endHUD();
  //hint(ENABLE_DEPTH_TEST);
}

void mouseDragged() {
  int dx = mouseX-pmouseX;
  int dy = mouseY-pmouseY;
  if (lookat) {
    lookX += dx*10;
    lookY += dy*10;
  }

  camX += dx*10;
  camY += dy*10;

  println(camX);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  //println(e);
  camZ += e;
}
