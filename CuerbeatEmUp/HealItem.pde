//Módulo HealItem
//elaborado por: Osorio Gutierrez David
//fecha de creación: 20 de noviembre de 2023
//fecha de ultima modificación: 27 de noviembre de 2023
//comentario: 
class HealItem{
  Punto2D pos;
  Punto2D sze;
  PImage hitm;
  boolean active;
  Colisionador clheal;
  
  HealItem(Punto2D p,Punto2D s){
    pos=new Punto2D(p);
    sze=new Punto2D(s);
    clheal=new Colisionador(pos,new Punto2D(0,0),cf.hcs,COLHEAL);
    active=true;
    hitm=loadImage("sprite/misc/plus.png");
  }
  
  HealItem(int x,int y,int fx,int fy){
    pos=new Punto2D(x,y);
    sze=new Punto2D(fx,fy);
    clheal=new Colisionador(pos,new Punto2D(0,0),cf.hcs,COLHEAL);
    active=true;
    hitm=loadImage("sprite/misc/plus.png");
  }
  
  void display(){
    imageMode(CENTER);
    if(active){
      image(hitm,pos.getX(),pos.getY());
      if(cf.drwc)
        clheal.drawAreaColision();
    }  
  }
  
  void moverH(Punto2D m){
    pos.moverP(m);
    clheal.moverCol(m);
    if(pos.getX()<-cf.hcs)
      clheal.toggleActive();
  }
  
  void moverH(int x,int y){
    pos.moverP(x,y);
    clheal.moverCol(x,y);
    if(pos.getX()<-cf.hcs)
      clheal.toggleActive();
  }
  
  void toggleActive(){
    active=!active;
    clheal.toggleActive();
  }
}
