import 'package:clean_architecture/core/strings/message.dart';
import 'package:clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/add_update_delete_posts/add_update_delete_event.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/add_update_delete_posts/add_update_delete_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/error.dart';

class AddUpdateDeletePostBloc extends Bloc<AddUpdateDeletePostEvent , AddUpdateDeletePostState>{

  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  AddUpdateDeletePostBloc({
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super (AddUpdateDeletePostInitial()){
   on<AddUpdateDeletePostEvent>((event , emit)async{
     if(event is AddPostEvent){
       emit(LoadingAddUpdateDeletePostState());
       final failureOrDoneMessage = await addPostUseCase(event.post);
      emit( _getFailureOrDoneMessage( failureOrDoneMessage , ADD_SUCCESS_MESSAGE));
     }else if(event is UpdatePostEvent){
       emit(LoadingAddUpdateDeletePostState());
       final failureOrDoneMessage = await updatePostUseCase(event.post);
       emit(_getFailureOrDoneMessage( failureOrDoneMessage , UPDATE_SUCCESS_MESSAGE));
     }else if(event is DeletePostEvent){
       emit(LoadingAddUpdateDeletePostState());
       final failureOrDoneMessage =  await deletePostUseCase(event.postId);
       emit(_getFailureOrDoneMessage( failureOrDoneMessage , DELETE_SUCCESS_MESSAGE));
     }
   });
  }

  AddUpdateDeletePostState _getFailureOrDoneMessage(Either<Failure , Unit> failure , String message){
    return failure.fold((fail){
      return ErrorAddUpdateDeletePostState(message: _mapFaiLureToMessage(fail));
    }, (_){
      return MessageAddUpdateDeletePostState(message: message);
    });
  }
  String _mapFaiLureToMessage (Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OFFLineFailure :
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

}