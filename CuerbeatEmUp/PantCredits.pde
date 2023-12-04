//Módulo PantCredits
//Elaborado por: Osorio Gutierrez David
//Fecha de creación: 6 de noviembre de 2023 
//Fecha de última modificacion: 2 de Diciembre de 2023
//Descripción: El módulo PantConfig controla la pantalla
// de configuración del juego.

class PantCredits{
  Boton btncan;  //regresa a pantalla principal
  boolean movact;
  
  PantCredits(){
    btncan=new Boton(30,695,cf.btnw/4,cf.btnh-10,31);
    movact=false;
  }
  
  void display(){
    background(0);
    fill(255);
    stroke(255);
    textAlign(CENTER,CENTER);
    text(idi.getMensaje(16),640,360);
    if(!movact){ //inicia la reproducción
      mvcred.play();
      movact=true;
    }
    //cuando el video termina, lo reinicia.
    if(movact && mvcred.time()>=int(mvcred.duration())){
      mvcred.stop();
      mvcred.jump(0.0);
      movact=false;
    }
    image(mvcred,640,360);
    btncan.display();
  }
  
  void mouseControl(int x,int y,int b){
    if(btncan.isClicked(x,y,b)){
      mvcred.stop();
      mvcred.jump(0.0);
      movact=false;
      gc.musicManager(false);
      gc.setPantAct(PANTPRIN);
    }
  }
}
