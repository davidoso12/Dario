//Módulo TopScores 
//elaborado por: Osorio Gutierrez David
//fecha de creación: 29 de noviembre de 2022
//fecha de ultima modificación: 2 de diciembre de 2022
//comentario:
class TopScores{
  String file[];    //archivo de puntajes máximos
  String place[];   //lugares obtenidos
  String name[];    //nombres de jugadores
  String time[];    //tiempos obtenidos
  int top;          //número de puntajes guardados
  Punto2D p;        //posición de la tabla
  int fy;           //espacio entre posiciones
  PImage imgbck;    //fondo para los textos
  color base;       //color inicial de animación "cromática"
  color tope;       //color final de animación "cromática"
  color act;        //color actual de animación "cromática"
  float inc;        //incremento del valor de color
  boolean dir;      //indica si se va del color inicial al final o viceversa
    
  //Constructor: inicia los elementos 
  TopScores(){
    imgbck=loadImage("sprite/fondos/mapa.png");
    file=loadStrings("topscores.dat");
    p=new Punto2D(400,200);
    fy=35;
    top=cf.topsc;
    place=new String[top];
    name=new String[top+1];
    time=new String[top+1];
    base=color(255,0,0);
    tope=color(0,0,255);
    inc=cf.clinc;
    dir=true;
    loadData();
  }
  
  //carga los registros de puntaje
  void loadData(){
    for(int i=0;i<top;i++){
      place[i]=split(file[i],";")[0];
      name[i]=split(file[i],";")[1];
      time[i]=split(file[i],";")[2];
    }
  }
  
  //Guarda los marcadores, haya o no cambios
  void saveData(){
    String newfile;
    newfile="";
    //aquí se determina si el puntaje de la partida terminada se incluye dentro
    //de los puntajes tope
    sortData();  
    //se guardan los más altos solamente
    for(int i=0;i<top;i++)
      newfile=newfile+place[i]+";"+name[i]+";"+time[i]+"|";
    file=split(newfile,'|');
    saveStrings("data/topscores.dat",file);
  }
  
  //Hace un ordenamiento de una pasada de intercambio simple
  void sortData(){
    int i=top; //se comienza como la última posición, pero fuera del tope
    //mientras vaya superando al puntaje previo o llegue al final
    while(i>0 && convTime(time[i])>convTime(time[i-1])){
      String t; //temporal para los intercambios de valores
      //intercambio de nombre
      t=name[i-1]; name[i-1]=name[i]; name[i]=t;
      //intercambio de tiempos
      t=time[i-1]; time[i-1]=time[i]; time[i]=t;
      i--;
    }
  }
  
  int convTime(String s){
    return int(split (s,':')[0])*60+int(split(s,':')[1]);
  }
  
  //grafica la tabla de puntajes tope
  void displayData(){
    imageMode(CENTER);
    tint(255,255);
    image(imgbck,640,360);
    noTint();
    //encabezados de la tabla
    textSize(36);
    text("#",p.getX(),p.getY());
    text(idi.getMensaje(32),p.getX()+100,p.getY());
    text(idi.getMensaje(33),p.getX()+300,p.getY());
    textSize(32);
    fill(230);
    //contenido de la tabla
    for(int i=0;i<top;i++){
      act=lerpColor(base,tope,inc);
      inc+=(dir)?cf.clinc:-cf.clinc;
      if(inc>1.0||inc<0.0) dir=!dir;
      fill(act);
      text(place[i],p.getX(),p.getY()+50+i*fy);
      text(name[i],p.getX()+100,p.getY()+50+i*fy);
      text(time[i],p.getX()+300,p.getY()+50+i*fy);
    }
    fill(255);
  }
  
  void addTime(String td){
    name[top]=cf.plynm;
    time[top]=split(td,";")[0];
  }
  
}
