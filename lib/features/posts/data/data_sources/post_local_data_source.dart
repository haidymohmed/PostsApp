import 'dart:convert';
import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModel);
}

const String CACHED_POSTS = "CACHED_POSTS";
class PostLocalDataSourceImp implements PostLocalDataSource {
  SharedPreferences sharedPreferences ;
  PostLocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModel) {
    List postModelToJson = postModel.map<Map<String , dynamic>>((e) => e.toJson()).toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if(jsonString != null){
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostsModel = decodeJsonData.map<PostModel>((e) => PostModel.fromJson(e)).toList();
      return Future.value(jsonToPostsModel);
    }
    else{
      throw EmptyCachedException();
    }
  }
}