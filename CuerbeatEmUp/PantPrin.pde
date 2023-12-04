//Módulo PantPrin
//Elaborado por: Rubén Dario Hernández Mendo
//Fecha de creación: 18 de septiembre de 2023 
//Fecha de última modificacion: 27 de noviembre de 2023
//Descripción: El módulo PantPrin controla la pantalla
// principal del juego.

class PantPrin{
  PImage imgtit;
  Boton btnplay;
  Boton btnexit;
  Boton btncred;
  Boton btntops;
  Boton btnconf;
  Boton btngamen;
  Temporizador tmpexit;
  
  PantPrin(){
    imgtit=loadImage("sprite/fondos/fondoraven.jpg");
    btnconf=new Boton(990,410,cf.btnw,cf.btnh,10);
    btnplay=new Boton(990,470,cf.btnw,cf.btnh,11);
    btntops=new Boton(990,530,cf.btnw,cf.btnh,12);
    btncred=new Boton(990,590,cf.btnw,cf.btnh,13);
    btnexit=new Boton(990,650,cf.btnw,cf.btnh,14);
    btngamen=new Boton(990,390,cf.btnw,cf.btnh,14);
    tmpexit=new Temporizador(120);
  }
  
  void display(){
    music();
    background(255);
    fill(0);
    stroke(0);
    textAlign(CENTER,CENTER);
    text(idi.getMensaje(2),640,360);
    imageMode(CENTER);
    image(imgtit,640,360);
    btnconf.display();
    btnplay.display();
    btntops.display();
    btncred.display();
    btnexit.display();
    btngamen.display();
    if(tmpexit.isActive())
      tmpexit.coolingDown();
    if(tmpexit.isOff()){
      bit.cierraBitacora();
      exit();
    }  
  }
  
  void mouseControl(int x,int y,int b){
    if(btnconf.isClicked(x,y,b)){ 
      gc.setPantAct(PANTCONF);
    }  
    if(btnplay.isClicked(x,y,b)){
      voistart.trigger();
      gc.musicManager(false);
      gc.setPantAct(PANTGAME);
    }  
    if(btntops.isClicked(x,y,b))
      gc.setPantAct(PANTTOPS);
    if(btngamen.isClicked(x,y,b))
      gc.setPantAct(PANTGAMEN);
    if(btncred.isClicked(x,y,b)){
      gc.musicManager(false);
      gc.setPantAct(PANTCRED);
    }  
    if(btnexit.isClicked(x,y,b))
      tmpexit.activate();  
  }
}
