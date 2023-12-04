//Módulo PantLoad
//Elaborado por: Osorio Gutierrez David
//Fecha de creación: 18 de septiembre de 2023 
//Fecha de última modificacion: 25 de octubre de 2023
//Descripción: El módulo PantLoad controla la pantalla
// de carga inicial de datos del juego.

class PantLoad{
  PImage imgtit;
  Temporizador tmpidle;
  boolean loading;
  int msg;
  
  PantLoad(){
    imgtit = loadImage("sprite/fondos/principla.png");
    tmpidle=new Temporizador(180);
    loading=true;
  }
  
  void display(){
    background(128);
    fill(255);
    stroke(255);
    textAlign(CENTER,CENTER);
    text(idi.getMensaje(1),640,360);
    text(idi.getMensaje(msg),400,600);
    imageMode(CENTER);
    image(imgtit,640,360);
    if(!loading && !tmpidle.isActive())
      tmpidle.activate();
    if(tmpidle.isActive())
      tmpidle.coolingDown();
    if(tmpidle.isOff())
      gc.setPantAct(PANTPRIN);
  }
}
