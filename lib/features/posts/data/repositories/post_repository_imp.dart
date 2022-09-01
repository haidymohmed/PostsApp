import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:clean_architecture/features/posts/data/models/post_model.dart';
import 'package:clean_architecture/features/posts/domain/entities/post.dart';
import 'package:clean_architecture/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';
import '../data_sources/post_local_data_source.dart';

class PostRepositoryImpl implements PostRepository{
  final PostRemoteDataSource remoteDataSource ;
  final PostLocalDataSource localDataSource ;
  final NetworkInfo networkInfo;
  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
  });
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async{
    if(await networkInfo.isConnected){
      try{
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      }on EmptyCacheFailure{
        return Left(EmptyCacheFailure());
      }
    }
  }
  @override
  Future<Either<Failure, Unit>> insertPost(Post post) async{
    final PostModel postModel = PostModel(id: post.id, body: post.body, title: post.title);
    return _getMessage(() => remoteDataSource.addPost(postModel));
  }
  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async{
    final PostModel postModel = PostModel(id: post.id, body: post.body, title: post.title);
    return _getMessage(() => remoteDataSource.updatePost(postModel));
  }
  @override
  Future<Either<Failure, Unit>> deletePost(int id) async{
    return _getMessage(() => remoteDataSource.deletePost(id));
  }

  Future<Either<Failure, Unit>> _getMessage(Future<Unit> Function() method) async{
    if(await networkInfo.isConnected){
      try{
        await method();
        return const Right(unit);
      }on ServerException {
        return left(ServerFailure());
      }
    }else{
      return Left(OFFLineFailure());
    }
  }
}