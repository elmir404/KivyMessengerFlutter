class Errors{
  static String goster(String errorCode){
       switch(errorCode){
         case 'email-already-in-use':
           return "Bu email istifade olunur,basqa email daxil edin.";
         case 'user-not-found':
           return "Bu istifadeci qeydiyyardan kecmeyib";
         default:
           return "Bir xeta bash verdi";
       }
  }
}