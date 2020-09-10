
import 'dart:convert';
import 'package:bloc_example/articles_data/articles_constants/articles_constants.dart';
import 'package:bloc_example/articles_data/models/articles_response.dart';
import 'package:http/http.dart' as http;


class ArticlesRepository{

  Future<List<Articles>> getArticlesData() async {

    var response = await  http.get(ArticlesConstants.newsAPI);
    print('${response.statusCode}');
    print('${response.body}');
    if(response.statusCode == 200){
      var data = json.decode(response.body);
         List<Articles> articles =  ArticlesResponse.fromJson(data).articles;
         return articles;
    }else{
      throw Exception('Failed to load post');
    }

  }

}