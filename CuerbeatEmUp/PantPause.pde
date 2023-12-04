//Módulo PantPause
//Elaborado por: Rubén Dario Hernández Mendo
//Fecha de creación: 6 de noviembre de 2023 
//Fecha de última modificacion: 30 de noviembre de 2023
//Descripción: El módulo PantConfig controla la pantalla
// de configuración del juego.

class PantPause{
  Boton btncan;  //regresa a pantalla principal
  Boton btnret;
  
  PantPause(){
    btncan=new Boton(440,360,cf.btnw,cf.btnh,20);
    btnret=new Boton(840,360,cf.btnw,cf.btnh,19);
  }
  
  void display(){
    fill(color(128,0,128,5));
    stroke(255);
    rect(640,360,1280,720);
    textAlign(CENTER,CENTER);
    fill(0);
    text(idi.getMensaje(18),640,100);
    btncan.display();
    btnret.display();
  }
  
  void mouseControl(int x,int y,int b){
    if(btncan.isClicked(x,y,b)){
      gc.musicManager(false);
      mscstage.setGain(cf.mscgain);
      resetgame=true;
      gc.setPantAct(PANTPRIN);
    }  
    if(btnret.isClicked(x,y,b)){
      mscstage.setGain(cf.mscgain);
      gc.setPantAct(PANTGAME);
    }  
  }
}
