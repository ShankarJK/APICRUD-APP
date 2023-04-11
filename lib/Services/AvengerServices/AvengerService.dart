import 'dart:io';

import 'package:apiintegration/Helpers/APIHandlerHelper/APIHandlerHelper.dart';

import 'package:apiintegration/BO/AvengerBO/AvengerBO.dart';
import 'package:apiintegration/Helpers/AppConstants/AppConstants.dart';
import 'package:apiintegration/Helpers/Utitilites/Utilities.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'IAvengerService.dart';

import "package:dio/dio.dart";

class AvengerService implements IAvengerService {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: AppConstants.avengerServiceBaseUrl));

  /* override a method createNewAvenger() to create new avenger using api */
  @override
  Future<ServiceResult<AvengerBO>> createNewAvenger(
      {required AvengerBO nameOfHero}) async {
    try {
      var postvalue = JsonMapper.serialize(nameOfHero);
      var postresponse = await _dio.post(
          AppConstants.avengerServiceCreateNewHeroEndPoint,
          data: postvalue);

      if (postresponse.statusCode == 201) {
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            message: "created",
            content: JsonMapper.deserialize<AvengerBO>(postresponse.data));
      } else {
        return ServiceResult(
            statusCode: HttpStatusCode.BadRequest, message: "not created");
      }
    } on FormatException {
      return ServiceResult(
          statusCode: HttpStatusCode.Forbidden,
          message: "The datatype is incorrect");
    } on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        message: "There is not internet connection!",
      );
    } catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        message: e.toString(),
      );
    }
  }

  /* override a method deleteHeroFromAvenger() to delete hero from the avengers */
  @override
  Future<ServiceResult<List<AvengerBO>>> deleteHeroFromAvenger(
      {required AvengerBO hero}) async {
    try {
      var resposeFromServer = await _dio.delete(
          "${AppConstants.avengerServiceDeleteHeroEndPoint}/${hero.id}");
      if (resposeFromServer.statusCode == 200) {
        var content = resposeFromServer.data;
        List<AvengerBO> finalContent = [];
        if (content is List) {
          for (var element in content) {
            var instance = JsonMapper.deserialize<AvengerBO>(element);
            if (instance != null) {
              finalContent.add(instance);
            }
          }
        }
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got Successfully");
      }
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been got",
      );
    } on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    } on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is not internet connection!",
      );
    } catch (e) {
      e.writeExceptionData();
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
    try {
      var editheroname = JsonMapper.serialize(hero);
      var editvalue = await _dio.put(
          "${AppConstants.avengerServiceEditHeroEndPoint}/${hero.id}",
          data: editheroname);
      if (editvalue.statusCode == 200) {
        var content = editvalue.data;
        List<AvengerBO> finalContent = [];
        if (content is List) {
          for (var element in content) {
            var instance = JsonMapper.deserialize<AvengerBO>(element);
            if (instance != null) {
              finalContent.add(instance);
            }
          }
        }
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got Successfully");
      }
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been got",
      );
    } on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    } on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is not internet connection!",
      );
    } catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }

  /* override a method getAllAvengers() to retrive all avengers using api */
  @override
  Future<ServiceResult<List<AvengerBO>>> getAllAvengers() async {
    try {
      var resposeFromServer =
          await _dio.get(AppConstants.avengerServiceGetAllAvengerEndPoint);
      if (resposeFromServer.statusCode == 200) {
        var content = resposeFromServer.data;
        List<AvengerBO> finalContent = [];
        if (content is List) {
          for (var element in content) {
            var instance = JsonMapper.deserialize<AvengerBO>(element);
            if (instance != null) {
              finalContent.add(instance);
            }
          }
        }
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got Successfully");
      }
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been got",
      );
    } on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    } on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is not internet connection!",
      );
    } catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }
}
