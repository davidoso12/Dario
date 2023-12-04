// Módulo SliderBar
// Elaborado por: Rubén Dario Hernandez Mendo
// Fecha de creación: 1 de diciembre de 2023
// Fecha de última modificación: 1 de diciembre de 2023
// Comentario: La clase SliderBar implementa un control deslizante para elegir
// un valor dentro de un rango de valores

class SliderBar {
  Punto2D pos;
  Punto2D sze;
  Punto2D vrng;
  int val;

  // Constructor
  SliderBar(Punto2D p, Punto2D s, Punto2D v) {
    pos = new Punto2D(p);
    sze = new Punto2D(s);
    
    // Asegurarse de que vrng tiene un rango coherente
    vrng = new Punto2D(max(v.getX(), 0), max(v.getY(), 0));
    
    // Inicializar el valor con el componente x del rango
    val = vrng.getX();
  }

  // Método para mostrar el control deslizante
  void display() {
    rectMode(CENTER);
    fill(0);
    stroke(255);
    rect(pos.getX(), pos.getY(), sze.getX(), sze.getY());
    textAlign(CENTER, CENTER);
    fill(255);
    text("" + val, pos.getX(), pos.getY());
  }

  // Método para verificar si el control deslizante ha sido clicado
  boolean isClicked(int x, int y, int b) {
    boolean r = (((x >= pos.getX() - (sze.getX() / 2)) && (x <= pos.getX() + (sze.getX() / 2))) && 
                 ((y >= pos.getY() - (sze.getY() / 2)) && (y <= pos.getY() + (sze.getY() / 2))));
    if (r) {
      sfxclic.trigger();  // Reproducir sonido al hacer clic
    }
    return r;
  }

  // Manejar interacciones básicas
  boolean basicHandler(int x, int y, int b) {
    boolean c = isClicked(x, y, b);
    if (c) {
      switch (b) {
        case LEFT:
          valueUp();
          break;
        case RIGHT:
          valueDown();
          break;
      }
    }
    return c;
  }

  // Decrementar el valor del control deslizante
  void valueDown() {
    if (val > vrng.getX()) {
      val--;
    }
  }

  // Incrementar el valor del control deslizante
  void valueUp() {
    if (val < vrng.getY()) {
      val++;
    }
  }

  // Obtener el valor actual del control deslizante
  int getValue() {
    return val;
  }

  // Establecer un valor para el control deslizante
  void setValue(int v) {
    // Asegurarse de que el valor esté dentro del rango especificado por vrng
    val = constrain(v, vrng.getX(), vrng.getY());
  }
}
