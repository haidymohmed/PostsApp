import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:clean_architecture/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:clean_architecture/features/posts/domain/repositories/post_repositories.dart';
import 'package:clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/add_update_delete_posts/add_update_delete_bloc.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/posts/data/repositories/post_repository_imp.dart';

final sl = GetIt.instance;
Future<void> init ()async{
  //Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddUpdateDeletePostBloc(addPostUseCase: sl(), deletePostUseCase: sl(), updatePostUseCase: sl()));
  
  //UseCases
  sl.registerLazySingleton(() => GetAllPostsUserCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  
  //Repository
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl()
  ));
  //DataSources

  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client : sl()));
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImp(sharedPreferences : sl()));

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: sl()));


  //External
  final sharedPreferences  = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}