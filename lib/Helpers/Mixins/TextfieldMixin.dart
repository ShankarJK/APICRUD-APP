import 'dart:async';

// Create a abstract class Itextfield
abstract class Itextfield{

}

// Create a class Popup which extends Itextfield
class Textfield extends Itextfield{

  // Declare a variable named data with datatype as string 
   String data;

  /* Declare a constructor named Popup with required paramter as this.data  */
  
  Textfield ({required this.data});
}

// Create a mixin named PopupMixin
mixin TextfieldMixin{

  // Create a streamcontroller named popupcontroller and set the type as Itextfield
  StreamController <Textfield?> usertextcontroller = StreamController <Textfield?>();

  /* Declare a methods showpopcontroller with required paramter  event*/
  void addTextController({required Textfield event}){
  
    // Using add(), add the event into stream
   usertextcontroller.add(event);
  }

  /* Declare a method closepopup() */
  void closeTextController() async{
    // Use close() to close the popupcontroller stream and make it as await
   await usertextcontroller.close();
  }
  
}