import 'package:apiintegration/BO/AvengerBO/AvengerBO.dart';
import 'package:apiintegration/Helpers/Mixins/PopupMixin.dart';
import 'package:apiintegration/Helpers/Mixins/TextfieldMixin.dart';
import 'package:apiintegration/Helpers/Utitilites/Utilities.dart';
import 'package:apiintegration/Pages/HomeScreen/HomeScreenModel.dart';

import '../../Helpers/AppNavigations/NavigationMixin.dart';

// Create a HomeScreenVM which extends HomeScreenModel
class HomeScreenVM extends HomeScreenModel {
  /* Create a method named fetchAllAvengers() to get all the values from Api and make it as async */

  Future<void> fetchAllAvengers() async {
    // Declare a try block
    try {
      // Invoke the setIsAvengersLoading and pass the parameter as true
      setIsAvengersLoading(isLoading: true);

      // Declare a variable data with type as var and invoke the getAllAvengers() against the variable
      var data = await avengerServiceInstance.getAllAvengers();

      // Invoke the setAllAvengers and pass the parameter as
      setAllAvengers(newAvengers: data.content ?? []);

      // Invoke the setIsAvengersLoading and pass the parameter as false
      setIsAvengersLoading(isLoading: false);
    }

    //Declare the catch block to handle exception
    catch (e) {
      // Print the exception using writeExceptionData()
      e.writeExceptionData();
    }
  }

  /* Create a method named createAvengers() with required paramter name to create a new avenger in Api */
  Future<void> createAvengers({required String name}) async {
    // Declare the try block
    try {

        // Invoke the closepopups()
        closepopups();

        setIsAvengersLoading(isLoading: true);

        // Create a instance of AvengerBO and pass the value to the constructor AvengerBO as id and name
        AvengerBO newavenger = AvengerBO(id: null, name: name);

        // Invoke the createNewAvenger() and make it as await, then pass the parameter newavenger
        await avengerServiceInstance.createNewAvenger(nameOfHero: newavenger);

        // Invoke the fetchAllAvengers() and make it as await
        await fetchAllAvengers();
    }
    // Declare the catch block with paramter e
    catch (e) {
      // Print the exception using writeExceptionData()
      e.writeExceptionData();
    }
  }

  /* Create a method named editAvenger() with required paramter index and values to edit a avenger in Api */
  Future<void> editAvenger({required int index, required String values}) async {
    // Declare the try block
    try {
     
       // Invoke the closepopups()
        closepopups();

        setIsAvengersLoading(isLoading: true);

        // Create a instance of AvengerBO and pass the value to the constructor AvengerBO as id and name
        AvengerBO editavenger =
            AvengerBO(id: allAvengers[index].id, name: values);

        // Invoke the editNameOfAvenger() and make it as await, then pass the parameter editavenger
        await avengerServiceInstance.editNameOfAvenger(hero: editavenger);

        // Invoke the fetchAllAvengers() and make it as await
        await fetchAllAvengers();
    }
    // Declare the catch block with paramter e
    catch (e) {
      // Print the exception using writeExceptionData()
      e.writeExceptionData();
    }
  }

  /* Create a method named deleteAvenger() with required paramter index to delete a avenger in Api */
  Future<void> deleteAvenger({required int indexx}) async {
    // Declare the try block
    try {
      // Create a instance of AvengerBO and pass the value to the constructor AvengerBO as id and name
      AvengerBO deleteavenger =
          AvengerBO(id: allAvengers[indexx].id, name: 'null');

      // Invoke the deleteHeroFromAvenger() and make it as await, then pass the parameter deleteavenger
      await avengerServiceInstance.deleteHeroFromAvenger(hero: deleteavenger);

      // Invoke the fetchAllAvengers() and make it as await
      await fetchAllAvengers();
    }
    // Declare the catch block with paramter e
    catch (e) {
      // Print the exception using writeExceptionData()
      e.writeExceptionData();
    }
  }

  /* Create a method named editpopdisplay() with required paramter indexs to display the pop for edit action avenger Api */
  void editpopdisplay({required int indexs}) {
    // Declare the try block
    try {
      // Invoke the showpopcontroller() and pass the constructor with value
      showpopcontroller(event: Popup(data: [indexs, "editavengerdialog"]));
    }
    // Declare the catch block with paramter e
    catch (e) {
      // Print the exception using writeExceptionData()
      e.writeExceptionData();
    }
  }


  /* Create a method named popdisplayCreate() to display the pop for create avenger action avenger Api */
 
  void popdisplayCreate() {
    // Declare the try block
    try {
      // Invoke the showpopcontroller() and pass the value to the constructor
      showpopcontroller(event: Popup(data: [null, "showavengerdialog"]));
    }
    // Declare the catch block with paramter e
    catch (e) {
      // Print the exception using writeExceptionData()
      e.writeExceptionData();
    }
  }


  /* Create a method named closepopups() to close the pop */
  void closepopups() {
    // Declare the varaible actions with datatype as bool and assign the value as true
    bool actions = true;

    // Check for the check actions is true
    if (actions) {
      // Assign the value false to the variable actionstatus
      actions = false;

      // Using navigationstream.add() to  the event and pass the NavigatorPop()
      navigationStream.add(NavigatorPop());
    }
  }

  /* Create a method named textsend() with required parameter value for onchange event in edittext form field */
  void textsend({required String value}) {
    // Declare the try block
    try {
      // Assign the parameter value to the textvalue
      textvalue = value;
      addTextController(event: Textfield(data: textvalue));
    }
    // Declare the catch block with paramter e
    catch (e) {
      // Print the exception using writeExceptionData()
      e.writeExceptionData();
    }
  }


}
