import 'package:demo/http/base_model.dart';
import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';

class ResponseInterceptor extends Interceptor{
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.statusCode == 200){
      try{
        var rsp = BaseModel.formJson(response.data);
        if(rsp.errorCode == 0){
          if(rsp.data == null){
            handler.next(Response(requestOptions: response.requestOptions,data: true));
          }else if(rsp.errorCode == -1001){
            handler.reject(DioException(requestOptions: response.requestOptions,message: "未登录"));
            showToast("请先登录");
          }else{
            handler.next(Response(requestOptions: response.requestOptions,data: rsp.data));
          }
        }
      }catch(e){
        handler.reject(DioException(requestOptions: response.requestOptions,message: "$e"));
      }
    }else{
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }
}