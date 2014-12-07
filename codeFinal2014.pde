//Yumeng Wang's final project for Code
//Spaceship Eyeball - Interface
//Spaceship Eyeball was an antique spaceship that time travelled from the 1970s to the present on a mission to save a cat called Black Bean from Hefei, China. 
//This cat was a trigger of a butterfly effect event that happened in 1973 when time went backwards.
//The captain of the ship - Miss Yumeng, would not exist if she fails this mission. 
//Miss Yumeng also built the cockpit of this ship with the help of

/*
 * The class Space from the GitHub group project NeonCha, by Gentry Demchak
 * 3D Space Shooting Game http://www.openprocessing.org/sketch/21754, by n_ryota
 * Examples from the library ControlP5
 * Nature of Code, by Daniel Shiffman
 * processing.org camera functions and this example of perspective: https://www.processing.org/examples/perspective.html
 * The last but not the least, Anthony Marefat
 */
 
//2014

import controlP5.*;

ControlP5 boostControl;
ControlP5 slowControl;
ControlP5 fireControl;
ControlP5 fireControlR;
ControlP5 freezeControl;
ControlP5 speedControl;
ControlP5 shieldIntensity;
ControlP5 timer;
ControlTimer c;
Textlabel t;
ControlP5 attackControl;
ControlP5 attackControl2;
Knob attackKnob;
Knob attackKnob2;
ControlP5 leftTurn;
ControlP5 rightTurn;
ControlP5 upTurn;
ControlP5 downTurn;


float speedValue;
float shieldValue;
float knobValue;
float attackValue;
float attackValue2;

boolean boost = false;
boolean slow = false;
boolean beginFire = false;
boolean beginFireR = false;

Galaxy [] galaxy = new Galaxy[200];
Fire [] fire = new Fire [8];
Fire [] fireR = new Fire [8];
Planet1 [] planet1 = new Planet1[4];
Attack [] attack = new Attack[14];

PImage leftGun;
PImage rightGun;

void setup() {
  size(1200, 600, P3D);
  smooth();

  speedValue = 2;
  shieldValue = 0;
  attackValue = 5;

  boostControl = new ControlP5(this);
  slowControl = new ControlP5(this);
  fireControl = new ControlP5(this);
  fireControlR = new ControlP5(this);
  freezeControl = new ControlP5(this);
  speedControl = new ControlP5(this);
  shieldIntensity = new ControlP5(this);
  timer = new ControlP5(this);
  c = new ControlTimer();
  t = new Textlabel(timer, "--", 200, 200);
  c.setSpeedOfTime(1);
  attackControl = new ControlP5(this);
  attackControl2 = new ControlP5(this);
  leftTurn = new ControlP5(this);
  rightTurn = new ControlP5(this);
  upTurn = new ControlP5(this);
  downTurn = new ControlP5(this);

  //create the boostControl
  boostControl.addToggle("boost")
    .setPosition(140, 490)
      .setSize(40, 40)
        .setColorBackground(color(110, 125, 255))
          .setColorForeground(color(155, 240, 255))
            .setColorActive(color(150, 255, 150))
              .setCaptionLabel("Accelerate")
                ;

  //create the left fireControl
  fireControl.addToggle("beginFire")
    .setPosition(940, 520)
      .setSize(60, 50)
        .setColorBackground(color(110, 125, 255))
          .setColorForeground(color(155, 240, 255))
            .setColorActive(color(150, 255, 150))            
              .setCaptionLabel("Left Fire")
                ;

  //create the right fireControl
  fireControlR.addToggle("beginFireR")
    .setPosition(1040, 520)
      .setSize(60, 50)
        .setColorBackground(color(110, 125, 255))
          .setColorForeground(color(155, 240, 255))
            .setColorActive(color(150, 255, 150))
              .setCaptionLabel("Right Fire")
                ;

  //create the freezeControl
  freezeControl.addButton("freezeTime")
    .setPosition(970, 440)
      .setSize(40, 20)
        .setColorBackground(color(110, 125, 255))
          .setColorForeground(color(155, 240, 255))
            .setColorActive(color(150, 255, 150))  
              .setCaptionLabel("Freeze")
                ;

  //create the leftTurn
  leftTurn.addButton("left")
    .setPosition(10, 375)
      .setSize(40, 40)
        .setColorBackground(color(110, 125, 255))
          .setColorForeground(color(155, 240, 255))
            .setColorActive(color(150, 255, 150))
              .setCaptionLabel("Left")
                ;

  //create the rightTurn
  rightTurn.addButton("right")
    .setPosition(110, 375)
      .setSize(40, 40)
        .setColorBackground(color(110, 125, 255))
          .setColorForeground(color(155, 240, 255))
            .setColorActive(color(150, 255, 150))
              .setCaptionLabel("Right")
                ;

  //create the upTurn
  upTurn.addButton("up")
    .setPosition(60, 330)
      .setSize(40, 40)
        .setColorBackground(color(110, 125, 255))
          .setColorForeground(color(155, 240, 255))
            .setColorActive(color(150, 255, 150))
              .setCaptionLabel("Up")
                ;

  //create the downTurn
  downTurn.addButton("down")
    .setPosition(60, 420)
      .setSize(40, 40)
        .setColorBackground(color(110, 125, 255))
          .setColorForeground(color(155, 240, 255))
            .setColorActive(color(150, 255, 150))
              .setCaptionLabel("Down")
                ;

  //create the speedControl slider
  speedControl.addSlider("speedValue")
    .setPosition(30, 550)
      .setSize(160, 20)
        .setRange(1, 40)
          .setCaptionLabel("Speed")
            .setColorBackground(color(110, 125, 255))
              .setColorActive(color(155, 240, 255))
                ;

  //create the shieldIntensity slider
  shieldIntensity.addSlider("shieldValue")
    .setPosition(960, 490)
      .setSize(120, 20)
        .setRange(0, 200)
          . setCaptionLabel("Shield")
            .setColorBackground(color(110, 125, 255))
              .setColorActive(color(155, 240, 255))
                ;

  //create the attackControl for width
  attackKnob=attackControl.addKnob("knob")
    .setRange(0, 100)
      .setValue(0)
        .setPosition(1020, 280)
          .setRadius(40)
            .setDragDirection(Knob.HORIZONTAL)
              .setColorBackground(color(110, 125, 255))
                .setColorActive(color(155, 240, 255))
                  .setCaptionLabel("Laser Shield Width")
                    ;

  //create the attackControl for height
  attackKnob2=attackControl2.addKnob("knob2")
    .setRange(0, height)
      .setValue(0)
        .setPosition(1020, 380)
          .setRadius(40)
            .setDragDirection(Knob.HORIZONTAL)
              .setColorBackground(color(110, 125, 255))
                .setColorActive(color(155, 240, 255))
                  .setCaptionLabel("Laser Shield Height")
                    ;

  //galaxy array
  for (int i = 0; i < galaxy.length; i++) {
    galaxy[i] = new Galaxy(random(1, 3), random(0, 1.5*width), random(0, 1.5*height), random(0, 500));
  }

  //fire array
  for (int i = 0; i < fire.length; i++) {
    fire[i] = new Fire(width/2-100);
  }
  for (int i = 0; i < fireR.length; i++) {
    fireR[i] = new Fire(width/2+100);
  }

  //planet1 array
  for (int i = 0; i < planet1.length; i++) {
    planet1[i] = new Planet1(random(10, 30), random(0, width), random(0, height), random(-400, 0), random(0.01, 0.05));
  }

  //attack array
  for (int i=0; i< attack.length; i++) {
    attack[i] = new Attack();
  }


  leftGun = loadImage("leftGun.png");
  rightGun = loadImage("rightGun.png");
}



void draw() {
  background(0); 
  attackFunction();
  movingGalaxy();
  rotatingPlanet1();
  displayImage();
  displayGraphic();
  displayText();
  drawShield();

  //draw the timer
  t.setValue(c.toString());
  t.draw(this);
  t.setPosition(15, 260);

  //begin left fire when the toggle is pressed
  if (beginFire == true) {
    for (int i = 0; i < fire.length; i++) {
      fire[i].display();
      fire[i].movement();
      fire[i].reset();
    }
  } 

  //begin right fire when the toggle is pressed
  if (beginFireR == true) {
    for (int i = 0; i < fireR.length; i++) {
      fireR[i].display();
      fireR[i].movement();
      fireR[i].reset();
    }
  } 

  //accelerate the spaceship with a constant speed when the acceleration toggle is pressed
  if (boost == true) {
    for (int i = 0; i < galaxy.length; i++) {
      galaxy[i].boost();
    }
  }
}

  //Move the galaxy array
void movingGalaxy() {
  for (int i = 0; i < galaxy.length; i++) {
    galaxy[i].display();
    galaxy[i].velocity.z = speedValue;  //the z velocity changes according to the value on the slider
    galaxy[i].movement();
    galaxy[i].reset();
  }
}

  //the laser attack function
void attackFunction() {
  for (int i = 0; i < attack.length; i++) {
    attack[i].intensity = attackValue;  //the width and height of the laser beams
    attack[i].intensityH = attackValue2;
    attack[i].position.x = i*100;
    attack[i].display();
  }
}

  //used the camera function for turnin the spaceship but did not turn out well 
/*
void cameraControl() {
 camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
 //camera(mouseX, mouseY, 500, width/2, height/2, 0.0, 0.2, 0.2, 0.0);
 }
 */

  //rotate the planet1 array
void rotatingPlanet1() {
  for (int i = 0; i< planet1.length; i++) {
    planet1[i].rotating();
  }
}

  //for time freezing bang
void freezeTime() {
  delay(3000);
}

  //turning the spaceship to left, right, up and down
void left() {
  for (int i = 0; i < galaxy.length; i++) {
    galaxy[i].xTurn += 4;
  }
}

void right() {
  for (int i = 0; i < galaxy.length; i++) {
    galaxy[i].xTurn -= 4;
  }
}

void up() {
  for (int i = 0; i < galaxy.length; i++) {
    galaxy[i].yTurn += 4;
  }
}

void down() {
  for (int i = 0; i < galaxy.length; i++) {
    galaxy[i].yTurn -= 4;
  }
}

//set the value for the knobs
void knob(int theValue) {
  attackValue = theValue;
}

void knob2(int theValue) {
  attackValue2 = theValue;
}

//display all the images
void displayImage () {
  image(rightGun, width/2+100, height-85);
  image(leftGun, width/2-260, height-85);
}

//display the control board graphics
void displayGraphic () {
  noStroke();
  fill(255);
  noStroke();
  triangle(0, 0, 0, height, 250, height);

  pushMatrix();
  translate(-70, 0);
  fill(255);
  triangle(width, 0, width, height, width-250, height);
  noStroke();
  triangle(width, 0, width, height, width-250, height);
  popMatrix();
  
  rect(width-68, 0, 68, height);
  fill(0);
  rect(10, 255, 65, 20);
}

//display all the text
void displayText () {
  fill(255);
  text("STARSHIP", width-65, 20);
  text("EYEBALL", width-65, 40);
  text("CAPTAIN", width-65, 100);
  text("WANG", width-65, 120);
  text("DESTINATION", width-65, 180);
  text("APALAPUCIA", width-65, 200);

  text("MISSION", width-65, 260);
  text("SAVE THE", width-65, 280);
  text("CAT!", width-65, 300);
  text("2014", width-65, height-20);
}

//draw the protection shield (for shield slider)
void drawShield () {
  fill(255, shieldValue);
  rect(0, 0, width, height);
}

