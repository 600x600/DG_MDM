class Fish {
  float x, y;
  int size;
  float speed;
  PShape b, f, t;
  color c1, c2, c3;
  PShape full_fish;
  float totalFishWidth;

  Fish(PShape body, PShape fins, PShape tail, color color1, color color2, color color3, float chosen_speed, float yPos) {
    b = body;
    f = fins;
    t = tail;

    c1 = color1;
    c2 = color2;
    c3 = color3;

    speed = chosen_speed;
    y = yPos;
  }

  void loadAndCHoose() {
    t.disableStyle();
    b.disableStyle();
    f.disableStyle();

    t.fill(c1);
    b.fill(c2);
    f.fill(c3);

    full_fish = createShape(GROUP);

    //tail at 0,0 position
    full_fish.addChild(t);

    //to safely move stuff without breaking it:
    b.resetMatrix();
    b.translate(t.width, 0);

    //adding the body
    full_fish.addChild(b);

    //to safely move stuff without breaking it:
    f.resetMatrix();
    f.translate(t.width + t.width/2, -t.width/4);

    full_fish.addChild(f);

    totalFishWidth = t.width + b.width;
    x = -(totalFishWidth * 0.2);
  }

  void swim() {
    x += speed;
  }

  boolean isOffScreen(int maxCanvasWidth) {
    return x > maxCanvasWidth;
  }

  void display(PGraphics c) {
    c.pushMatrix();

    //move to canvas x, y
    c.translate(x, y);

    //control size with scale()
    c.scale(0.1);
    c.noStroke();

    c.fill(c1);
    c.shape(full_fish.getChild(0), 0, 0); //tail = color c1

    c.fill(c2);
    c.shape(full_fish.getChild(1), 0, 0); //body = color c2

    c.fill(c3);
    c.shape(full_fish.getChild(2), 0, 0); //fins = color c3

    c.popMatrix();
  }

  void exportToSVG(String filename) {
    //How it should be in VSCode:
    //String outputPath = "../web_DG/shapes/" + filename + ".svg";
    
    String outputPath = "../web_DG/shapes/" + filename + ".svg";

    int svgWidth = ceil((t.width + b.width) * 1.5);
    int svgHeight = ceil(b.height * 2);

    if (svgWidth <= 0) svgWidth = 500;
    if (svgHeight <= 0) svgHeight = 300;

    PGraphics svg = createGraphics(svgWidth, svgHeight, SVG, outputPath);

    svg.beginDraw();
    svg.pushMatrix();

    svg.translate(totalFishWidth * 0.1, svgHeight / 2);
    svg.noStroke();

    svg.fill(c1);
    svg.shape(full_fish.getChild(0), 0, 0); // tail

    svg.fill(c2);
    svg.shape(full_fish.getChild(1), 0, 0); // body

    svg.fill(c3);
    svg.shape(full_fish.getChild(2), 0, 0); // fins

    svg.popMatrix();
    svg.endDraw();
    svg.dispose(); // Crucial to finalize and save the file cleanly

    //println("Saved fish SVG to: " + outputPath);
  }
}
