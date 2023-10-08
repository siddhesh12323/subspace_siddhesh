import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:siddhesh/features/posts/model/posts_data_ui_model.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
    List<Blog> blogs = [];
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });
      Map result = jsonDecode(response.body);
      for (var i = 0; i < result["blogs"].length; i++) {
        var blog = Blog.fromMap((result["blogs"][i] as Map<String, dynamic>));
        blogs.add(blog);
      }
      print(response.body);
      emit(PostsLoaded(blogs));
    } catch (e) {
      emit(PostsFetchingErrorState());
      log(e.toString());
    }
  }
}
