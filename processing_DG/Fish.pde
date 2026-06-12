int var1, var2, var3, var4, var5, var7;
PVector var6;

class Fish {
  PVector pos, speed, origin;

  Fish(int x, int y) {
    pos = new PVector(x, y);
    origin = pos.copy();
    speed = new PVector(0, 0);
    var5 = y;
  }

  void define() {
    var1 = int(random(20, 100));
    var2 = int(random(var1/4, var1/2));
    var3 = int(random(var1/3, var1 - var1/5));
    var4 = int(random(var1/5, var3));
    float spd = random(3, 7);
    var6 = new PVector(spd, 0);
    speed = var6;
  }

  void create() {
    PShape fish = createShape();
    fish.beginShape();
    fish.noStroke();
    fish.fill(accent);
    fish.vertex(0, 0);
    fish.vertex(var4, var2);
    fish.vertex(var3, var2);
    fish.vertex(var1, var2/2);
    fish.vertex(var3, 0);
    fish.vertex(var4, 0);
    fish.vertex(0, var2);
    fish.endShape();
  }

  void move() {
    pos.x += var6.x;
  }

  void logVars() {
    println(var1);
    println(var2);
    println(var3);
    println(var4);
    println(var5);
    println(var6);
    println(var7);
  }
}
