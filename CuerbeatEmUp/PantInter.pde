//Módulo PantGame
//Elaborado por: Rubén Dario Hernández Mendo
//Fecha de creación: 23 de septiembre de 2023 
//Fecha de última modificacion: 2 de diciembre de 2023
//Descripción: El módulo PantGame controla la pantalla
// de "acción" del juego.

class PantInter{  //regresa a pantalla principal
  Boton btnret;
  Boton btnplus;
  Boton btngamen;
  PantInter(){
    btngamen=new Boton(440,360,cf.btnw,cf.btnh,38);
    btnret=new Boton(840,360,cf.btnw,cf.btnh,19);
    btnplus=new Boton(650,260,cf.btnw,cf.btnh,39);
  }
  
  void display(){
    fill(color(0,0,0,5));
    stroke(255);
    rect(640,360,1280,720);
    textAlign(CENTER,CENTER);
    fill(255);
    text(idi.getMensaje(18),640,100);
    btngamen.display();
    btnret.display();
    btnplus.display();
  }
  
  void mouseControl(int x,int y,int b){
    if(btngamen.isClicked(x,y,b)){
      gc.musicManager(false);
      mscstage.setGain(cf.mscgain);
      resetgame=true;
      gc.setPantAct(PANTGAMEN);
    }  
    if(btnret.isClicked(x,y,b)){
      mscstage.setGain(cf.mscgain);
      gc.setPantAct(PANTGAME);
    } 
    if(btnplus.isClicked(x,y,b)){
      mscstage.setGain(cf.mscgain);
      gc.setPantAct(PANTPLUS);
    } 
  }
}
