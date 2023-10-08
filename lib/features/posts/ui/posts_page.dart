import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsBloc postsBloc = PostsBloc();
  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subspace'),
        centerTitle: true,
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsFetchingLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostsFetchingErrorState:
              return const Center(
                child: Text('Error'),
              );
            case PostsLoaded:
              final successState = state as PostsLoaded;
              return Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey.shade200,
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(successState.blogs[index].title),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(successState.blogs[index].imageUrl),
                        ],
                      ),
                    );
                  },
                  itemCount: successState.blogs.length,
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
