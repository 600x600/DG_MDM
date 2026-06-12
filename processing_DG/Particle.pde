final float DIST = 50;
final float DISTORTION = 10;
Boolean mode = true;

class Particle {
  PVector pos, speed, origin;

  Particle(int x, int y) {
    pos = new PVector(x, y);
    origin = pos.copy();
    speed = new PVector(0, 0);
  }

  void update(PVector m) {
    PVector tmp = origin.copy();
    tmp.sub(m);
    float d = tmp.mag();
    float c = map(d, 0, DIST, 0, PI);
    tmp.normalize();

    if (mode) {
      tmp.mult(DISTORTION * sin(c));
    }

    if (d < DIST) {
      if (!mode) {
        tmp.mult(DISTORTION * sin(c));
      }
    }

    PVector target = new PVector(origin.x + tmp.x, origin.y + tmp.y);
    tmp = pos.copy();
    tmp.sub(target);
    tmp.mult(-map(m.dist(pos), 0, 2 * canvasWidth, 0.1, 0.01));
    speed.add(tmp);
    speed.mult(0.87);
    pos.add(speed);
  }

  color c;

  void display(PGraphics pg) {
    float d = PVector.dist(pos, origin);

    // distance to mouse
    float distToMouse = PVector.dist(pos, new PVector(mouseX / scaling, mouseY / scaling));

    // color based on distance to mouse (3-step gradient)
    if (distToMouse < 30) {
      // CLOSE TO MOUSE
      c = top;
    } else if (distToMouse < 200) {
      // MEDIUM DIST
      float s_redValue = red(s);
      float s_greenValue = green(s);
      float s_blueValue = blue(s);

      /* float m_redValue = red(m);
       float m_greenValue = green(m);
       float m_blueValue = blue(m); */

      float top_redValue = red(top);
      float top_greenValue = green(top);
      float top_blueValue = blue(top);

      float t = map(distToMouse, 30, 80, 0, 1);
      int r = (int) lerp(top_redValue, s_redValue, t);
      int g = (int) lerp(top_greenValue, s_greenValue, t);
      int b = (int) lerp(top_blueValue, s_blueValue, t);

      c = color(r, g, b);
    } else {
      // FAR AWAY
      float t_redValue = red(t);
      float t_greenValue = green(t);
      float t_blueValue = blue(t);

      c = color(t_redValue, t_greenValue, t_blueValue);
    }

    pg.stroke(c);

    if (mode) {
      pg.strokeWeight(map(d, 0, DIST, 5, 0.5));
    } else {
      pg.strokeWeight(10);
    }
    pg.point(pos.x, pos.y);
  }
}
