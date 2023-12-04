//Módulo Enemigo
//elaborado por: Rubén Dario Hernandez Mendo
//fecha de creación: 26 de noviembre de 2023
//fecha de ultima modificación: 2 de diciembre de 2023
//comentario: se implementa la clase Enemigo con el propósito de organizar los
//datos y procesos inherentes al mismo
class Enemigo{
  Punto2D pos;
  Punto2D sze;
  Punto2D undo;
  Punto2D perpos;
  Punto2D moveto;
  boolean movedx;
  boolean rb;
  boolean onatck;
  boolean onscroll;
  boolean onmotion;
  boolean onkick;
  boolean onpnch;
  boolean onhit;
  int view;
  int dir;
  int conduct;
  LifeBar lb;
  Colisionador clbody;
  Colisionador clpnch;
  Colisionador clkick;
  Colisionador clview;
  Colisionador clhead;
  Temporizador it;
  AnimationStructure anistr;
  
    
  Enemigo(int x,int y,int w,int h){
    pos=new Punto2D(x,y);
    sze=new Punto2D(w,h);
    undo=new Punto2D(0,0);
    perpos=new Punto2D(pos);
    movedx=false;
    rb=false;
    onatck=false;
    onscroll=false;
    onhit=onmotion=false;
    conduct=CNDPAT;
    dir=DOWN;
    PImage decorationImg = loadImage("sprite/misc/barra-f.png");
    PImage backgroundImg = loadImage("sprite/misc/boton.png");  // Reemplaza con la ruta correcta
  lb = new LifeBar(cf.emaxhp, new Punto2D(1170, 100), new Punto2D(100, 40), color(0, 150, 0), decorationImg, backgroundImg);



    clbody=new Colisionador(pos,new Punto2D(0,0),cf.pcbs,COLBODY);
    clpnch=new Colisionador(pos,new Punto2D(cf.prpx,cf.prpy),cf.pcps,COLATCK);
    clkick=new Colisionador(pos,new Punto2D(cf.prkx,cf.prky),cf.pcks,COLATCK);
    clview=new Colisionador(pos,new Punto2D(0,0),cf.encv,COLVIEW);
    clhead=new Colisionador(pos,new Punto2D(0,cf.prhy),cf.pchs,COLBODY);
    clpnch.toggleActive();
    clkick.toggleActive();
    onkick=onpnch=false;
    it=new Temporizador(cf.itime);
    anistr=new AnimationStructure();
   anistr.addSpriteSet(new SpriteSet("sprite/sprites/animation/prota/pro_walk/",
                        "prota_camina",8,".png",7,false,0));
    anistr.addSpriteSet(new SpriteSet("sprite/sprites/animation/prota/pro_dead/",
                        "dead_",5,".png",6,false,0));
    anistr.addSpriteSet(new SpriteSet("sprite/sprites/animation/prota/pro_defense/",
                        "idle",5,".png",15,false,0));
    anistr.addSpriteSet(new SpriteSet("sprite/sprites/animation/prota/pro_hit/",
                        "attack_",3,".png",18,false,0));
    anistr.addSpriteSet(new SpriteSet("sprite/sprites/animation/prota/pro_punch/",
                        "attack_",6,".png",cf.pp,false,0));
    anistr.addSpriteSet(new SpriteSet("sprite/sprites/animation/prota/pro_kick/",
                        "attack_",3,".png",cf.pk,false,0));
    anistr.addSpriteSet(new SpriteSet("sprite/sprites/animation/prota/pro_jump/",
                        "jump_",8,".png",7,false,0));
    anistr.addSpriteSet(new SpriteSet("sprite/sprites/animation/prota/pro_fall/",
                        "fall_",3,".png",7,false,0));
    view=LEFT;                                
  }
  
  void display(boolean os,boolean om){
    if(view==RIGHT)
      anistr.display(pos,sze);
    else
      anistr.flipXDisplay(pos,sze);
    clpnch.setXRN(view); 
    clkick.setXRN(view); 
    lb.display();
    //ajuste de posición si el personaje mueve el escenario
    if(os && om)
      moverEne(-cf.spdx,0);
    if(onatck){
      if(onkick && !onhit) clkick.active=isTriggerSprite();
      if(onpnch && !onhit) clpnch.active=isTriggerSprite();
    }  
    if(onatck && anistr.getActiveSpriteSet().endot){
      onatck=onhit=onpnch=onkick=false;
      anistr.setActiveSpriteSet(PANMWALK);
      anistr.setIdle(true);
    }  
    if(anistr.getActiveSpriteSet().endot && dir==STOP){
      gc.pantendgame.cargaFinal(true);
      win=true;
      gc.musicManager(false);
      gc.setPantAct(PANTENDG);
    }  
    if(cf.drwc){  
      clbody.drawAreaColision();
      clpnch.drawAreaColision();
      clkick.drawAreaColision();
      clview.drawAreaColision();
      clhead.drawAreaColision();
    }
    checkTemp(it);
    controlConducta();
  }
  
  void checkTemp(Temporizador t){
    if(t.isActive())
      t.coolingDown();
    if(t.isOff()){
      t.deactivate();
      clbody.activate();
    }  
  }
  
  void moverColisionadores(int x,int y){
    clbody.moverCol(x,y);
    clpnch.moverCol(x,y);
    clkick.moverCol(x,y);
    clview.moverCol(x,y);
    clhead.moverCol(x,y);
  }
  
  void moverColisionadores(Punto2D p){
    clbody.moverCol(p);
    clpnch.moverCol(p);
    clkick.moverCol(p);
    clview.moverCol(p);
    clhead.moverCol(p);
  }
  
  void moverEne(int x,int y){
    pos.moverP(x,y);
    moverColisionadores(x,y);
  }
  
  void moverEne(Punto2D p){
    pos.moverP(p);
    moverColisionadores(p);
  }
  
  void reachedBorder(){
   rb=true;
  }
  
  void controlPatrulla(int d){
    if(!onatck){
      if(!anistr.isIdle())
        anistr.toggleActiveAnimation();
        switch(d){
        //caminar arriba          
          case UP: if(pos.getY()>250){
                      moverEne(0,-cf.espdy);
                      undo.setPunto(new Punto2D(0,cf.espdy));
                      cambiaAnimacion(PANMWALK,false,false);
                   }
                   else
                     dir=DOWN;
                   break;
          //caminar izquierda          
          case LEFT: view=LEFT;
                     if(pos.getX()>50){
                       moverEne(-cf.espdx,0);
                       undo.setPunto(new Punto2D(cf.espdx,0));
                       cambiaAnimacion(PANMWALK,false,false);
                     }  
                     break;
          //caminar abajo          
          case DOWN: if(pos.getY()<640){
                       moverEne(0,cf.espdy);
                       undo.setPunto(new Punto2D(0,-cf.espdy));
                       cambiaAnimacion(PANMWALK,false,false);
                     }
                     else
                       dir=UP;
                     break;
          //caminar derecha          
          case RIGHT: view=RIGHT;
                      if(pos.getX()<1230){
                        moverEne(cf.espdx,0);
                        movedx=true;
                        undo.setPunto(new Punto2D(-cf.espdx,0));
                        cambiaAnimacion(PANMWALK,false,false);
                      }  
                      break;
          //parado
          case STOP:  
                      break;
        }
    }  
  }
  
  void controlAccion(){
    char d=' ';
    if(!onatck)
      d=generaAccion();
      switch(d){
        //golpe
        case 'Q': cambiaAnimacion(PANMPNCH,true,true);
                  onpnch=true;
                  break;
        //patada
        case 'E': cambiaAnimacion(PANMKICK,true,true);
                  onkick=true;
                  break;
        //caminar arriba
        case 'W': if(pos.getY()>250)
                    moverEne(0,-cf.spdy);
                  break;
        //caminar izquierda          
        case 'A': if(pos.getX()>50)
                    moverEne(-cf.spdx,0);
                  onmotion=false;
                  break;
        //caminar abajo          
        case 'S': if(pos.getY()<640)
                    moverEne(0,cf.spdy);
                  break;
        //caminar derecha          
        case 'D': onmotion=false;
                  if(pos.getX()<1230)
                    moverEne(cf.spdx,0);
                  movedx=false;
                  break;
      }
  }
  
  char generaAccion(){
    char c=' ';
    int n=int(random(100));
    int dis;
    if(n<98){
      //calculo de distancia
      dis=getDis(pos,perpos);
      //identificar direccion a mirar
      view=(perpos.getX()<=pos.getX())?LEFT:RIGHT;
      //calculo del vector de aproximación
      c=selectShorter(dis);
    }
    else if(n==98) c='Q';
    else if(n==99) c='E';
    return c;
  }
  
  int getDelta(int v1,int v2){
    return v1-v2;
  }
  
  int getDis(Punto2D p1,Punto2D p2){
    int x=getDelta(p1.getX(),p2.getX());
    int y=getDelta(p1.getY(),p2.getY());
    return int(sqrt(x*x*+y*y));
  }
  
  char selectShorter(int d){
    int[]dist;
    char dr='W';
    dist=new int[4];
    //generamos distancias en cada dirección básica
    dist[0]=Math.abs(d-getDis(pos,new Punto2D(perpos.getX(),perpos.getY()-cf.spdy))); //arriba
    dist[1]=Math.abs(d-getDis(pos,new Punto2D(perpos.getX()-cf.spdx,perpos.getY()))); //izquierda
    dist[2]=Math.abs(d-getDis(pos,new Punto2D(perpos.getX(),perpos.getY()+cf.spdy))); //abajo
    dist[3]=Math.abs(d-getDis(pos,new Punto2D(perpos.getX()+cf.spdx,perpos.getY()))); //derecha
    switch(obtenMinimo(dist)){
      case 0: dr='W'; break;
      case 1: dr=(view==LEFT)?'A':'D'; break;
      case 2: dr='S'; break;
      case 3: dr=(view==RIGHT)?'D':'A'; break;
    }
    return dr;
  }
  
  int obtenMinimo(int[]d){
    int min=0;
    for(int i=1;i<d.length;i++)
      if(d[min]>d[i])
        min=i;
    return min;    
  }
  
  void cambiaAnimacion(int a,boolean ot, boolean oa){
    anistr.setActiveSpriteSet(a);
    if(ot)
      anistr.getActiveSpriteSet().activateOneTime();
    if(oa)  
      onatck=true;
    anistr.setIdle(false);
  }
  
  boolean herir(boolean kp){
    boolean b=lb.injure(dagnoRecibido(kp));
    if(b){
      anistr.setActiveSpriteSet(PANMDEAD);
      dir=STOP;
      conduct=CNDPAT;
      anistr.getActiveSpriteSet().activateOneTime();
      sfxedeath.trigger();
      anistr.setIdle(false);  
    }
    return b;
  }
  
  void undoMotion(){
    pos.moverP(undo);
    moverColisionadores(undo);
  }
  
  boolean hasMovedX(){
    return movedx && pos.getX()>=640;
  }
  
  boolean isDead(){
    return lb.isDead();
  }
  
  boolean getOnScroll(){
    return onscroll;
  }
  
  boolean getOnMotion(){
    return onmotion;
  }
  
  void controlConducta(){
    switch(conduct){
      case CNDPAT: controlPatrulla(dir);
                   break;
      case CNDATK: controlAccion();
                   break;
    }
  }
  
  void setConducta(int c){
    conduct=c;
  }
  
  boolean isTriggerSprite(){
    return anistr.isTriggerSprite();
  }
  
  int dagnoRecibido(boolean kp){
    return ((kp)?cf.prpd:cf.prkd)+diffEffect();
  }
  
  int diffEffect(){
    return ((cf.dif==DFCNR)?0:(cf.dif==DFCEA)?cf.injure:-cf.injure);
  }
  
  void setPerpos(Punto2D p){
    perpos=new Punto2D(p);
  }
}
