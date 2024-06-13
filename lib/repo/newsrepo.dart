import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:currentwave/model/headline_model.dart';
import 'package:currentwave/model/categoriesmodel.dart';

class newsrepo {
  Future<HeadlineModel> fetchHeadlines(String channelName)async{

    String url='https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=e27755bdf756441e859e81a26ebb35fd';

    final response =await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body =jsonDecode(response.body);
     return HeadlineModel.fromJson(body);
    }
    throw Exception('Error');
  }
  Future<Categorymodel> fetchCategories(String Category)async{

    String url='https://newsapi.org/v2/everything?q=${Category}&apiKey=e27755bdf756441e859e81a26ebb35fd';

    final response =await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body =jsonDecode(response.body);
      return Categorymodel.fromJson(body);
    }
    throw Exception('Error');
  }
}