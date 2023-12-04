//Módulo Idiomas
//Elaborado por: Ruben Dario Hernández Mendo
//Fecha de Creación:20 de septiembre de 2023
//fecha de ultima modificación:25 de septiembre de 2023
//Descripción: El módulo Idiomas controlará el despliegue de
// mensajes en dos idiomas, español e inglés.

class Idiomas{
  String idiomas[][];  //contiene los mensajes de los dos idiomas
  String file[];       //contiene el archivo de idioma a copiar
  int idiact;          //idioma activo    
  int nm;              //numero de mensajes en total
  
  Idiomas(int i,int n){
    idiact=i;
    nm=n;
    idiomas=new String[nm][2];
    cargaIdioma(IDESP);
    cargaIdioma(IDENG);
  }
  
  void cargaIdioma(int i){
    int n;
    file=loadStrings((i==IDESP)?"esp.lang":"eng.lang");
    for(n=0;n<nm;n++)
      idiomas[n][i]=split(file[n],"=")[1];
  }
  
  void setIdioma(int i){
    idiact=i;
  }
  
  int getIdioma(){
    return idiact;
  }
  
  String getMensaje(int i){
    return idiomas[i][idiact];
  }
}
