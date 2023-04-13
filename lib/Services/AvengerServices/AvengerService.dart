import 'dart:io';

import 'package:apiintegration/Helpers/APIHandlerHelper/APIHandlerHelper.dart';

import 'package:apiintegration/BO/AvengerBO/AvengerBO.dart';
import 'package:apiintegration/Helpers/AppConstants/AppConstants.dart';
import 'package:apiintegration/Helpers/Utitilites/Utilities.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'IAvengerService.dart';

import "package:dio/dio.dart";

// Create a class AvengerService which implements IAvengerService
class AvengerService implements IAvengerService {

  // Create a instance of Dio and assign the value to the constructor 
  final Dio _dio =
      Dio(BaseOptions(baseUrl: AppConstants.avengerServiceBaseUrl));

  /* Override a method createNewAvenger() to create new avenger using api and make it as async */
  @override
  Future<ServiceResult<AvengerBO>> createNewAvenger(
      {required AvengerBO nameOfHero}) async {

    // Declare the try block 
    try {

      // Create a Variable postvalue and assign the value of serilaized, instance of AvengerBo
      var postvalue = JsonMapper.serialize(nameOfHero);

      // Create a Variable postresponse and assign the response value dio.post()
      var postresponse = await _dio.post(
          AppConstants.avengerServiceCreateNewHeroEndPoint,
          data: postvalue);

      // Checks for the postresponse.statusCode is equal to 201
      if (postresponse.statusCode == 201) {
        // Return the value as ServiceResult() with statuscode, message , content
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            message: "created",
            content: JsonMapper.deserialize<AvengerBO>(postresponse.data));
      }
      // Declare a else block 
       else {
        // Return the value as ServiceResult() with statuscode, message
        return ServiceResult(
            statusCode: HttpStatusCode.BadRequest, message: "not created");
      }
    }

    // Checks for FormatException  
     on FormatException {
        // Return the value as ServiceResult() with statuscode, message
      return ServiceResult(
          statusCode: HttpStatusCode.Forbidden,
          message: "The datatype is incorrect");
    } 

    // Checks for SocketException 
    on SocketException {
      // Return the value as ServiceResult() with statuscode, message
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        message: "There is not internet connection!",
      );
    } 

    // Declare the catch block with paramter e
    catch (e) {
       // Print the exception using writeExceptionData()
      e.writeExceptionData();
      // Return the value as ServiceResult() with statuscode, message
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        message: e.toString(),
      );
    }
  
  }

  /* Override a method deleteHeroFromAvenger() to delete hero from the avengers */
  @override
  Future<ServiceResult<List<AvengerBO>>> deleteHeroFromAvenger(
      {required AvengerBO hero}) async {

    // Declare the try block 
    try {

      // Create a Variable resposeFromServer and assign the response value dio.delete()
      var resposeFromServer = await _dio.delete(
          "${AppConstants.avengerServiceDeleteHeroEndPoint}/${hero.id}");

      // Checks for the resposeFromServer.statusCode is equal to 200

      if (resposeFromServer.statusCode == 200) {
      
      // Create a Variable content and assign the value of resposeFromServer.data
        var content = resposeFromServer.data;

        // Create a variable finalContent with datatype as List<AvengerBO> and assign the empty list to it
        List<AvengerBO> finalContent = [];

        // Checks for the condition content is List
        if (content is List) {

          // Iterate the variable content 
          for (var element in content) {

            // Create a Variable instance and assign the instance of AvengerBO by JsonMapper.deserialize
            var instance = JsonMapper.deserialize<AvengerBO>(element);

            // Checks for the condition instance is not equal to null
            if (instance != null) {
              // Add the instance into the collection finalContent 
              finalContent.add(instance);
            }
          }
        }
        
      // Return the value as ServiceResult() with statuscode, message and content
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got Successfully");
      }

      // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been got",
      );
    } 
    
    // Checks for FormatException  
    on FormatException {
        // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    } 
    // Checks for SocketException  
    on SocketException {
        // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is not internet connection!",
      );
    }
    // Declare the catch block with paramter e
     catch (e) {
       // Print the exception using writeExceptionData()
      e.writeExceptionData();
      // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }

  /* override a method editNameOfAvenger() to edit/change name of an hero */
  @override
  Future<ServiceResult<List<AvengerBO>>> editNameOfAvenger(
      {required AvengerBO hero}) async {

    // Declare the try block 
    try {
      // Create a Variable editheroname and assign the value of serilaized, instance of AvengerBo
      var editheroname = JsonMapper.serialize(hero);

      // Create a Variable editvalue and assign the response value dio.put()
      var editvalue = await _dio.put(
          "${AppConstants.avengerServiceEditHeroEndPoint}/${hero.id}",
          data: editheroname);

      // Checks for the editvalue.statusCode is equal to 200
      if (editvalue.statusCode == 200) {

      // Create a Variable content and assign the value of editvalue.data
        var content = editvalue.data;


        // Create a variable finalContent with datatype as List<AvengerBO> and assign the empty list to it
        List<AvengerBO> finalContent = [];

        // Checks for the condition content is List
        if (content is List) {

          // Iterate the variable content 
          for (var element in content) {

            // Create a Variable instance and assign the instance of AvengerBO by JsonMapper.deserialize
            var instance = JsonMapper.deserialize<AvengerBO>(element);

            // Checks for the condition instance is not equal to null
            if (instance != null) {
              // Add the instance into the collection finalContent 
              finalContent.add(instance);
            }
          }
        }
        
      // Return the value as ServiceResult() with statuscode, message and content
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got Successfully");
      }

      // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been got",
      );
    }
    
    // Checks for FormatException  
    on FormatException {
        // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    } 
    // Checks for SocketException  
    on SocketException {
        // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is not internet connection!",
      );
    }
    // Declare the catch block with paramter e
     catch (e) {
       // Print the exception using writeExceptionData()
      e.writeExceptionData();
      // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }

  /* Override a method getAllAvengers() to retrive all avengers using api */
  @override
  Future<ServiceResult<List<AvengerBO>>> getAllAvengers() async {
    // Declare the try block 
    try {

      // Create a Variable resposeFromServer and assign the response value dio.put()
      var resposeFromServer =
          await _dio.get(AppConstants.avengerServiceGetAllAvengerEndPoint);
      
      // Checks for the resposeFromServer.statusCode is equal to 200

      if (resposeFromServer.statusCode == 200) {
      
      // Create a Variable content and assign the value of resposeFromServer.data
        var content = resposeFromServer.data;

        // Create a variable finalContent with datatype as List<AvengerBO> and assign the empty list to it
        List<AvengerBO> finalContent = [];

        // Checks for the condition content is List
        if (content is List) {

          // Iterate the variable content 
          for (var element in content) {

            // Create a Variable instance and assign the instance of AvengerBO by JsonMapper.deserialize
            var instance = JsonMapper.deserialize<AvengerBO>(element);

            // Checks for the condition instance is not equal to null
            if (instance != null) {
              // Add the instance into the collection finalContent 
              finalContent.add(instance);
            }
          }
        }

      // Return the value as ServiceResult() with statuscode, message and content
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got Successfully");
      }
      // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been got",
      );
    }    
    
    // Checks for FormatException  
    on FormatException {
        // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    } 
    // Checks for SocketException  
    on SocketException {
        // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is not internet connection!",
      );
    }
    // Declare the catch block with paramter e
     catch (e) {
       // Print the exception using writeExceptionData()
      e.writeExceptionData();
      // Return the value as ServiceResult() with statuscode, message and content
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }
}
