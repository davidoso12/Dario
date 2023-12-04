//Módulo PantTopScore
//Elaborado por: Osorio Gutierrez David
//Fecha de creación: 6 de noviembre de 2023 
//Fecha de última modificacion: 29 de noviembre de 2023
//Descripción: El módulo PantConfig controla la pantalla
// de configuración del juego.

class PantTopScore{
  Boton btncan;  //regresa a pantalla principal
  
  PantTopScore(){
    ts=new TopScores();
    btncan=new Boton(640,690,cf.btnw,cf.btnh,20);
  }
  
  void display(){
    background(0,150,0);
    fill(255);
    stroke(255);
    textAlign(CENTER,CENTER);
    text(idi.getMensaje(17),640,50);
    ts.displayData();
    btncan.display();
  }
  
  void mouseControl(int x,int y,int b){
    if(btncan.isClicked(x,y,b))
      gc.setPantAct(PANTPRIN);
  }
}
