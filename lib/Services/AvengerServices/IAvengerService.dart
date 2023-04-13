
import 'package:apiintegration/BO/AvengerBO/AvengerBO.dart';
import 'package:apiintegration/Helpers/APIHandlerHelper/APIHandlerHelper.dart';

// Create a abstract class IAvengerService
abstract class IAvengerService {
  
  /* Create a method getAllAvengers to retrive all avengers using api */
  Future<ServiceResult<List<AvengerBO>>> getAllAvengers();

  /* Create a method createNewAvenger with required parameter nameOfHero to create new avenger using api */
  Future<ServiceResult<AvengerBO>> createNewAvenger({required AvengerBO nameOfHero});

  /* Create a method editNameOfAvenger with required parameter hero to edit/change name of an hero */
  Future<ServiceResult<List<AvengerBO>>> editNameOfAvenger({required AvengerBO hero});

  /* Create a method deleteHeroFromAvenger with required parameter hero to delete hero from the avengers */
  Future<ServiceResult<List<AvengerBO>>> deleteHeroFromAvenger({required AvengerBO hero});

}