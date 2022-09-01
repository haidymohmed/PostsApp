import 'package:equatable/equatable.dart';

import '../../../domain/entities/post.dart';

abstract class PostsState extends Equatable{
  const PostsState();
  @override
  List<Object> get props => [];
}
class PostsInitial extends  PostsState{}
class LoadingPostsState extends PostsState{}
class LoadedPostsState extends PostsState{
  final List<Post> posts ;
  const LoadedPostsState({required this.posts});
}
// ignore: must_be_immutable
class ErrorPostsState extends PostsState{
  String message ;
  ErrorPostsState({required this.message});
  @override
  List<Object> get props => [message];
}