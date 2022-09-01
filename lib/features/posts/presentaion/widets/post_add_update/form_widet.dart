import 'package:clean_architecture/features/posts/presentaion/bloc/add_update_delete_posts/add_update_delete_bloc.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/add_update_delete_posts/add_update_delete_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/post.dart';

class FormWidget extends StatefulWidget {
  final isUpdatePost;
  Post? post;
  FormWidget({Key? key , required this.isUpdatePost , this.post}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    if(widget.isUpdatePost){
      title.text = widget.post!.title;
      body.text = widget.post!.body;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
              child: TextFormField(
                controller: title,
                validator: (v) => v!.isEmpty ? "Title Can't be empty" : null,
                minLines: 3,
                maxLines: 3,
                decoration: const InputDecoration(hintText: "Title"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
              child: TextFormField(
                controller: body,
                validator: (v) => v!.isEmpty ? "Body Can't be empty" : null,
                decoration: const InputDecoration(hintText: "Body"),
                maxLines: 6,
                minLines: 6,
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  debugPrint("========================= ${ widget.post!.title.toString()}======================");
                  // ignore: non_constant_identifier_names
                  if(formKey.currentState!.validate() == true) {
                    final Post post = Post(
                      title: title.text,
                      body: body.text,
                      id : widget.post!.id,
                    );
                    if(widget.isUpdatePost){
                      BlocProvider.of<AddUpdateDeletePostBloc>(context).add(UpdatePostEvent(post: post));
                    }
                    else{
                      BlocProvider.of<AddUpdateDeletePostBloc>(context).add(AddPostEvent(post: post));
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  20 , vertical: 10),
                  child: Text(
                      widget.isUpdatePost ?"Update" : "Add",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      // ignore: prefer_const_constructors
                      fontSize: 20
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
