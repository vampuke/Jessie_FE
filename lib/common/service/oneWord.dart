import 'package:dio/dio.dart';
import 'package:jessie_wish/common/local/localStorage.dart';
import 'package:jessie_wish/common/config/config.dart';

class OneWordService {
  static getOneWord() async {
    Dio dio = new Dio();
    var response = await dio.get("https://v1.hitokoto.cn/?c=d");
    if (response != null) {
      print(response);
      LocalStorage.save(Config.ONE_WORD, response.data['hitokoto']);
      LocalStorage.save(Config.WORD_AUTHOR, response.data['from']);
    }
  }
}
