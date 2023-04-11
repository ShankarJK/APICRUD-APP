import 'dart:async';

// Create a abstract class Ipopup
abstract class Ipopup{

}

// Create a class Popup which extends Ipopup
class Popup extends Ipopup{

  // Declare a variable named data with datatype as string 
  List<dynamic> data;

  /* Declare a constructor named Popup with required paramter as this.data  */
  Popup ({required this.data});
}

// Create a mixin named PopupMixin
mixin PopupMixin{

  // Create a streamcontroller named popupcontroller and set the type as Ipopup
  StreamController <Ipopup> popupcontroller = StreamController<Ipopup>();

  //StreamController <Ipopup> editpopupcontroller = StreamController<Ipopup>();

  /* Declare a methods showpopcontroller with required paramter  event*/
  void showpopcontroller({required Ipopup event}){
    // Using add(), add the event into stream
   popupcontroller.add(event);
  }

  /* Declare a method closepopup() */
  void closepopup() async{
    // Use close() to close the popupcontroller stream and make it as await
   await popupcontroller.close();
  }
  
}