


import 'package:currentwave/model/headline_model.dart';
import 'package:currentwave/repo/newsrepo.dart';
import 'package:currentwave/model/categoriesmodel.dart';

class newsview{

  final _rep= newsrepo();

  Future<HeadlineModel> fetchHeadlines(String channelName)async{
    final response = await _rep.fetchHeadlines(channelName);
    return response;
  }

  Future<Categorymodel> fetchCategories(String Category)async{
    final response = await _rep.fetchCategories(Category);
    return response;
  }
}