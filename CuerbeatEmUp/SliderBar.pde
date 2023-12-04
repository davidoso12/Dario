//Modulo SliderBar
//elaborado por: Rubén Dario Hernandez Mendo
//fecha de creación: 1 de diciembre de 2023
//fecha de ultima modificación: 1 de diciembre de 2023
//comentario: La clase SliderBar implementa un control deslizante para elegir
// un valor dentro de un rango de valores
class SliderBar{
  Punto2D pos;
  Punto2D sze;
  Punto2D vrng;
  int val;
  

  SliderBar(Punto2D p,Punto2D s,Punto2D v){
    pos=new Punto2D(p);
    sze=new Punto2D(s);
    vrng=new Punto2D(v);
    val=v.getX();
  }
  
  void display(){
    rectMode(CENTER);
    fill(0);
    stroke(255);
    rect(pos.getX(),pos.getY(),sze.getX(),sze.getY());
    textAlign(CENTER,CENTER);
    fill(255);
    text(""+val,pos.getX(),pos.getY());
  }
  
  boolean isClicked(int x,int y,int b){
    boolean r=(((x>=pos.getX()-(sze.getX()/2))&&(x<=pos.getX()+(sze.getX()/2))) && 
               ((y>=pos.getY()-(sze.getY()/2))&&(y<=pos.getY()+(sze.getY()/2))));
    if(r) sfxclic.trigger();
    return r;
  }
  
  boolean basicHandler(int x,int y,int b){
    boolean c=isClicked(x,y,b);
    if(c)
      switch(b){
        case LEFT:  valueUp();
                    break;
        case RIGHT: valueDown();
                    break;
      }
      return c;
  }
  
  void valueDown(){
    if(val>vrng.getX())
     val--;
  }
  
  void valueUp(){
    if(val<vrng.getY())
     val++;
  }
  
  int getValue(){
    return val;
  }
  
  void setValue(int v){
    val=(v<vrng.getX())?vrng.getX():(v>vrng.getY())?vrng.getY():v;
  }
  
}
