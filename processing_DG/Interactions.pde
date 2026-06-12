void mousePressed() {
  mode = !mode;
}

//color choosers
color s, t, m;
color cC, eC;
color accent;

color top;
color a = color(255);
color b = color(211, 232, 255);

//first set of colors (1) RIVER BLUE
color s1 = color(101, 215, 245);
color t1 = color(61, 99, 232);
color m1 = color(101, 215, 245);


color accent1 = color(255, 98, 0);

color cC1 = color(180, 255, 244);
color eC1 = color(59, 143, 232);

//second set of colors (2) TROPICAL SEA
color s2 = color(101, 245, 228);
color t2 = color(35, 196, 208);
color m2 = color(164, 255, 244);

color accent2 = color(255, 90, 159);

color cC2 = color(180, 255, 227);
color eC2 = color(59, 192, 232);

//second set of colors (2) DEEP SEA
color s3 = color(152, 185, 255);
color t3 = color(70, 35, 208);
color m3 = color(205, 221, 255);

color accent3 = color(251, 233, 0);

color cC3 = color(180, 201, 255);
color eC3 = color(0, 5, 160);

int y;

void keyPressed() {
  //color mode switching
  if (key == '1') {
    println("color set: river blue");
    s = s1;
    t = t1;
    m = m1;
    cC = cC1;
    eC = eC1;
    top = a;
    accent = accent1;
  }
  if (key == '2') {
    println("color set: tropical sea");
    s = s2;
    t = t2;
    m = m2;
    cC = cC2;
    eC = eC2;
    top = a;
    accent = accent2;
  }
  if (key == '3') {
    println("color set: deep sea");
    s = s3;
    t = t3;
    m = m3;
    cC = cC3;
    eC = eC3;
    top = b;
    accent = accent3;
  }
}

void generateFish() {
  println("uwu");
  //generate y level (var5)
  y = int(random(canvas.height + 10, canvas.height - 10));

  //fiih class
  Fish fish = new Fish(canvas.width/2, y);
  fish.define();
  fish.create();
  fish.move();
  fish.logVars();
}
