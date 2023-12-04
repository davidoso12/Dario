//Módulo LifeBar
//elaborado por: Rubén Dario Hernandez Mendo
//fecha de creación: 8 de noviembre de 2023
//fecha de ultima modificación: 1 de diciembre de 2023
//comentario: Se implementa una barra de vida para controlar la salud del
// personaje y los enemigos.

class LifeBar {
  int maxhp;
  int hp;
  Punto2D pos;
  Punto2D sze;
  boolean dead;
  color colhlt;
  PImage decorationImage;
  PImage backgroundImg;
  float animWidth;  // Ancho animado para transiciones suaves

  LifeBar(int mhp, Punto2D p, Punto2D s, color ch, PImage decorationImg, PImage backgroundImg) {
    hp = maxhp = mhp;
    pos = new Punto2D(p);
    sze = new Punto2D(s);
    dead = false;
    colhlt = ch;
    animWidth = sze.getX();

    decorationImage = decorationImg.copy();
    decorationImage.resize(int(sze.getX()), int(sze.getY()));

    this.backgroundImg = backgroundImg.copy();
    this.backgroundImg.resize(int(sze.getX()), int(sze.getY()));
  }

  void display() {
    rectMode(CENTER);

    float percent = hp * 1.0 / maxhp;
    float newWidth = sze.getX() * percent;

    // Animación suave para el ancho de la barra de vida
    animWidth = lerp(animWidth, newWidth, 0.1);

    // Asegúrate de que el ancho animado no sea menor que cero
    animWidth = max(0, animWidth);

    // Dibuja la imagen de fondo detrás de la barra de vida
    imageMode(CENTER);
    image(backgroundImg, pos.getX(), pos.getY());

    // Dibuja la barra de vida con estilos visuales mejorados
    color barColor = calculateBarColor(percent);
    fill(barColor);
    noStroke();

    // Calcula la posición del extremo izquierdo de la barra de vida
    float leftX = pos.getX() - sze.getX() / 2;

    // Dibuja la barra de vida desde el extremo izquierdo hacia el derecho
    rect(leftX + animWidth / 2, pos.getY(), animWidth, sze.getY(), 15);

    // Dibuja la imagen de decoración sobre la barra de vida
    image(decorationImage, pos.getX(), pos.getY());

    // Opcional: Agrega efectos adicionales, como un resplandor cuando la vida está baja
    if (percent <= 0.2) {
      applyGlowEffect(barColor);
    }
  }

  void applyGlowEffect(color c) {
    int glowSize = 10;
    for (int i = 0; i < glowSize; i++) {
      int alpha = (int) map(i, 0, glowSize, 0, 50);
      fill(red(c), green(c), blue(c), alpha);
      float glowWidth = animWidth + i * 2;
      rect(pos.getX(), pos.getY(), glowWidth, sze.getY(), 15);
    }
  }

  color calculateBarColor(float percent) {
    if (percent <= 0.2) {
      return color(255, 0, 0);  // Rojo
    } else if (percent <= 0.4) {
      return color(255, 165, 0);  // Naranja
    } else if (percent <= 0.8) {
      return color(255, 255, 0);  // Amarillo
    } else {
      return color(0, 128, 0);  // Verde
    }
  }

  void heal(int h) {
    hp += h;
    if (hp > maxhp) hp = maxhp;
  }

  boolean injure(int h) {
    hp -= h;
    dead = hp <= 0;
    if (dead) hp = 0;
    else sfxscream.trigger();
    return dead;
  }

  boolean isDead() {
    return dead;
  }
}
