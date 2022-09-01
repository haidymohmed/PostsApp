import 'package:clean_architecture/features/posts/presentaion/pages/post_add_update.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts ;

  const PostsListWidget({Key? key , required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context , index){
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(posts[index].title.toString()),
          subtitle: Text(posts[index].body.toString()),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => PostAddUpdatePage(post: posts[index], isUpdatePost: true)));
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 1,
        );
      },
    );
  }
}
