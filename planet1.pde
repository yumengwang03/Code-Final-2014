//class Planet1 serves for the planets floating in the universe


class Planet1 {
  PVector position;
  float size;
  float yRotation;
  PVector orbitPos;
  float xTurn;
  float yTurn;

  Planet1 (float _size, float xPos, float yPos, float zPos, float _yRotation) {
    position = new PVector(0, 0, 0);
    position.x = xPos;
    position.y = yPos;
    position.z = zPos;
    size = _size;
    yRotation = _yRotation;
    orbitPos = new PVector(0, 0, 0);
    xTurn = 0;
    yTurn = 0;
  }

  void rotating() {
    pushMatrix();
    noStroke();
    fill(140);
    lights();
    translate(position.x + xTurn, position.y + yTurn, position.z);
    rotateY(yRotation);
    yRotation += .03;
    sphere(size);
    popMatrix();
  }

  void orbiting() {
    pushMatrix();
    beginCamera();
    camera(mouseX/2, 30, 220, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0);
    fill(240);
    lights();
    translate(orbitPos.x, orbitPos.y, orbitPos.z);
    sphere(5);
    endCamera();
    popMatrix();
  }
}

