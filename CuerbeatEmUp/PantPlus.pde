//Módulo PantGame
//Elaborado por: Rubén Dario Hernández Mendo
//Fecha de creación: 23 de septiembre de 2023 
//Fecha de última modificacion: 2 de diciembre de 2023
//Descripción: El módulo PantGame controla la pantalla
// de "acción" del juego.

class PantPlus{
  Personaje per;
  HealItem hi;
  Reloj rlj;
 // PImage cielo;
  PImage montes;
  PImage piso;
  Punto2D imgcie;
  Punto2D imgmon;
  Punto2D imgpis;
  Boton btnpause;
  Boton btngamen;
  Boton btnret;
  float bal;
  int dir;
  
  PantPlus(){
    per=new Personaje(140,500,100,200);
    hi=new HealItem(450,500,0,0);
    rlj=new Reloj();
    rlj.iniciaReloj();
    //cielo=loadImage("sprite/fondos/cielo.png");
    montes=loadImage("sprite/fondos/montes.png");
    piso=loadImage("sprite/fondos/piso.png");
    imgcie=new Punto2D(0,0);
    imgmon=new Punto2D(0,-65);
    imgpis=new Punto2D(0,260);
    
    btnpause=new Boton(640,685,cf.btnw,cf.btnh,15);
    btngamen=new Boton(640,50,cf.btnw,cf.btnh,38);
    btnret=new Boton(890,50,cf.btnw,cf.btnh,19);
    bal=-1.0;
    dir=RIGHT;
  }
  
  void display(){
    music();
    if(resetgame)
      resetGame();
    background(0,0,0);
    fill(255);
    stroke(255);
    textAlign(CENTER,CENTER);
    text(idi.getMensaje(0),640,360);
    //planoCielo();
    planoFondo();
    planoFrente();
    moverPlanos();
    imageMode(CENTER);
    hi.display();
    graficaCombatientes();
    checkColisiones();
    rlj.controlReloj();
    btnpause.display();
    btngamen.display();
    btnret.display();
    bal+=(dir==RIGHT)?0.001:-0.001;
    if(Math.abs(bal)>=1)
      dir=(bal>=1)?LEFT:RIGHT;
    mscstage.setBalance(bal);  
    if(per.isDead() && per.anistr.getActiveSpriteSet().endot){
      rlj.detenReloj();
      salvaTiempo();
      gc.pantendgame.cargaFinal(false);
      win=false;
      gc.musicManager(false);
      gc.setPantAct(PANTENDG);
    }  
  }
  
  void graficaCombatientes(){
    if(per.pos.getY()<=per.pos.getY()){ //personaje al fondo
      per.display();
    }
    else{  //enemigo al fondo
      per.display();
    }
  }
  
  //void planoCielo(){
  //  imageMode(CORNER);
  //  image(cielo,imgcie.getX(),imgcie.getY());
  //}
  
  void planoFondo(){
    imageMode(CORNER);
    image(montes,imgmon.getX(),imgmon.getY());
  }
  
  void planoFrente(){
    imageMode(CORNER);
    image(piso,imgpis.getX(),imgpis.getY());
    rlj.display(640,50);
  }
  
  void moverPlanos(){
    if(imgcie.getX()<=-2560)
      per.reachedBorder();
    if(per.hasMovedX()&& imgcie.getX()>-2560){
      imgcie.moverP(-1,0);
      imgmon.moverP(-2,0);
      imgpis.moverP(-3,0);
      hi.moverH(-3,0);
    }
  }
  
  void keyControlPantPlus(char P){
    per.keyControl(P);
  }

  void keyRelControlPantPlus(char P){
    per.keyRelControl(P);
  }
  
  
  void mouseControl(int x,int y,int b){
    if(btnpause.isClicked(x,y,b)){
      mscstage.setGain(cf.mscgainlow);
      gc.setPantAct(PANTPAUS);
    }
    if(btngamen.isClicked(x,y,b)){
      mscstage.setGain(cf.mscgainlow);
      gc.setPantAct(PANTGAMEN);
    }  
    if(btnret.isClicked(x,y,b)){
      mscstage.setGain(cf.mscgainlow);
      gc.setPantAct(PANTGAME);
    }  
  }
  
  void checkColisiones(){
    //colisiones del cuerpo del personaje contra otros elementos  
    if(per.clbody.isColision(hi.clheal)){
      sfxdrink.trigger();
      per.curar(); 
      per.ht.activate();
      per.clbody.deactivate();
      hi.toggleActive();
    }
  }
  
  void resetGame(){
    per=new Personaje(140,500,100,200);
    hi=new HealItem(450,500,0,0);
    rlj.resetReloj();
    rlj.iniciaReloj();
    imgcie=new Punto2D(0,0);
    imgmon=new Punto2D(0,-70);
    imgpis=new Punto2D(0,260);
    bal=-1.0;
    dir=RIGHT;
    resetgame=false;
  }
  
  void salvaTiempo(){
    String td=""+rlj.getTime();
    ts.addTime(td);
    ts.saveData();
  }
}
