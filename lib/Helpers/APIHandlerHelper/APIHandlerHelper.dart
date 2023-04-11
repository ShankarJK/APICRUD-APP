import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';

class ServiceResult<T> {
  final HttpStatusCode statusCode;
  final String? message;
  final T? content;
  ServiceResult({required this.statusCode, this.message, this.content});
}

HttpStatusCode resolveStatusCode(int statusCode) {
  try {
    return HttpStatusCode.values.firstWhere((e) => StatusCode[e] == statusCode);
  } catch (error) {
    return HttpStatusCode.SystemException;
  }
}

  /* Create an extension class on Response */
extension ServiceResultExtension on Response {
  /* Create method to decode the response and return serviceResult.*/
  ServiceResult<T> getAPIServiceResult<T>(Response response) {
    try {
      // Initialize variables for message and content of var type
      var message, content;

      try {
        // Decode the responseBody and assign to content.
        content = JsonMapper.deserialize<T>(response.data);

        try {
          // Assign the message as message
          message = content["message"];
        } catch (exception) {
          // If there is an exception, assign the message as ""
          message = "";
        }
      } 
      catch (e) {
        // return the ServiceResult with the content , message and the statusCode
        return ServiceResult(
            statusCode: resolveStatusCode(response.statusCode!),
            message: e.toString(),
            content: content);
      }

      // return the ServiceResult with the content , message and the statusCode
      return ServiceResult(
          statusCode: resolveStatusCode(response.statusCode!),
          message: message,
          content: content);
    } catch (exception) {
      // If there is an execption, return the ServiceResult statusCode as
      // SystemException , message as exception  and content as null
      return ServiceResult(
          statusCode: HttpStatusCode.SystemException,
          message: exception.toString(),
          content: null);
    }
  }
}

enum HttpStatusCode {
  Continue,
  SwitchingProtocols,
  Processing,
  EarlyHints,
  OK,
  Created,
  Accepted,
  NonAuthoritativeInformation,
  NoContent,
  ResetContent,
  PartialContent,
  MultiStatus,
  AlreadyReported,
  IMUsed,
  MultipleChoices,
  Ambiguous,
  MovedPermanently,
  Moved,
  Found,
  Redirect,
  SeeOther,
  RedirectMethod,
  NotModified,
  UseProxy,
  Unused,
  TemporaryRedirect,
  RedirectKeepVerb,
  PermanentRedirect,
  BadRequest,
  Unauthorized,
  PaymentRequired,
  Forbidden,
  NotFound,
  MethodNotAllowed,
  NotAcceptable,
  ProxyAuthenticationRequired,
  RequestTimeout,
  Conflict,
  Gone,
  LengthRequired,
  PreconditionFailed,
  RequestEntityTooLarge,
  RequestUriTooLong,
  UnsupportedMediaType,
  RequestedRangeNotSatisfiable,
  ExpectationFailed,
  MisdirectedRequest,
  UnprocessableEntity,
  Locked,
  FailedDependency,
  UpgradeRequired,
  PreconditionRequired,
  TooManyRequests,
  RequestHeaderFieldsTooLarge,
  UnavailableForLegalReasons,
  InternalServerError,
  NotImplemented,
  BadGateway,
  ServiceUnavailable,
  GatewayTimeout,
  HttpVersionNotSupported,
  VariantAlsoNegotiates,
  InsufficientStorage,
  LoopDetected,
  NotExtended,
  NetworkAuthenticationRequired,
  SystemException,
  NetworkFailure
}

final StatusCode = {
  HttpStatusCode.Continue: 100,
  HttpStatusCode.SwitchingProtocols: 101,
  HttpStatusCode.Processing: 102,
  HttpStatusCode.EarlyHints: 103,
  HttpStatusCode.OK: 200,
  HttpStatusCode.Created: 201,
  HttpStatusCode.Accepted: 202,
  HttpStatusCode.NonAuthoritativeInformation: 203,
  HttpStatusCode.NoContent: 204,
  HttpStatusCode.ResetContent: 205,
  HttpStatusCode.PartialContent: 206,
  HttpStatusCode.MultiStatus: 207,
  HttpStatusCode.AlreadyReported: 208,
  HttpStatusCode.IMUsed: 226,
  HttpStatusCode.MultipleChoices: 300,
  HttpStatusCode.Ambiguous: 300,
  HttpStatusCode.MovedPermanently: 301,
  HttpStatusCode.Moved: 301,
  HttpStatusCode.Found: 302,
  HttpStatusCode.Redirect: 302,
  HttpStatusCode.SeeOther: 303,
  HttpStatusCode.RedirectMethod: 303,
  HttpStatusCode.NotModified: 304,
  HttpStatusCode.UseProxy: 305,
  HttpStatusCode.Unused: 306,
  HttpStatusCode.TemporaryRedirect: 307,
  HttpStatusCode.RedirectKeepVerb: 307,
  HttpStatusCode.PermanentRedirect: 308,
  HttpStatusCode.BadRequest: 400,
  HttpStatusCode.Unauthorized: 401,
  HttpStatusCode.PaymentRequired: 402,
  HttpStatusCode.Forbidden: 403,
  HttpStatusCode.NotFound: 404,
  HttpStatusCode.MethodNotAllowed: 405,
  HttpStatusCode.NotAcceptable: 406,
  HttpStatusCode.ProxyAuthenticationRequired: 407,
  HttpStatusCode.RequestTimeout: 408,
  HttpStatusCode.Conflict: 409,
  HttpStatusCode.Gone: 410,
  HttpStatusCode.LengthRequired: 411,
  HttpStatusCode.PreconditionFailed: 412,
  HttpStatusCode.RequestEntityTooLarge: 413,
  HttpStatusCode.RequestUriTooLong: 414,
  HttpStatusCode.UnsupportedMediaType: 415,
  HttpStatusCode.RequestedRangeNotSatisfiable: 416,
  HttpStatusCode.ExpectationFailed: 417,
  HttpStatusCode.MisdirectedRequest: 421,
  HttpStatusCode.UnprocessableEntity: 422,
  HttpStatusCode.Locked: 423,
  HttpStatusCode.FailedDependency: 424,
  HttpStatusCode.UpgradeRequired: 426,
  HttpStatusCode.PreconditionRequired: 428,
  HttpStatusCode.TooManyRequests: 429,
  HttpStatusCode.RequestHeaderFieldsTooLarge: 431,
  HttpStatusCode.UnavailableForLegalReasons: 451,
  HttpStatusCode.InternalServerError: 500,
  HttpStatusCode.NotImplemented: 501,
  HttpStatusCode.BadGateway: 502,
  HttpStatusCode.ServiceUnavailable: 503,
  HttpStatusCode.GatewayTimeout: 504,
  HttpStatusCode.HttpVersionNotSupported: 505,
  HttpStatusCode.VariantAlsoNegotiates: 506,
  HttpStatusCode.InsufficientStorage: 507,
  HttpStatusCode.LoopDetected: 508,
  HttpStatusCode.NotExtended: 510,
  HttpStatusCode.NetworkAuthenticationRequired: 0x1FF,
  HttpStatusCode.NetworkFailure: 500
};
