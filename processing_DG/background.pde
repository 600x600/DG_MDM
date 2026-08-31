class Background {
  float movement; //the noise movement amount of the highlight circles
  color from; //chosen pallette highlight color
  color too;//chosen pallette bg color

  float x, y; //highlight circles pos
  float nX, nY;

  Background(float noiseAmount, color bgC, color hC) {
    movement = noiseAmount;
    from = bgC;
    too = hC;

    x = random(10, canvasWidth - 10);
    y = random(10, canvasHeight - 10);

    nX = random(1000);
    nY = random(1000);

    //println(x, y);
  }

  void move() {
    x = map(noise(nX), 0, 1, -20, canvasWidth + 20);
    y = map(noise(nY), 0, 1, -20, canvasHeight + 20);

    nX += movement;
    nY += movement;

    //println(nY);
  }

  void display(PGraphics canvas) {
    float size = 80; //circle diam.
    canvas.noStroke();

    canvas.blendMode(LIGHTEST);

    for (float i = size; i > 0; i -= 1) {

      float currentRadius = i / 2;
      float distanceFromCenter = size/2 - currentRadius;

      // Map the distance to a fraction between 0.0 (center) and 1.0 (edge)
      float lerpAmount = map(distanceFromCenter, 0, size/2, 0.0, 1.0);

      // Interpolate between 'from' (center) and 'too' (edge)
      color blendedColor = lerpColor(from, too, lerpAmount);

      canvas.fill(blendedColor);
      canvas.circle(x, y, i);
    }
  }
}
