import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:jessie_wish/common/service/errorCode.dart';


import 'package:jessie_wish/common/config/Config.dart';
import 'package:connectivity/connectivity.dart';
import 'package:jessie_wish/common/utils/globalEvent.dart';


///http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000
  };

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static netFetch(url, params, Map<String, String> header, Options option,
      {noTip = false}) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip),
          false,
          Code.NETWORK_ERROR);
    }



    if (option == null) {
      option = new Options(method: "get");
    }

    ///超时
    option.sendTimeout = 5000;
    option.receiveTimeout = 5000;

    Dio dio = new Dio();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    dio.interceptors.add(CookieManager(PersistCookieJar(storage: FileStorage(tempPath))));
    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.connectTimeout) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (Config.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常url: ' + url);
      }
      if (url != "https://jessie.vampuck.com/network") {
        eventBus.fire(LogoutEvent(true));
      }
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    // if (Config.DEBUG) {
    //   print('请求url: ' + url);
    //   print('请求头: ' + option.headers.toString());
    //   if (params != null) {
    //     print('请求参数: ' + params.toString());
    //   }
    //   if (response != null) {
    //     print('返回参数: ' + response.toString());
    //   }
    //   if (optionParams["authorizationCode"] != null) {
    //     print('authorizationCode: ' + optionParams["authorizationCode"]);
    //   }
    // }

    try {
      return new ResultData(response.data, true, Code.SUCCESS);
    } catch (e) {
      print(e.toString() + url);
      return new ResultData(response.data, false, response.statusCode);
    }
  }
}

class ResultData {
  var data;
  bool result;
  int code;
  var headers;

  ResultData(this.data, this.result, this.code);
}
