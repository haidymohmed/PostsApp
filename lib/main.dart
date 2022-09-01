import 'package:clean_architecture/features/posts/presentaion/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/posts/posts_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_theme.dart';
import 'features/posts/presentaion/bloc/add_update_delete_posts/add_update_delete_bloc.dart';
import 'features/posts/presentaion/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_) => di.sl<AddUpdateDeletePostBloc>()),
        ],
        child: MaterialApp(
          title: 'Posts App',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          home: PostsPage(),
        )
    );
  }
}
