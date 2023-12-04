//Modulo BotonUD
//elaborado por: Osorio Gutierrez David
//fecha de creación: 26 de noviembre de 2023
//fecha de ultima modificación: 26 de diciembre de 2023
//comentario: se implementa un botón Up-Down.
class BotonUD{
  Punto2D pos;     //posición del centro del botón
  Punto2D sze;     //tamaño del botón
  int t;           //texto del botón 
  PImage btn;      //imagen de fondo del botón
  
  //constructor: los primeros dos parámetros son la posición, el segundo par sus medidas y el quinto
  //parámetro el índice del texto de idioma específico
  BotonUD(int x,int y,int b,int a,char l){
    pos=new Punto2D(x,y);
    sze=new Punto2D(b,a);
    t=int(l);
    btn=loadImage("sprite/misc/boton.png");
  }
  
  BotonUD(Punto2D p,Punto2D s,char l){
    pos=new Punto2D(p);
    sze=new Punto2D(s);
    t=int(l);
    btn=loadImage("sprite/misc/boton.png");
  }
  
  //graficado del botón
  void display(){
    rectMode(CENTER);
    imageMode(CENTER);
    fill(0);
    stroke(255);
    image(btn,pos.getX(),pos.getY(),sze.getX(),sze.getY());
    fill(255);
    textAlign(CENTER,CENTER);
    text(char(t),pos.getX(),pos.getY());
  }
  
  //manejador de evento, devuelve true si el clic ocurrió sobre él
  boolean isClicked(int x,int y, int b){
    boolean r=((b==LEFT || b==RIGHT) &&
              (((x>=pos.getX()-(sze.getX()/2))&&(x<=pos.getX()+(sze.getX()/2))) && 
               ((y>=pos.getY()-(sze.getY()/2))&&(y<=pos.getY()+(sze.getY()/2)))));
    if(r) sfxclic.trigger();
    return r;    
  } 
  
  //determina si el mouse pasa por encima del BotonUD
  boolean isOver(int x,int y){
    boolean r=(((x>=pos.getX()-(sze.getX()/2))&&(x<=pos.getX()+(sze.getY()/2))) &&
               ((y>=pos.getY()-(sze.getY()/2))&&(y<=pos.getY()+(sze.getY()/2))));
    return r; 
  }
  
  //devuelve el caracter actual del BotonUD
  char getChar(){
    return char(t);
  }
  
  //avanza un caracter del rango de valores, mayúsculas y números
  void charUp(){
    if(char(t)<'9') t++;
    else if(char(t)=='9') t=int('A');
      else if(char(t)<'Z') t++;
        else t=int('0');
  }
  
  //retrocede un caracter del rango de valores, mayúsculas y números
  void charDn(){
    if(char(t)>'A') t--;
    else if(char(t)=='A') t=int('9');
      else if(char(t)>'0') t--;
        else t=int('Z');
  }

}
