//class Galaxy serves for all the moving particles in the universe


class Galaxy {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector acceleration2;
  float maxSpeed;
  float minSpeed;
  float mass;
  float xTurn;
  float yTurn;

  Galaxy(float _mass, float xPos, float yPos, float zPos) {
    position = new PVector(0, 0, 0);
    position.x = xPos;
    position.y = yPos;
    position.z = zPos;
    velocity = new PVector(0, .5, speedValue);
    acceleration = new PVector(0, 0, 30);
    mass = _mass;
    maxSpeed = 40;
  }

  void display() {
    pushMatrix();
    fill(255);
    lights();
    noStroke();
    strokeWeight(2);
    translate(position.x+xTurn, position.y+yTurn, position.z);
    box(mass, mass, mass*2);
    popMatrix();
  }

  void movement() {
    velocity.limit(maxSpeed);
    position.add(velocity);
  }

  void reset() {
    if (position.z >= 500) {
      position.y = random(0, height);
      position.z = 0;
    }
  }

  //accelerate the particles when acceleration toggle is pressed
  void boost() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
    println("z");
    println(velocity.z);
  }
}

