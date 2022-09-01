
import 'package:clean_architecture/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class DeletePostUseCase{
  final PostRepository repository;
  DeletePostUseCase(this.repository);
  Future<Either<Failure , Unit>> call (int id) async{
    return await repository.deletePost(id);
  }
}