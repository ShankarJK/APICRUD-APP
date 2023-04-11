import 'package:apiintegration/BO/AvengerBO/AvengerBO.dart';
import 'package:apiintegration/Helpers/Mixins/PopupMixin.dart';
import 'package:apiintegration/Helpers/Mixins/TextfieldMixin.dart';
import 'package:apiintegration/Helpers/Utitilites/Utilities.dart';
import 'package:apiintegration/Pages/HomeScreen/HomeScreenModel.dart';

import '../../Helpers/AppNavigations/NavigationMixin.dart';

class HomeScreenVM extends HomeScreenModel {
  /* Create a method named fetchAllAvengers() to get all the values from Api*/
  Future<void> fetchAllAvengers() async {
    try {
      setIsAvengersLoading(isLoading: true);
      var data = await avengerServiceInstance.getAllAvengers();
      setAllAvengers(newAvengers: data.content ?? []);
      setIsAvengersLoading(isLoading: false);
    } catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method named createAvengers() with required paramter name to create a new avenger in Api */
  Future<void> createAvengers({required String name}) async {
    try {
      if (actionstatus) {
        actionstatus = false;
        AvengerBO newavenger = AvengerBO(id: null, name: name);
        await avengerServiceInstance.createNewAvenger(nameOfHero: newavenger);
        closepopups();
        await fetchAllAvengers();
        actionstatus = true;
      } else {
        await fetchAllAvengers();
      }
    } catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method named editAvenger() with required paramter index and values to edit a avenger in Api */
  Future<void> editAvenger({required int index, required String values}) async {
    try {
      if (actionstatus) {
        actionstatus = false;
        AvengerBO editavenger =
            AvengerBO(id: allAvengers[index].id, name: values);
        await avengerServiceInstance.editNameOfAvenger(hero: editavenger);
        closepopups();
        actionstatus = true;
        await fetchAllAvengers();
      } else {
        await fetchAllAvengers();
      }
    } catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method named deleteAvenger() with required paramter index to delete a avenger in Api */
  Future<void> deleteAvenger({required int indexx}) async {
    try {
      AvengerBO deleteavenger =
          AvengerBO(id: allAvengers[indexx].id, name: 'null');
      await avengerServiceInstance.deleteHeroFromAvenger(hero: deleteavenger);
      await fetchAllAvengers();
    } catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method named editpopdisplay() with required paramter indexs to display the pop for edit action avenger Api */
  void editpopdisplay({required int indexs}) {
    try {
      //textvalue = allAvengers[indexs].name.toString();
      showpopcontroller(event: Popup(data: [indexs, "editavengerdialog"]));
    } catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method named popdisplayCreate() to display the pop for create avenger action avenger Api */
  void popdisplayCreate() {
    try {
      showpopcontroller(event: Popup(data: [null, "showavengerdialog"]));
    } catch (e) {
      e.writeExceptionData();
    }
  }

  /* Create a method named closepopups() to close the pop */
  void closepopups() {
    bool actions = true;

    if (actions) {
      actions = false;
      navigationStream.add(NavigatorPop());
    }
  }

  /* text methods */

  void textsend({required String value}) {
    textvalue = value;
    addTextController(event: Textfield(data: textvalue));
  }
}
