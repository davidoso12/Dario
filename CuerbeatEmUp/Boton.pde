// Modulo Boton
// Elaborado por: David Osorio Gutierrez
// Fecha de creación: 6 de septiembre de 2023 
// Fecha de última modificación: 4 de diciembre de 2023
// Comentario: la clase botón permite indicar acciones dentro 
// del juego, se usa para elegir opciones del menú principal y
// la mayoría de comandos del juego. Por su implementación 
// solo contiene texto en su interior y un fondo sencillo de
// color y borde.

class Boton {
  int cx;
  int cy;
  int an;
  int al;
  int t;
  PImage btn;

  Boton(int x, int y, int b, int a, int s) {
    cx = x;
    cy = y;
    an = b;
    al = a;
    t = s;
    btn = loadImage("sprite/misc/boton-rd.png");
  }

  void display() {
    rectMode(CENTER);
    imageMode(CENTER);

    // Fondo gris oscuro si no hay imagen
    if (btn == null) {
      fill(40); // Color gris oscuro (ajusta según tu preferencia)
      noStroke();
      rect(cx, cy, an, al, 10); // Borde redondeado
    }

    // Efecto de hundimiento al presionar
    if (mousePressed && isOver(mouseX, mouseY)) {
      fill(30); // Color más oscuro al presionar (ajusta según tu preferencia)
      rect(cx, cy + 2, an, al, 10); // Hundir ligeramente el botón
    } else if (isOver(mouseX, mouseY)) {
      fill(20, 20, 60); // Azul oscuro al pasar el mouse (ajusta según tu preferencia)
      rect(cx, cy, an, al, 10); // Borde redondeado
    } else {
      fill(50); // Color de fondo normal (ajusta según tu preferencia)
      rect(cx, cy, an, al, 10); // Borde redondeado
    }

    // Dibuja la imagen detrás del texto
    if (btn != null) {
      image(btn, cx, cy, an - 4, al - 4); // Ajusta según el tamaño del borde
    }

    // Dibuja el texto en el centro
    fill(255);
    textAlign(CENTER, CENTER);
    text(idi.getMensaje(t), cx, cy);
  }

  void setMessage(int m) {
    t = m;
  }

  boolean isClicked(int x, int y, int b) {
    boolean r = (b == LEFT && (((x >= cx - (an / 2)) && (x <= cx + (an / 2))) && ((y >= cy - (al / 2)) && (y <= cy + (al / 2)))));
    if (r) sfxclic.trigger();
    return r;    
  } 

  boolean isOver(int x, int y) {
    return (((x >= cx - (an / 2)) && (x <= cx + (an / 2))) && ((y >= cy - (al / 2)) && (y <= cy + (al / 2))));
  }

  int getMsg() {
    return t;
  }
}

