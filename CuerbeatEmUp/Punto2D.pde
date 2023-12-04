//Módulo Punto2D
//elaborado por: Rubén Dario Hernandez Mendo
//fecha de creación: 4 de octubre de 2023
//fecha de ultima modificación: 15 de noviembre de 2023
//comentario: se implementa una clase para par de coordenadas 2D
class Punto2D{
  int x;  //coordenada horizontal
  int y;  //coordenada vertical
  
  //Constructor: usa valores directos de cada coordenada
  Punto2D(int x,int y){
    this.x=x;
    this.y=y;
  }
  
  //Constructor: recibe otro punto para "copiarse"
  Punto2D(Punto2D p){
    x=p.getX();
    y=p.getY();
  }
  
  //devuelve coordenada x
  int getX(){
    return x;
  }
  
  //devuelve coordenada y
  int getY(){
    return y;
  }
  
  //establece coordenada x
  void setX(int x){
    this.x=x;
  }
  
  //establece coordenada y
  void setY(int y){
    this.y=y;
  }
  
  void setPunto(Punto2D p){
    x=p.getX();
    y=p.getY();
  }
  
  //mueve el par ordenado, usando valores sueltos
  void moverP(int dx,int dy){
    x+=dx;
    y+=dy;
  }
  
  //mueve el par ordenado, con otro punto (uso para movimiento vectorizado)
  void moverP(Punto2D p){
    x+=p.getX();
    y+=p.getY();
  }
}
