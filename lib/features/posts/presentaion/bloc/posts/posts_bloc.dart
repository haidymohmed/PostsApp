import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/posts/posts_event.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/posts/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/strings/error.dart';

class PostsBloc extends Bloc<PostsEvent , PostsState>{
  final GetAllPostsUserCase getAllPosts ;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()){
    on<PostsEvent>((event , emit) async{
       if(event is GetAllPostsEvent || event is RefreshPostEvent){
         emit(LoadingPostsState());
         final failurePosts = await getAllPosts();
         failurePosts.fold(
           (failure){
             emit(ErrorPostsState(message: _mapFaiLureToMessage(failure)));
           },
           (posts){
             emit(LoadedPostsState(posts: posts));
           }
         );
       }
    });
  }
  String _mapFaiLureToMessage (Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure :
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OFFLineFailure :
         return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}