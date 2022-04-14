import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/article.dart';

String apiKey = '1b4619be26324f0bb6710dff6d872e5f';
String baseUrl = 'https://newsapi.org/v2';

class News{

  Future<List<Article>?> getNews() async {
    List<Article>? list;
    String url = '$baseUrl/top-headlines?country=id&apiKey=$apiKey';
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var result = data['articles'] as List;
      list = result.map((json) => Article.fromJson(json)).toList();
      print(response.body);
      return list;
    }else{
      throw Exception("cannot load data");
    }
  }

  Future<List<Article>?> getNewsCategory(String category) async {
    List<Article>? list;
    String url = '$baseUrl/top-headlines/sources?category=$category&apiKey=$apiKey';
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var result = data['articles'] as List;
      list = result.map((json) => Article.fromJson(json)).toList();
      print(response.body);
      return list;
    }else{
      throw Exception("error can't get data");
    }
  }

  getNewsByCategory(String string) {}
}