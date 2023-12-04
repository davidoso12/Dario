//Módulo PantEndGame
//Elaborado por: Rubén Dario Hernández Mendo
//Fecha de creación: 26 de noviembre de 2023 
//Fecha de última modificacion: 29 de noviembre de 2023
//Descripción: El módulo PantEndGame controla la pantalla de configuración del
// juego.

class PantEndGame{
  Boton btncan;  //regresa a pantalla principal
  PImage imgend;
  
  PantEndGame(){
    btncan=new Boton(640,670,cf.btnw,cf.btnh,20);
  }
  
  void display(){
    music();
    /*fill(color(255,0,0,5));
    stroke(255);
    rect(640,360,1280,720);*/
    textAlign(CENTER,CENTER);
    fill(0);
    text(idi.getMensaje(29),640,100);
    image(imgend,640,360);
    btncan.display();
  }
  
  void mouseControl(int x,int y,int b){
    if(btncan.isClicked(x,y,b)){
      gc.musicManager(false);
      resetgame=true;
      gc.setPantAct(PANTPRIN);
    }  
  }
  
  void cargaFinal(boolean r){
    imgend=loadImage("sprite/fondos/fondo"+((r)?"vic":"def")+".jpg");  
  }
}
