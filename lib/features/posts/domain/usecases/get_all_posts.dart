import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';
import '../entities/post.dart';

class GetAllPostsUserCase{
  final PostRepository repository ;
  GetAllPostsUserCase(this.repository);
  Future<Either<Failure , List<Post>>> call () async{
    return await repository.getAllPosts();
  }
}