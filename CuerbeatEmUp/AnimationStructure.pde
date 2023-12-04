//Modulo AnimationStructure
//elaborado por: Osorio Gutierrez David
//fecha de creación: 6 de octubre de 2023
//fecha de ultima modificación: 30 de noviembre de 2023
//comentario: Es el objeto que concentra varios sets de animación básica para
//construir la animación de elementos de animación de mayor complejidad.
class AnimationStructure{
  ArrayList <SpriteSet> seqs;  //conjunto de sets de animación básicos
  int activesprset;            //indica el set de sprites activo
  boolean activeanimation;     //indica si la animación está activa
  boolean idle;                //indica si la animación está en pausa
  
  //contstructor
  AnimationStructure(){
    seqs=new ArrayList <SpriteSet>();
    activesprset=0;
    activeanimation=true;
    idle=true;
  }
  
  //permite agregar un set de sprites a la estructura de animación.
  void addSpriteSet(SpriteSet ss){
    seqs.add(ss);
  }
  
  //grafica la animación a partir del SpriteSet activo
  void display(int x,int y,int w,int h){
    if(activeanimation && seqs.size()>0){
      seqs.get(activesprset).display(x,y,w,h);
    }
  }
  
  void display(Punto2D p,Punto2D s){
    if(activeanimation && seqs.size()>0){
      seqs.get(activesprset).display(p,s);
    }
  }
  
  void flipXDisplay(int x,int y,int w,int h){
    if(activeanimation && seqs.size()>0){
      seqs.get(activesprset).flipXDisplay(x,y,w,h);
    }
  }
  
  void flipXDisplay(Punto2D p,Punto2D s){
    if(activeanimation && seqs.size()>0){
      seqs.get(activesprset).flipXDisplay(p,s);
    }
  }
  
  void flipYDisplay(int x,int y,int w,int h){
    if(activeanimation && seqs.size()>0){
      seqs.get(activesprset).flipYDisplay(x,y,w,h);
    }
  }
  
  void flipYDisplay(Punto2D p,Punto2D s){
    if(activeanimation && seqs.size()>0){
      seqs.get(activesprset).flipYDisplay(p,s);
    }
  }
  
  //permite obtener un Set de Sprites específico
  PImage[]getSprites(){
    return seqs.get(activesprset).sprt;
  }
  
  //selecciona el SpriteSet activo
  void setActiveSpriteSet(int n){
    activesprset=n;
  }
  
  SpriteSet getActiveSpriteSet(){
    return seqs.get(activesprset);
  }
  
  //avanza al siguiente SpriteSet, ideal para animaciones en secuencia ascendente
  void nextSpriteSet(){
    if(activesprset<seqs.size()-1)
      activesprset++;
    else
      activesprset=0;
  }
  
  //avanza al siguiente SpriteSet, ideal para animaciones en secuencia descendente
  void prevSpriteSet(){
    if(activesprset>0)
      activesprset--;
    else
      activesprset=seqs.size()-1;
  }
  
  //conmuta el estado de animación activa
  void toggleActiveAnimation(){
    seqs.get(activesprset).toggleAnimacion();
  } 
  
  boolean isIdle(){
    return idle;
  }
  
  void setIdle(boolean i){
    idle=i;
    seqs.get(activesprset).onan=!idle;
    if(idle) seqs.get(activesprset).spr=0;
  }
  
  void toggleIdle(){
    idle=!idle;
  }
  
  boolean isTriggerSprite(){
    return seqs.get(activesprset).isTriggerSprite();
  }
}
