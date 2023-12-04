//Módulo Colisionador
//elaborado por: Osorio Gutierrez David
//fecha de creación: 10 de noviembre de 2023
//fecha de ultima modificación: 20 de noviembre de 2023
//comentario:
class Colisionador{
  Punto2D pos;    //posición en pantalla del colisionador
  Punto2D rel;    //posición relativa
  boolean xrn;    //dirección x del relativo normal
  boolean yrn;    //dirección y del relativo normal
  int rad;        //radio para el alcance del colisionador
  boolean active; //estado funcional del colisionador
  int type;       //tipo de colisionador
  
  //Constructor: recibe como Punto2D todos los valores numéricos de coordenadas
  Colisionador(Punto2D p,Punto2D f,int r,int t){
    pos=new Punto2D(p);
    rel=new Punto2D(f);
    rad=r;
    type=t;
    active=xrn=yrn=true;
  }
  
  //Constructor: recibe como int cada uno de los valores de coordenadas
  Colisionador(int x,int y,int fx,int fy,int r,int t){
    pos=new Punto2D(x,y);
    rel=new Punto2D(fx,fy);
    rad=r;
    type=t;
    active=xrn=yrn=true;
  }
  
  //Asignación directa de la posicion del colisionador, con valores sueltos
  void moverCol(int x,int y){
    pos.moverP(x,y);
  }
  
  //Asignación directa de la posición del colisionador, con un Punto2D
  void moverCol(Punto2D p){
    pos.moverP(p);
  }
  
  //determina si hay una colisión con otro colisionador
  boolean isColision(Colisionador cls){
    boolean c=false;  //indica si ocurre, se parte del principio que no la hay
    if(active && cls.active){
      //distancias por eje
      float dx=(cls.pos.getX()+((cls.xrn)?1:-1)*cls.rel.getX())-(pos.getX()+((xrn)?1:-1)*rel.getX());
      float dy=(cls.pos.getY()+((cls.yrn)?1:-1)*cls.rel.getY())-(pos.getY()+((yrn)?1:-1)*rel.getY());
      //distancia real entre este colisionador y el otro (cls)
      float ds=sqrt(dx*dx+dy*dy);
      //se determina por la suma de radios contra la distancia entre objetos
      c=(ds<(rad+cls.rad));
    }
    return c;
  }
  
  //devuelve el tipo de colisión, 
  int getColisionType(){
    return type;
  }
  
  //conmuta el estado de activo
  void toggleActive(){
    active=!active;
  }
  
  //activa el colisionador
  void activate(){
    active=true;
  }
  
  //deasctiva el colisionador
  void deactivate(){
    active=false;
  }
  
  //grafica el área de colisión, círculo rojo si está inactivo y verde en caso
  //contrario
  void drawAreaColision(){
    ellipseMode(CENTER);
    fill(getColColor(false));
    if(active)
      stroke(getColColor(true));
    else
      stroke(0,0,0);
    circle(pos.getX()+((xrn)?1:-1)*rel.getX(),pos.getY()+((yrn)?1:-1)*rel.getY(),rad*2);
  }
  
  color getColColor(boolean t){
    color c=0;
    if(t)
      switch(type){
        case COLBODY: c=color(0,0,172); break;
        case COLATCK: c=color(172,0,0); break;
        case COLDEFN: c=color(0,172,0); break;
        case COLHEAL: c=color(0,172,172); break;
        case COLVIEW: c=color(58,236,230); break;
      }
    else
      switch(type){
        case COLBODY: c=color(0,0,172,128); break;
        case COLATCK: c=color(172,0,0,128); break;
        case COLDEFN: c=color(0,172,0,128); break;
        case COLHEAL: c=color(0,172,172,128); break;
        case COLVIEW: c=color(58,236,230,128); break;
      }
    return c;
  }
  
  String toString(){
    return "("+pos.getX()+","+pos.getY()+")";
  }
  
  void setXRN(int d){
    xrn=d==RIGHT;
  }
  
  void setYRN(int d){
    yrn=d==DOWN;
  }
}
