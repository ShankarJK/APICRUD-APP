
import 'package:apiintegration/BO/AvengerBO/AvengerBO.dart';
import 'package:apiintegration/Helpers/APIHandlerHelper/APIHandlerHelper.dart';

abstract class IAvengerService {
  
  /* Create a method to retrive all avengers using api */
  Future<ServiceResult<List<AvengerBO>>> getAllAvengers();

  /* Create a method to create new avenger using api */
  Future<ServiceResult<AvengerBO>> createNewAvenger({required AvengerBO nameOfHero});

  /* Create a method to edit/change name of an hero */
  Future<ServiceResult<List<AvengerBO>>> editNameOfAvenger({required AvengerBO hero});

  /* Create a method to delete hero from the avengers */
  Future<ServiceResult<List<AvengerBO>>> deleteHeroFromAvenger({required AvengerBO hero});

}