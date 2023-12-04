//Modulo Bitácora
//elaborado por: Rubén Dario Hernandez Mendo
//fecha de creación: 20 de noviembre de 2023
//fecha de ultima modificación: 20 de noviembre de 2023
//comentario: Permite generar registros de información del funcionamiento del 
//juego. Recomendable su uso para testing.
class Bitacora{
  PrintWriter output; //"máquina de escribir"
  boolean active;     //guarda o no entradas de bitácora
  
  //constructor, se indica si la bitácora comienza activa
  Bitacora(boolean a){
    active=a;
    if(active){
      String s="data/testing/test ";
      s=s+agregaFechaHora();
      s=s+".log";
      output=createWriter(s);
    }
  }
  
  //permite generar la fecha y hora del sistema
  String agregaFechaHora(){
    return ""+month()+"-"+day()+"-"+year()+" "+hour()+" con "+minute();
  }
  
  //registra un bloque de datos y agrega un salto de línea.
  void agregaDatosLn(String s){
    if(active){
      output.println(s);
      output.flush();
    }  
  }
  
  //permite agregar una cadena directo al archivo de bitácora
  void agregaDatosLn(String []s,int d[]){
    if(active){
      if(s.length==d.length)
        for(int i=0;i<s.length;i++){
          output.println(s[i]+"="+d[i]);
          output.flush();
        }  
      else{
        output.println("Error en datos de bitácora, parámetros no coinciden");
        output.flush(); 
      }
    }
  }
  
  //agrega un registro de información pero continuo, ideal para streams de datos
  void agregaDatos(String s){
    if(active){
      output.print(s);
      output.flush();
    }  
  }
  
  //prende/apaga la bitácora
  void toggleActive(){
    active=!active;
  }
  
  //cierra la bitácora, indicando la hora en que termina la ejecución del juego.
  void cierraBitacora(){
    if(active){
      String s="fin de test ";
      s=s+agregaFechaHora();
      output.println(s);
      output.flush();
      output.close();
    }  
  }
  
  //en esta parte se recomienda implementar los métodos de bitácora específicos
  //a las pruebas que se requieran.
}  
