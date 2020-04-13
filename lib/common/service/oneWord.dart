import 'package:dio/dio.dart';
import 'package:jessie_wish/common/local/localStorage.dart';
import 'package:jessie_wish/common/config/config.dart';
import 'dart:convert' as convert;

class OneWordService {
  static getOneWord() async {
    Dio dio = new Dio();
    var response = await dio.get("https://v1.hitokoto.cn/?c=d");
    if (response != null) {
      Map<String, dynamic> oneWord = convert.jsonDecode(response.toString());
      LocalStorage.save(Config.ONE_WORD, oneWord['hitokoto']);
      LocalStorage.save(Config.WORD_AUTHOR, oneWord['from']);
    }
  }
}
