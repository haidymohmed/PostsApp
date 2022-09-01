import 'package:clean_architecture/core/util/snack_bar.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/add_update_delete_posts/add_update_delete_bloc.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/add_update_delete_posts/add_update_delete_state.dart';
import 'package:clean_architecture/features/posts/presentaion/pages/posts_page.dart';
import 'package:clean_architecture/features/posts/presentaion/widets/posts_page/loading_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post.dart';
import '../widets/post_add_update/form_widet.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post post ;
  final bool isUpdatePost ;
  const PostAddUpdatePage({Key? key , required this.post , required this.isUpdatePost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _AppBar(),
        body: _buildBody(context),
      ),
    );
  }
  _buildBody(BuildContext context){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateDeletePostBloc , AddUpdateDeletePostState>(
          listener: (context , state){
            if(state is MessageAddUpdateDeletePostState){
              SnackBarMessage.success(context:  context , message: state.message);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  PostsPage()), (Route<dynamic> route) => false);
            }
            else if(state is ErrorAddUpdateDeletePostState){
              SnackBarMessage.fail(context:  context , message: state.message );
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  PostsPage()), (Route<dynamic> route) => false);
            }
          },
          builder: (context , state){
            if(state is LoadingAddUpdateDeletePostState){
              return LoadingWidget();
            }
            return FormWidget(isUpdatePost : isUpdatePost , post : post);
          },
        ),
      ),
    );
  }
  _AppBar(){
    return AppBar(
      title: Text(
        isUpdatePost ? "Edit Post" : "Add Post"
      ),
    );
  }
}
