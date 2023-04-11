import 'package:apiintegration/BO/AvengerBO/AvengerBO.dart';
import 'package:apiintegration/Helpers/AppNavigations/NavigationMixin.dart';
import 'package:apiintegration/Services/AvengerServices/IAvengerService.dart';
import 'package:mobx/mobx.dart';
import 'package:get_it/get_it.dart';

import '../../Helpers/Mixins/PopupMixin.dart';
import '../../Helpers/Mixins/TextfieldMixin.dart';
part 'HomeScreenModel.g.dart';

// Create a HomeScreenModel
class HomeScreenModel = _HomeScreenModelBase with _$HomeScreenModel;

abstract class _HomeScreenModelBase with Store ,PopupMixin,TextfieldMixin,NavigationMixin{
  final avengerServiceInstance = GetIt.instance.get<IAvengerService>();

  // Create a variable actionstatus with  bool datatype and assign the true to it 
  bool actionstatus = true;
  
  // Create a variable textvalue with String datatype and assign the empty String to it and make the variable as observable
  @observable
  String textvalue = "";

  // Create a variable allAvengers with  List<AvengerBO> datatype and assign the empty list to it and make the variable as observable
  @observable
  List<AvengerBO> allAvengers = [];

  // Create a variable isAvengersLoading with  bool datatype and assign the false to it 
  @observable
  bool isAvengersLoading = false;

  /* Declare a method setIsAvengersLoading with required parameter isLoading to assign the value to this.isAvengersLoading */
  @action
  void setIsAvengersLoading ({required bool isLoading}){
    isAvengersLoading = isLoading;
  }

  /* Declare a method setAllAvengers with required parameter newAvengers to assign the value to allAvengers */
  @action
  void setAllAvengers({required List<AvengerBO> newAvengers}) {
    allAvengers = [];
    allAvengers = newAvengers;
  }
  
}
