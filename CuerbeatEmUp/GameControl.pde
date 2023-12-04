//Módulo GameControl
//Elaborado por: Rubén Dario Hernández Mendo
//Fecha de creación: 13 de septiembre de 2023 
//Fecha de última modificacion: 29 de noviembre de 2023
//Descripción: El módulo GameControl tendrá la función de
 //coordinar la ejecución del juego en función de la pantalla
 //activa.
 
 class GameControl{
   int pantact; //es la pantalla activa
   PantPrin pantprin;
   PantGame pantgame;
   PantLoad pantload;
   PantConfig pantconf;
   PantCredits pantcred;
   PantTopScore panttops;
   PantPause pantpause;
   PantEndGame pantendgame;
   boolean musicon;
   
   GameControl(){
     pantprin=new PantPrin();
     pantgame=new PantGame();
     pantload=new PantLoad();
     pantconf=new PantConfig();
     pantcred=new PantCredits();
     panttops=new PantTopScore();
     pantpause=new PantPause();
     pantendgame=new PantEndGame();
     musicon=false;
     pantact=PANTLOAD;
   }
   
   void display(){
     switch(pantact){
       case PANTPRIN: pantprin.display();
                      break;
       case PANTGAME: pantgame.display();
                      break;
       case PANTLOAD: pantload.display();
                      break;
       case PANTCONF: pantconf.display();
                      break;
       case PANTCRED: pantcred.display();
                      break;
       case PANTTOPS: panttops.display();
                      break;
       case PANTPAUS: pantpause.display();
                      break;
       case PANTENDG: pantendgame.display();
                      break;
     }
   }
   
   void setPantAct(int p){
     pantact=p;
   }
   
   int getPantAct(){
     return pantact;
   }
   
   void mouseControl(int x,int y, int b){
     switch(pantact){
       case PANTCONF:  pantconf.mouseControl(x,y,b);
                       break;
       case PANTGAME:  pantgame.mouseControl(x,y,b);
                       break;
       case PANTPRIN:  pantprin.mouseControl(x,y,b);
                       break;
       case PANTCRED:  pantcred.mouseControl(x,y,b);
                       break;
       case PANTTOPS:  panttops.mouseControl(x,y,b);
                       break;
       case PANTPAUS:  pantpause.mouseControl(x,y,b);
                       break;
       case PANTENDG:  pantendgame.mouseControl(x,y,b);
                       break;                 
     }                    
   }
   
   void keyControl(char k){
     switch(pantact){
       case PANTGAME: pantgame.keyControl(k);
                      break;
     }  
   }
   
   void keyRelControl(char k){
     switch(pantact){
       case PANTGAME: pantgame.keyRelControl(k);
                      break;
     }  
   }
   
   void musicManager(boolean s){
    musicon=s;
    playTrack((musicon?pantact:-1));
  }
  
  void playTrack(int t){
    //cada canción se maneja en bucle, al salir se pausa y regresa al inicio
    if(t==PANTPRIN) mscintro.loop(); else {mscintro.pause(); mscintro.rewind();}
    if(t==PANTGAME) mscstage.loop(); else {mscstage.pause(); mscstage.rewind();}
    if(t==PANTENDG && !win) mscendd.loop(); else {mscendd.pause(); mscendd.rewind();}
    if(t==PANTENDG && win) mscendv.loop(); else {mscendv.pause(); mscendv.rewind();}
  }
  
  void startLoop(AudioPlayer ap){
    if(!ap.isLooping()||!ap.isPlaying())ap.loop();
 }  
  
  boolean getMusicStatus(){
    return musicon;
  }
  
  void setDiff(int d){
    cf.dif=(d==24)?DFCEA:((d==25)?DFCNR:DFCHD);
  }
 }
