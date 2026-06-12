//Code based on oggy's "Ripple" (https://openprocessing.org/@oggy/555063)
//Adapted for MDM - Generative Design, 2026

int canvasWidth = 350;
int canvasHeight = 24;
float scaling = 10;
int pw = 52;
int ph = 5;
int step = 8;
Particle[][] parts = new Particle[pw][ph];

PGraphics canvas; // https://processing.org/reference/PGraphics.html
Tx tx;

void settings() {
  // Find the larger scaling that fits your screen
  while (canvasWidth * scaling > displayWidth) scaling--;
  size(int(canvasWidth * scaling), int(canvasHeight * scaling));
  pixelDensity(1); // Do not remove this line
  noSmooth(); // Do not remove this line
}

void setup() {
  frameRate(30);
  canvas = createGraphics(canvasWidth, canvasHeight);
  tx = new Tx(canvasWidth, canvasHeight);

  println("default color set: river blue");

  s = s1;
  t = t1;
  m = m1;

  cC = cC1;
  eC = eC1;

  top = a;

  accent = accent1;


  // Center the grid in the canvas
  int offsetX = (canvasWidth - (pw * step)) / 2;
  int offsetY = (canvasHeight - (ph * step)) / 2;

  for (int i = 0; i < pw; i++) {
    for (int j = 0; j < ph; j++) {
      parts[i][j] = new Particle(i * step + offsetX, j * step + offsetY);
    }
  }
}

void draw() {
  canvas.beginDraw();
  canvas.background(211, 255, 244);

  // Get mouse position relative to canvas
  PVector m = new PVector(mouseX / scaling, mouseY / scaling);

  //radial gradient circle
  float radius = 250;
  color centerColor = cC;
  color edgeColor = eC;

  //radial gradient circle as bg
  canvas.loadPixels();
  for (int x = 0; x < canvasWidth; x++) {
    for (int y = 0; y < canvasHeight; y++) {
      float distance = dist(x, y, m.x, m.y);

      if (distance < radius) {
        float t = map(distance, 0, radius, 0, 1);
        int r = (int) lerp(red(centerColor), red(edgeColor), t);
        int g = (int) lerp(green(centerColor), green(edgeColor), t);
        int b = (int) lerp(blue(centerColor), blue(edgeColor), t);
        canvas.pixels[y * canvasWidth + x] = color(r, g, b);
      } else {
        canvas.pixels[y * canvasWidth + x] = edgeColor;
      }
    }
  }
  canvas.updatePixels();

  // Update and draw all particles
  for (int i = 0; i < pw; i++) {
    for (int j = 0; j < ph; j++) {
      parts[i][j].update(m);
      parts[i][j].display(canvas);
    }
  }

  canvas.noStroke();
  canvas.fill(accent);
  canvas.rectMode(CENTER);
  canvas.rect(m.x, m.y, 10, 10);

  if (keyPressed == true) {
    if (key == 'r' || key == 'R') {
      generateFish();
    }
  }

  canvas.endDraw();

  // Draw canvas on window
  image(canvas, 0, 0, width, height);
  filter(BLUR, 3);
  // Send canvas to server
  tx.send(canvas);
}
