//Proyecto Cuerbeat 'Em Up
//Elaborado por: Rubén Dario Hernández Mendo
//Fecha de creación: 6 de septiembre de 2023 
//Fecha de última modificacion: 2 de diciembre de 2023
//Descripción: Cuerbeat 'Em Up es un juego donde controlaremos
// un personaje, quien resolverá un par de escenas enfrentando
// enemigos con golpes y patadas.
import ddf.minim.*;
import processing.video.*;

final int IDESP=0;
final int IDENG=1;
final int PANTPRIN=0;
final int PANTGAME=1;
final int PANTLOAD=2;
final int PANTCONF=3;
final int PANTCRED=4;
final int PANTTOPS=5;
final int PANTPAUS=6;
final int PANTENDG=7;
final int PANTPLUS=8;
final int PANTPAUSES=9;
final int PANTINTER=10;
final int PANTGAMEN=11;
final int PANMWALK=0;
final int PANMDEAD=1;
final int PANMDEFN=2;
final int PANMHITD=3;
final int PANMPNCH=4;
final int PANMKICK=5;
final int PANMJUMP=6;
final int PANMFALL=7;
final int COLATCK=0;
final int COLBODY=1;
final int COLDEFN=2;
final int COLHEAL=3;
final int COLVIEW=4;
final int DFCEA=24;
final int DFCNR=25;
final int DFCHD=26;
final int CNDPAT=0;
final int CNDATK=1;
final int STOP=5;
final boolean DMGP=true;
final boolean DMGK=false;
PImage icon;
PFont typtitle;
GameControl gc;
Idiomas idi;
ConfigFiles cf;
Bitacora bit;
TopScores ts;
boolean resetgame;
boolean win;

Minim audio;
//AudioOutput audout;
AudioPlayer mscintro;
AudioPlayer mscstage;
AudioPlayer mscendd;
AudioPlayer mscendv;
AudioSample sfxclic;
AudioSample sfxdrink;
AudioSample sfxpunch;
AudioSample sfxkick;
AudioPlayer sfxstep;
AudioSample sfxscream;
AudioSample sfxedeath;
AudioSample sfxdeath;
AudioSample sfxbird[];
AudioSample voistart;
AudioSample voiseeu;
Movie mvcred;

void setup(){
  icon=loadImage("sprite/misc/icon.png");
  size(1280,720);
  windowMove(100,100);
  windowTitle("Proyecto Dario,Equipo 8");
  surface.setIcon(icon);
  typtitle=createFont("Arial",32);
  textFont(typtitle);
  cf=new ConfigFiles();
  idi=new Idiomas(cf.lang,cf.ns);
  gc=new GameControl();
  bit=new Bitacora(cf.logstate);
  resetgame=false;
  audio=new Minim(this);
  thread("loadAudio");
}

void draw(){
  gc.display();
}

void mouseReleased(){
  gc.mouseControl(mouseX,mouseY,mouseButton);
}


//Controla las teclas para el movimiento del personaje en cada pantalla


void keyReleased(){
  gc.keyRelControl(key);
  gc.keyRelControlPantGamen(key);
  gc.keyRelControlPantPlus(key);
}

void keyPressed(){
  gc.keyControl(key);
  gc.keyControlPantGamen(key);
  gc.keyControlPantPlus(key);
}

void music(){
  if(!gc.getMusicStatus())
    gc.musicManager(true);
}

void loadAudio(){
  gc.pantload.msg=7;
  sfxclic=audio.loadSample("sound/sfx/click.mp3");
  sfxclic.setGain(cf.sfxgain);
  sfxdrink=audio.loadSample("sound/sfx/drink.mp3");
  sfxdrink.setGain(cf.sfxgain);
  sfxkick=audio.loadSample("sound/sfx/kick.mp3");
  sfxkick.setGain(cf.sfxgain);
  sfxpunch=audio.loadSample("sound/sfx/punch.mp3");
  sfxpunch.setGain(cf.sfxgain);
  sfxstep=audio.loadFile("sound/sfx/step.mp3");
  sfxstep.setGain(cf.sfxgain);
  sfxscream=audio.loadSample("sound/sfx/scream.mp3");
  sfxscream.setGain(cf.sfxgain);
  sfxedeath=audio.loadSample("sound/sfx/enemydeath.mp3");
  sfxedeath.setGain(cf.sfxgain);
  sfxdeath=audio.loadSample("sound/sfx/death.mp3");
  sfxdeath.setGain(cf.sfxgain);
  sfxbird=new AudioSample[8];
  for(int i=0;i<8;i++){
    sfxbird[i]=audio.loadSample("sound/sfx/bird"+i+".mp3");
    sfxbird[i].setGain(cf.sfxgain);
  }
  cargaDialogos();
  gc.pantload.msg=8;
  mscintro=audio.loadFile("sound/music/intro.mp3");
  mscintro.setGain(cf.mscgain);
  mscintro.setBalance(0.0);
  mscstage=audio.loadFile("sound/music/stage.mp3");
  mscstage.setBalance(0.0);
  mscstage.setGain(cf.mscgain);
  mscendd=audio.loadFile("sound/music/defeat.mp3");
  mscendd.setGain(cf.mscgain);
  mscendv=audio.loadFile("sound/music/victory.mp3");
  mscendv.setGain(cf.mscgain);
  gc.pantload.msg=30;
  mvcred=new Movie(this,"video/creditos720.mp4");
  gc.pantload.msg=9;
  gc.pantload.loading=false;
}

void cargaDialogos(){
  voistart=audio.loadSample(idi.getMensaje(28));
  voistart.setGain(cf.voigain);
  voiseeu=audio.loadSample(idi.getMensaje(37));
  voiseeu.setGain(cf.voigain);
}

void exit(){
  bit.cierraBitacora();
  super.exit();
}

void movieEvent(Movie m){
  m.read();
}
