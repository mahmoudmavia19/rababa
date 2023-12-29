 /// todo handle all firebase Error message to arabic message

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is FirebaseException) {
      // firebase error so its an error from response of the API or from firebase itself
      print('--------------------------------${error.code} ------------------------- ${error.message}') ;
      failure = error.getArabicMessage();
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }

}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  CANCEL,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  unknown,
  wrong_password,
  invalid_email,
  too_many_requests,
  user_not_found,
  weak_password,
DEFAULT
}

extension DataSourceString on DataSource {
  getString(){
    switch(this){
      case DataSource.SUCCESS:
        // TODO: Handle this case.
        break;
      case DataSource.NO_CONTENT:
        // TODO: Handle this case.
        break;
      case DataSource.CANCEL:
        // TODO: Handle this case.
        break;
      case DataSource.CACHE_ERROR:
        // TODO: Handle this case.
        break;
      case DataSource.NO_INTERNET_CONNECTION:
        // TODO: Handle this case.
        break;
      case DataSource.unknown:
       return 'unknown';
      case DataSource.DEFAULT:
        // TODO: Handle this case.
        break;
      case DataSource.wrong_password:
        return 'wrong-password';
      case DataSource.invalid_email:
        return 'invalid-email';
      case DataSource.too_many_requests:
        return 'too-many-requests';
      case DataSource.user_not_found:
        return 'user-not-found';
      case DataSource.weak_password:
        return 'weak-password';
    }

  }
}

/*
Failure _handleError(FirebaseException error){
  switch(error.code){
    case DataSource.unknown.getString():
      return DataSource.unknown.getFailure() ;
  }
}*/

extension FirebaseArabicErrorMessage on FirebaseException {
  Failure getArabicMessage(){
    if(code == DataSource.unknown.getString())
      {
        return DataSource.unknown.getFailure() ;
      }
    else if (code == DataSource.wrong_password.getString()){
     return  DataSource.wrong_password.getFailure() ;
    }
    else if (code == DataSource.invalid_email.getString()){
      return  DataSource.invalid_email.getFailure() ;
    }
    else if (code == DataSource.too_many_requests.getString()){
      return  DataSource.too_many_requests.getFailure() ;
    }
    else if (code == DataSource.user_not_found.getString()){
      return  DataSource.user_not_found.getFailure() ;
    }
    else if (code == DataSource.weak_password.getString()){
      return  DataSource.weak_password.getFailure() ;
    }
    else {
      return DataSource.DEFAULT.getFailure() ;
    }
  }
}



extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS.toString(), ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT.toString(), ResponseMessage.NO_CONTENT);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL.toString(), ResponseMessage.CANCEL);

      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR.toString(), ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION.toString(),
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT.toString(), ResponseMessage.DEFAULT);
      case DataSource.unknown:
        return Failure(ResponseCode.unknown.toString(), ResponseMessage.unknown);
      case DataSource.wrong_password:
        return Failure(ResponseCode.wrong_password.toString(), ResponseMessage.wrong_password);
      case DataSource.invalid_email:
        return Failure(ResponseCode.invalid_email.toString(), ResponseMessage.invalid_email);
      case DataSource.too_many_requests:
        return Failure(ResponseCode.too_many_requests.toString(), ResponseMessage.too_many_requests);
      case DataSource.user_not_found:
        return Failure(ResponseCode.user_not_found.toString(), ResponseMessage.user_not_found);
      case DataSource.weak_password:
        return Failure(ResponseCode.weak_password.toString(), ResponseMessage.weak_password);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found
  static const int unknown = 100;  // firebase exception
  static const int wrong_password = 101;  // firebase exception
  static const int invalid_email = 102;  // firebase exception
  static const int too_many_requests = 103;  // firebase exception
  static const int user_not_found = 104;  // firebase exception
  static const int weak_password = 105;  // firebase exception

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = "تم تسجيل الدخول بنجاح"; // success with data
  static const String NO_CONTENT =
      "success"; // success with no data (no content)
  static const String BAD_REQUEST =
      "Bad request, Try again later"; // failure, API rejected request
  static const String UNAUTORISED =
      "User is unauthorised, Try again later"; // failure, user is not authorised
  static const String FORBIDDEN =
      "Forbidden request, Try again later"; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      "Some thing went wrong, Try again later"; // failure, crash in server side
  static const String NOT_FOUND =
      "Some thing went wrong, Try again later"; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = "Time out error, Try again later";
  static const String CANCEL = "Request was cancelled, Try again later";
  static const String RECIEVE_TIMEOUT = "Time out error, Try again later";
  static const String SEND_TIMEOUT = "Time out error, Try again later";
  static const String CACHE_ERROR = "Cache error, Try again later";
  static const String NO_INTERNET_CONNECTION =
      "الرجاء التحقق من اتصال الانترنت الخاص بك";
  static const String DEFAULT = "حدث خطأ ما ، حاول مرة أخرى لاحقًا";
  static const String unknown = "لا يمكن ترك المحتوي فارغ";
  static const String wrong_password = "كلمة المرور غير صالحة أو ليس لدى المستخدم كلمة مرور";
  static const String invalid_email = "عنوان البريد الإلكتروني منسق بشكل سيئ";
  static const String too_many_requests = "لقد حظرنا جميع الطلبات الواردة من هذا الجهاز بسبب نشاط غير عادي. حاول مرة أخرى في وقت لاحق";
  static const String user_not_found = "لا يوجد سجل مستخدم مطابق لهذا المعرف. ربما تم حذف المستخدم";
  static const String weak_password = "يجب أن تتكون كلمة المرور من 8 أحرف على الأقل";
}

class ApiInternalStatus{
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}