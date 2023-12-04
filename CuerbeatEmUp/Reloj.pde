//Modulo Reloj
//elaborado por: Osorio Gutierrez David
//fecha de creación: 2 de octubre de 2023
//fecha de ultima modificación: 29 de noviembre de 2022
//comentario: Implementa un reloj en formato de segundos y minutos, se usará
//para llevar el tiempo de juego
class Reloj{
  Temporizador tmp;  //temporizador que va avanzando el tiempo
  int mins;          //conteo de minutos
  int segs;          //conteo de segundos
  int msgs;          //conteo de milésimas
  
  //Constructor: establece en un segundo e inicializa variables
  Reloj(){
    tmp=new Temporizador(60);
    mins=segs=msgs=0;
  }
  
  //comienza el conteo de tiempo
  void iniciaReloj(){
    tmp.activate();
  }
  
  //pone en pausa el reloj
  void pausaReloj(){
    tmp.togglePause();
  }
  
  //detiene el reloj
  void detenReloj(){
    tmp.deactivate();
  }
  
  //reinicia el reloj
  void resetReloj(){
   tmp.deactivate();
   mins=segs=msgs=0;
  }
  
  //avanza el reloj y va actualizando el tiempo cronometrado
  void controlReloj(){
    tmp.coolingDown();
    msgs=int(tmp.timeLeft()*1000);
    if(tmp.isOff()){
      segs++;
      if(segs==60){
        segs=0;
        mins++;
      }
      tmp.activate();
    }
  }
  
  //grafica el estado del reloj, en formato minutos:segundos
  void display(int x,int y){
    textAlign(CENTER,CENTER);
    stroke(255);
    fill(255);
    textSize(50);
    text(((mins<10)?"0":"")+mins+":"+((segs<10)?"0":"")+segs/*+"."+msgs*/,x,y);
    textSize(32);
  }
  
  //devuelve el tiempo acumulado, en formato minutos:segundos
  String getTime(){
    return ((mins<10)?"0":"")+mins+":"+((segs<10)?"0":"")+segs;
  }
}
