//Modulo Boton
//elaborado por: Rubén Dario Hernandez Mendo
//fecha de creación: 27 de septiembre de 2023
//fecha de ultima modificación: 25 de octubre de 2023
//comentario: la clase botón permite indicar acciones dentro 
// del juego, se usa para elegir opciones del menú principal y
// la mayoría de comandos del juego. Por su implementación 
// solo contiene texto en su interior y un fondo sencillo de
// color y borde.
class Boton{
  int cx;          //posición en X del centro del botón
  int cy;          //posición en Y del centro del botón
  int an;          //anchura del botón
  int al;          //altura del botón
  int t;           //texto del botón 
  PImage btn;      //imagen de fondo del botón
  
  //constructor: los primeros dos parámetros son la posición, el segundo par sus medidas y el quinto
  //parámetro el índice del texto de idioma específico
  Boton(int x,int y,int b,int a,int s){
    cx=x;
    cy=y;
    an=b;
    al=a;
    t=s;
    btn=loadImage("sprite/misc/boton.png");
  }
  
  //graficado del botón
  void display(){
    rectMode(CENTER);
    imageMode(CENTER);
    fill(0);
    stroke(255);
    image(btn,cx,cy,an,al);
    /*else rect(cx,cy,an,al);*/
    fill(255);
    textAlign(CENTER,CENTER);
    text(idi.getMensaje(t),cx,cy);
  }
  
  //permite cambiar el mensaje que contendrá el botón
  void setMessage(int m){
    t=m;
  }
  
  //manejador de evento, devuelve true si el clic ocurrió sobre él
  boolean isClicked(int x,int y,int b){
    boolean r=(b==LEFT &&(((x>=cx-(an/2))&&(x<=cx+(an/2))) && ((y>=cy-(al/2))&&(y<=cy+(al/2)))));
    if(r) sfxclic.trigger();
    return r;    
  } 
  
  //identifica si el mouse pasó encima suyo
  boolean isOver(int x,int y){
    boolean r=(((x>=cx-(an/2))&&(x<=cx+(an/2))) && ((y>=cy-(al/2))&&(y<=cy+(al/2))));
    return r; 
  }
  
  //devuelve el índice de mensaje contenido en el botón
  int getMsg(){
    return t;
  }
}
