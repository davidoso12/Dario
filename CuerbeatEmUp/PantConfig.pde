//Módulo PantConfig
//Elaborado por: Rubén Dario Hernández Mendo
//Fecha de creación: 27 de septiembre de 2023 
//Fecha de última modificacion: 1 de diciembre de 2023
//Descripción: El módulo PantConfig controla la pantalla
// de configuración del juego.

class PantConfig{
  Boton btnidi;         //cambia el idioma
  Boton btncan;         //regresa a pantalla principal
  Boton btnsav;         //guarda configuración
  Boton btndif;         //selector de dificultad
  BotonUD btnl1;        //nombre jugador letra 1
  BotonUD btnl2;        //nombre jugador letra 2
  BotonUD btnl3;        //nombre jugador letra 3
  ToggleButton btncol;  //indica el estado de graficación de colisionadores
  SliderBar slbvsfx;    //slider par controlar el volumen de efectos de sonido
  SliderBar slbvmsc;    //slider par controlar el volumen de musica
  SliderBar slbvvoi;    //slider par controlar el volumen de voces
  PImage imgfondo;
  
  PantConfig(){
    btnidi=new Boton(840,150,cf.btnw,cf.btnh,4);
    btncol=new ToggleButton(840,290,25,cf.drwc);
    btndif=new Boton(840,360,cf.btnw,cf.btnh,cf.dif);
    btncan=new Boton(490,680,cf.btnw,cf.btnh,5);
    btnsav=new Boton(790,680,cf.btnw,cf.btnh,6);
    //carga las letras de los botones para el nombre
    btnl1=new BotonUD(790,220,50,60,cf.plynm.charAt(0));
    btnl2=new BotonUD(840,220,50,60,cf.plynm.charAt(1));
    btnl3=new BotonUD(890,220,50,60,cf.plynm.charAt(2));
    slbvsfx=new SliderBar(new Punto2D(840,430),new Punto2D(cf.btnw,cf.btnh),
                          new Punto2D(cf.mingain,cf.maxgain));
    slbvmsc=new SliderBar(new Punto2D(840,500),new Punto2D(cf.btnw,cf.btnh),
                          new Punto2D(cf.mingain,cf.maxgain));
    slbvvoi=new SliderBar(new Punto2D(840,570),new Punto2D(cf.btnw,cf.btnh),
                          new Punto2D(cf.mingain,cf.maxgain));
    slbvsfx.setValue(cf.sfxgain); 
    slbvmsc.setValue(cf.mscgain);
    slbvvoi.setValue(cf.voigain);
    imgfondo=loadImage("sprite/fondos/mapa.png");
  }
  
  void display(){
    background(imgfondo);
    fill(255);
    stroke(255);
    textAlign(CENTER,CENTER);
    text(idi.getMensaje(3),640,100);
    textAlign(LEFT,CENTER);
    text(idi.getMensaje(21),390,150);
    text(idi.getMensaje(27),390,220);
    text(idi.getMensaje(22),390,290);
    text(idi.getMensaje(23),390,360);
    text(idi.getMensaje(34),390,430);
    text(idi.getMensaje(35),390,500);
    text(idi.getMensaje(36),390,570);
    btnidi.display();
    btncan.display();
    btnsav.display();
    btncol.display();
    btndif.display();
    btnl1.display();
    btnl2.display();
    btnl3.display();
    slbvsfx.display();
    slbvmsc.display();
    slbvvoi.display();
  }
  
  void mouseControl(int x,int y,int b){
    if(btnidi.isClicked(x,y,b)){ 
      idi.setIdioma((idi.getIdioma()==IDESP)?IDENG:IDESP);
      cargaDialogos();
    }  
    if(btncan.isClicked(x,y,b))
      gc.setPantAct(PANTPRIN);
    if(btnsav.isClicked(x,y,b))
      cf.saveConfig(idi); 
    if(btncol.isClicked(x,y,b));
      cf.drwc=btncol.active;
    if(btndif.isClicked(x,y,b)){
      btndif.setMessage(((btndif.getMsg()==24)?25:((btndif.getMsg()==25)?26:24)));
      gc.setDiff(btndif.getMsg());
    }
    //control del nombre del jugador
    if(btnl1.isClicked(x,y,b))
      botonUDControl(btnl1,b);
    if(btnl2.isClicked(x,y,b))
      botonUDControl(btnl2,b);
    if(btnl3.isClicked(x,y,b))
      botonUDControl(btnl3,b);
    if(slbvsfx.basicHandler(x,y,b))
      cf.sfxgain=slbvsfx.getValue();
    if(slbvmsc.basicHandler(x,y,b))
      cf.mscgain=slbvmsc.getValue();
    if(slbvvoi.basicHandler(x,y,b))
      cf.voigain=slbvvoi.getValue();
    /*if(slbvvoi.isClicked(x,y,b))
      cf.voigain=slbvvoi.getValue(); */
  }
  
  void botonUDControl(BotonUD bt,int b){
    if(b==LEFT) bt.charUp();
    else bt.charDn();
    cf.plynm=""+btnl1.getChar()+btnl2.getChar()+btnl3.getChar();
  }
  
}
