import 'package:clean_architecture/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class AddPostUseCase{
  final PostRepository repository;
  AddPostUseCase(this.repository);
  Future<Either<Failure , Unit>> call (Post post) async{
    return await repository.insertPost(post);
  }
}