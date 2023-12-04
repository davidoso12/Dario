//Modulo ToggleButton
//elaborado por: Rubén Dario Hernandez Mendo
//fecha de creación: 26 de noviembre de 2023
//fecha de ultima modificación: 26 de noviembre de 2023
//comentario: la clase ToggleButton implementa un botón tipo checkbox, es decir
// que tiene un estado de encendido o apagado.

class ToggleButton{
  Punto2D pos;
  Punto2D sze;
  boolean active;  //estado del boton, true=encendido false=apagado
  
  ToggleButton(int x,int y,int r,boolean s){
    pos=new Punto2D(x,y);
    sze=new Punto2D(2*r,2*r);
    active=s;
  }
  
  ToggleButton(Punto2D p,Punto2D t,boolean s){
    pos=new Punto2D(p);
    sze=new Punto2D(t);
    active=s;
  }
  
  void display(){
    ellipseMode(CENTER);
    fill(((active)?color(0,200,0):color(200,0,0)));
    stroke(0);
    circle(pos.getX(),pos.getY(),sze.getX());
  }
  
  boolean isClicked(int x,int y,int b){
    boolean r=(b==LEFT &&(((x>=pos.x-(sze.x/2))&&(x<=pos.x+(sze.x/2))) && 
                          ((y>=pos.y-(sze.y/2))&&(y<=pos.y+(sze.y/2)))));
    if(r){
      sfxclic.trigger();
      active=!active;
    }  
    return r;    
  }
  
  boolean isOver(int x,int y){
    boolean r=(((x>=pos.x-(sze.x/2))&&(x<=pos.x+(sze.x/2))) && 
               ((y>=pos.y-(sze.y/2))&&(y<=pos.y+(sze.y/2))));
    return r; 
  }
}
