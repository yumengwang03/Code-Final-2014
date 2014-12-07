//class Attack serves for the laser massive attack in the interface


class Attack {
  PVector position;
  float intensity;
  float intensityH;

  Attack () {
    position = new PVector(0, height-200, 0);
    intensity = 5;
    intensityH = 5;
  }

  void display() {
    pushMatrix();
    fill(7, 255, 15, 100);
    translate(position.x, position.y, position.z);
    box(intensity, intensityH, 690);
    popMatrix();
  }
}

