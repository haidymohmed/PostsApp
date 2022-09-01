

import 'package:equatable/equatable.dart';

abstract class AddUpdateDeletePostState extends Equatable{
  // ignore: non_constant_identifier_names
  AddUpdateDeletePostEvent();

  @override
  List<Object> get props => [];
}
class AddUpdateDeletePostInitial extends AddUpdateDeletePostState{
  @override
  AddUpdateDeletePostEvent() {
    // TODO: implement AddUpdateDeletePostEvent
    throw UnimplementedError();
  }
}
class LoadingAddUpdateDeletePostState extends AddUpdateDeletePostState{
  @override
  AddUpdateDeletePostEvent() {
    // TODO: implement AddUpdateDeletePostEvent
    throw UnimplementedError();
  }

}
class ErrorAddUpdateDeletePostState extends AddUpdateDeletePostState{
  final String message ;
  ErrorAddUpdateDeletePostState({required this.message});
  @override
  AddUpdateDeletePostEvent() {
    // TODO: implement AddUpdateDeletePostEvent
    throw UnimplementedError();
  }
}
class MessageAddUpdateDeletePostState extends AddUpdateDeletePostState{
  final String message ;
  MessageAddUpdateDeletePostState({required this.message});
  @override
  AddUpdateDeletePostEvent() {
    // TODO: implement AddUpdateDeletePostEvent
    throw UnimplementedError();
  }
}