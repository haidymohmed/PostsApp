import 'package:clean_architecture/core/app_theme.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/posts/posts_event.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/posts/posts_state.dart';
import 'package:clean_architecture/features/posts/presentaion/pages/post_add_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post.dart';
import '../widets/posts_page/loading_widgets.dart';
import '../widets/posts_page/message_display.dart';
import '../widets/posts_page/post_list_widget.dart';
class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => PostAddUpdatePage(isUpdatePost: false, post: Post(title: '' , body: '' , id: 0),)));
          },
          backgroundColor: secondaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  AppBar _buildAppBar(){
    return AppBar(
      title: Text("Posts"),
    );
  }
  Widget _buildBody(){
    return Padding(
      padding: EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc , PostsState>(
        builder: (context , state){
          if(state is LoadingPostsState){
            return LoadingWidget();
          }else if(state is LoadedPostsState){
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostsListWidget(
                  posts : state.posts
              ),
            );
          }else if(state is ErrorPostsState){
            return MessageDisplay(
              message : state.message
            );
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
  Future<void> _onRefresh(BuildContext context)async{
    BlocProvider.of<PostsBloc>(context).add(RefreshPostEvent());
  }
}
