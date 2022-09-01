import 'package:clean_architecture/features/posts/domain/entities/post.dart';
import 'package:equatable/equatable.dart';

abstract class AddUpdateDeletePostEvent extends Equatable{
  const AddUpdateDeletePostEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddPostEvent extends AddUpdateDeletePostEvent{
  final Post post ;
  const AddPostEvent({required this.post});
  @override
  List<Object?> get props => [post];
}

class UpdatePostEvent extends AddUpdateDeletePostEvent{
  final Post post ;
  const UpdatePostEvent({required this.post});
  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends AddUpdateDeletePostEvent{
  final int postId ;
  const DeletePostEvent({required this.postId});
  @override
  List<Object?> get props => [postId];
}
