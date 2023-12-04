//Módulo Personaje
//elaborado por: Rubén Dario Hernandez Mendo
//fecha de creación: 8 de octubre de 2023
//fecha de ultima modificación: 2 de diciembre de 2023
//comentario: se implementa la clase Personaje con el propósito de organizar los
//datos y procesos inherentes al mismo
class Personaje{
  Punto2D pos;
  Punto2D sze;
  Punto2D undo;
  boolean movedx;
  boolean rb;
  boolean onatck;
  boolean gameover;
  boolean onscroll;
  boolean onmotion;
  boolean onkick;
  boolean onpnch;
  boolean onhit;
  int view;
  LifeBar lb;
  Colisionador clbody;
  Colisionador clpnch;
  Colisionador clkick;
  Colisionador cldefn;
  Colisionador clhead;
  Temporizador it;
  Temporizador ht;
  AnimationStructure anistr;
    
  Personaje(int x,int y,int w,int h){
    pos=new Punto2D(x,y);
    sze=new Punto2D(w,h);
    undo=new Punto2D(0,0);
    movedx=false;
    rb=false;
    onatck=false;
    gameover=false;
    onscroll=false;
    onhit=onmotion=false;
     
      PImage decorationImg = loadImage("sprite/misc/barra-f.png");
    PImage backgroundImg = loadImage("sprite/misc/boton.png");
  lb = new LifeBar(cf.maxhp, new Punto2D(210, 50), new Punto2D(300, 40), color(233, 255, 0), decorationImg, backgroundImg);


    clbody=new Colisionador(pos,new Punto2D(0,0),cf.pcbs,COLBODY);
    clpnch=new Colisionador(pos,new Punto2D(cf.prpx,cf.prpy),cf.pcps,COLATCK);
    clkick=new Colisionador(pos,new Punto2D(cf.prkx,cf.prky),cf.pcks,COLATCK);
    cldefn=new Colisionador(pos,new Punto2D(0,0),cf.pcds,COLDEFN);
    clhead=new Colisionador(pos,new Punto2D(0,cf.prhy),cf.pchs,COLBODY);
    clpnch.toggleActive();
    clkick.toggleActive();
    onkick=onpnch=false;
    it=new Temporizador(cf.itime);
    ht=new Temporizador(cf.htime);
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
    view=RIGHT;                    
  }
  
  void display(){
    if(view==RIGHT)
      anistr.display(relativeX(),sze);
    else
      anistr.flipXDisplay(relativeX(),sze);
    clpnch.setXRN(view); 
    clkick.setXRN(view); 
    lb.display();
    if(onatck){
      if(onkick && !onhit) clkick.active=isTriggerSprite();
      if(onpnch && !onhit) clpnch.active=isTriggerSprite();
    }
    if(onatck && anistr.getActiveSpriteSet().endot){
      onatck=onhit=onpnch=onkick=false;
      anistr.setActiveSpriteSet(PANMWALK);
      anistr.setIdle(true);
    }  
    if(cf.drwc){  
      clbody.drawAreaColision();
      clpnch.drawAreaColision();
      clkick.drawAreaColision();
      cldefn.drawAreaColision();
      clhead.drawAreaColision();
    }
    checkTemp(it);
    checkTemp(ht); 
  }
  
  void checkTemp(Temporizador t){
    if(t.isActive())
      t.coolingDown();
    if(t.isOff()){
      t.deactivate();
      clbody.activate();
    }  
  }
  
  Punto2D relativeX(){
    onscroll=(pos.getX()>640 && !rb) && view==RIGHT;
    return (onscroll?new Punto2D(640,pos.getY()):pos);
  }
  
  void moverColisionadores(int x,int y){
    clbody.moverCol(x,y);
    clpnch.moverCol(x,y);
    clkick.moverCol(x,y);
    cldefn.moverCol(x,y);
    clhead.moverCol(x,y);
  }
  
  void moverColisionadores(Punto2D p){
    clbody.moverCol(p);
    clpnch.moverCol(p);
    clkick.moverCol(p);
    cldefn.moverCol(p);
    clhead.moverCol(p);
  }
  
  void moverPer(int x,int y){
    pos.moverP(x,y);
    moverColisionadores(x,y);
  }
  
  void reachedBorder(){
   rb=true;
  }
  
  void keyControl(char k){
    if(!onatck){
      if(!anistr.isIdle())
        anistr.toggleActiveAnimation();
    //if(!onatck)  
      switch(k){
        //caminar arriba          
        case 'w':
        case 'W': if(pos.getY()>250){
                    moverPer(0,-cf.spdy);
                    startLoop(sfxstep);
                    undo.setPunto(new Punto2D(0,cf.spdy));
                    cambiaAnimacion(PANMWALK,false,false);
                  }  
                  break;
        //caminar izquierda          
        case 'a':
        case 'A': view=LEFT;
                  if(pos.getX()>50){
                    onmotion=true;
                    moverPer(-cf.spdx,0);
                    startLoop(sfxstep);
                    undo.setPunto(new Punto2D(cf.spdx,0));
                    cambiaAnimacion(PANMWALK,false,false);
                  }  
                  break;
        //caminar abajo          
        case 's':
        case 'S': if(pos.getY()<640){
                    moverPer(0,cf.spdy);
                    startLoop(sfxstep);
                    undo.setPunto(new Punto2D(0,-cf.spdy));
                    cambiaAnimacion(PANMWALK,false,false);
                  }
                  break;
        //caminar derecha          
        case 'd':
        case 'D': view=RIGHT;
                  if(pos.getX()<1230){
                    if(pos.getX()<=640 || rb){
                      moverPer(cf.spdx,0);
                      
                    }
                    onmotion=true;
                    movedx=true;
                    startLoop(sfxstep);
                    undo.setPunto(new Punto2D(-cf.spdx,0));
                    cambiaAnimacion(PANMWALK,false,false);
                  }  
                  break;
      }
    }  
  }
  
  void keyRelControl(char k){
    if(!onatck)
      switch(k){
        //golpe
        case 'q':
        case 'Q': cambiaAnimacion(PANMPNCH,true,true);
                  sfxpunch.trigger();
                  onpnch=true;
                  break;
        //patada
        case 'e':
        case 'E': cambiaAnimacion(PANMKICK,true,true);
                  sfxkick.trigger();
                  onkick=true;
                  break;
        //caminar arriba
        case 'w':
        case 'W': anistr.setIdle(true);
                  sfxstep.pause();
                  break;
        //caminar izquierda          
        case 'a':
        case 'A': anistr.setIdle(true);
                  onmotion=false;
                  sfxstep.pause();
                  break;
        //caminar abajo          
        case 's':
        case 'S': anistr.setIdle(true);
                  sfxstep.pause();
                  break;
        //caminar derecha          
        case 'd':
        case 'D': anistr.setIdle(true);
                  onmotion=false;
                  movedx=false;
                  sfxstep.pause();
                  break;
        //salto          
        case ' ': cambiaAnimacion(PANMJUMP,true,true);
                  break;
        case '1': herir(DMGP);
                  break; 
        case '2': herir(DMGK);
                  break;           
      }
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
    boolean h=lb.injure(dagnoRecibido(kp));
    if(h){
      sfxdeath.trigger();
      anistr.setActiveSpriteSet(PANMDEAD);
      anistr.getActiveSpriteSet().activateOneTime();
      anistr.setIdle(false);  
    }
    return h;
  }
  
  void curar(){
    lb.heal(cf.heal);
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
  
  boolean isGameOver(){
    return gameover;
  }
  
  boolean getOnScroll(){
    return onscroll;
  }
  
  boolean getOnMotion(){
    return onmotion;
  }
  
  boolean isTriggerSprite(){
    return anistr.isTriggerSprite();
  }
  
  int dagnoRecibido(boolean kp){
    return ((kp)?cf.prpd:cf.prkd)+diffEffect();
  }
  
  int diffEffect(){
    return ((cf.dif==DFCNR)?0:(cf.dif==DFCEA)?-cf.injure:cf.injure);
  }
  
  void startLoop(AudioPlayer ap){
    if(!ap.isLooping()||!ap.isPlaying())ap.loop();
 } 
}
