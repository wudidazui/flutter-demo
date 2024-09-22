class BaseModel<T>{
  T? data;
  int? errorCode;
  String? errorMsg;

  BaseModel.formJson(dynamic json){
    data = json['data'];
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }
}