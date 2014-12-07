// class Fire serves for the gun fire in the interface


class Fire {
  PVector position;
  PVector velocity;
  PVector acceleration;

  Fire(float xPos) {
    position = new PVector(0, height-100, 500);
    position.x = xPos;
    velocity = new PVector(0, 4, 80);
    acceleration = new PVector(0, -.5, -5);
  }

  void display() {
    pushMatrix();
    fill(7, 255, 15);
    lights();
    translate(position.x-25, position.y-60, position.z-400);
    box(5, 5, 120);
    popMatrix();
  }

  void movement() {
    velocity.add(acceleration);
    position.sub(velocity);
    acceleration.mult(0);
  }

  void reset() {
    if (position.z <= -500) {
      position.z = 500;
      position.y = height-100;
    }
  }
}

