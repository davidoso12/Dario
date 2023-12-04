class Colisionador {
  Punto2D pos;
  Punto2D rel;
  boolean xrn;
  boolean yrn;
  int rad;
  boolean active;
  int type;

  Colisionador(Punto2D p, Punto2D f, int r, int t) {
    pos = new Punto2D(p);
    rel = new Punto2D(f);
    rad = r;
    type = t;
    active = xrn = yrn = true;
  }

  Colisionador(int x, int y, int fx, int fy, int r, int t) {
    pos = new Punto2D(x, y);
    rel = new Punto2D(fx, fy);
    rad = r;
    type = t;
    active = xrn = yrn = true;
  }

  void moverCol(int x, int y) {
    pos.moverP(x, y);
  }

  void moverCol(Punto2D p) {
    pos.moverP(p);
  }

  boolean isColision(Colisionador cls) {
    boolean c = false;
    if (active && cls.active) {
      float dx = (cls.pos.getX() + (cls.xrn ? 1 : -1) * cls.rel.getX()) - (pos.getX() + (xrn ? 1 : -1) * rel.getX());
      float dy = (cls.pos.getY() + (cls.yrn ? 1 : -1) * cls.rel.getY()) - (pos.getY() + (yrn ? 1 : -1) * rel.getY());
      float ds = sqrt(dx * dx + dy * dy);
      c = (ds < (rad + cls.rad));
    }
    return c;
  }

  int getColisionType() {
    return type;
  }

  void toggleActive() {
    active = !active;
  }

  void activate() {
    active = true;
  }

  void deactivate() {
    active = false;
  }

  void drawAreaColision() {
    ellipseMode(CENTER);
    fill(getColColor(false));
    if (active)
      stroke(getColColor(true));
    else
      stroke(0, 0, 0);
    circle(pos.getX() + (xrn ? 1 : -1) * rel.getX(), pos.getY() + (yrn ? 1 : -1) * rel.getY(), rad * 2);
  }

  color getColColor(boolean t) {
    color c = 0;
    if (t) {
      switch (type) {
        case COLBODY:
          c = color(0, 0, 172);
          break;
        case COLATCK:
          c = color(172, 0, 0);
          break;
        case COLDEFN:
          c = color(0, 172, 0);
          break;
        case COLHEAL:
          c = color(0, 172, 172);
          break;
        case COLVIEW:
          c = color(58, 236, 230);
          break;
      }
    } else {
      switch (type) {
        case COLBODY:
          c = color(0, 0, 172, 128);
          break;
        case COLATCK:
          c = color(172, 0, 0, 128);
          break;
        case COLDEFN:
          c = color(0, 172, 0, 128);
          break;
        case COLHEAL:
          c = color(0, 172, 172, 128);
          break;
        case COLVIEW:
          c = color(58, 236, 230, 128);
          break;
      }
    }
    return c;
  }

  String toString() {
    return "(" + pos.getX() + "," + pos.getY() + ")";
  }

  void setXRN(int d) {
    xrn = d == RIGHT;
  }

  void setYRN(int d) {
    yrn = d == DOWN;
  }
}
