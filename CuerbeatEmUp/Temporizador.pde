//Modulo Temporizador
//elaborado por: Osorio Gutierrez David
//fecha de creación: 2 de octubre de 2023
//fecha de ultima modificación: 2 de octubre de 2023
//comentario: El Temporizador, basado en frames, para controlar diversos eventos 
//que requieran el paso de //cierta cantidad de tiempo, en su equivalente en 
//frames. Como referencia, un frame en un esquema de 60fps equivale a 1.6 
//centésimas de segundo o 3.2 en un esquema de 30fps. Si bien se tiene una 
//implementación parcial en el formato de milésimas de segundo en lugar de 
//frames, no se recomienda usarlo todavía, especialmente si ese temporizador 
//debe entrar en modo de pausa.

class Temporizador{
  int count;        //contador del temporizador
  int cntlimit;     //valor límite del temporizador
  float actime;     //hora de activación del temporizador
  float cotime;     //tiempo actual del temporizador desde su activación
  boolean active;   //temporizador activo (es decir que está en un ciclo de tiempo). Cuando vale falso reinicia.
  boolean off;      //indica cuando el temporizador cumple su ciclo
  boolean pause;    //detiene, pero con la posibilidad de conitnuar, un ciclo de tiempo
  
  //constructor, se indica la cantidad de frames que durará
  Temporizador(int cl){
    count=0;
    cntlimit=cl;
    actime=0f;
    cotime=0f;
    active=false;
    off=false;
    pause=false;
  }
  
  //activa el temporizador
  void activate(){
    off=false;
    active=true;
    pause=false;
    actime=millis();
    cotime=0f;
    count=0;
  }
  
  //detiene el temporizador
  void deactivate(){
    off=false;
    active=false;
    pause=false;
    actime=0f;
    count=0;
  }
  
  //indica si está activo
  boolean isActive(){
    return active;
  }
  
  //indica si se ha detenido
  boolean isOff(){
    return off;
  }
  
  //permite cambiar la duración del temporizador, se desactiva al realizar este cambio
  void setTime(int t){
    cntlimit=t;
    deactivate();
  }
  
  //control del avance del temporizador, con frames
  void coolingDown(){
    if(active && !pause){
      if(count<cntlimit)
        count++;
      else{
        active=false;
        count=0;
        off=true;
      }  
    }
  }
  
  //control de avance, en milisegundos (INCOMPLETO, no usar directamente)
  void coolingDownM(){
    if(active){
      cotime=millis()-actime;
      if(cotime>=cntlimit){
        active=false;
        off=true;
        actime=0f;
      }
    }
  }
  
  //devuelve la cantidad de frames restantes en el ciclo
  int countLeft(){
    return cntlimit-count;
  } 
  
  //devuelve la cantidad de tiempo restante en el ciclo. Al momento considerando 
  //un framerate de 60fps
  float timeLeft(){
    return (cntlimit-count)*1.0/60;
  }
  
  //conmuta la pausa, solo puede pausarse en modo activo
  void togglePause(){
    if(active)
      pause=!pause;
  }
  
  //grafica en forma de una barra de tiempo, los parámetros indican la posición, 
  //en modo esquina, del temporizador
  void drawTimeBar(int x,int y){
    rectMode(CORNER);
    stroke(0);
    fill(0);
    rect(x,y,160,14);
    stroke(0,170,0);
    fill(0,170,0);
    rect(x+1,y+1,int((count*1.0/cntlimit)*156),12);
    rectMode(CENTER);
  }
}
