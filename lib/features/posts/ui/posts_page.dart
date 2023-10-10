import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siddhesh/features/posts/ui/posts_detail_page.dart';

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

  Color blogsColor = Color.fromARGB(200, 255, 255, 255);
  Color favoritesColor = Color.fromARGB(80, 255, 255, 255);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Subspace'),
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 45, 0, 0),
              child: SvgPicture.asset(
                'images/subspace_hor.svg', // Replace with your SVG or PNG image path
                height: 26, // Adjust the height as needed
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
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
                child: ScrollConfiguration(
                  behavior: NoOverscrollGlowBehavior(),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                child: Text(
                                  "Blogs",
                                  style: TextStyle(
                                      color: blogsColor, fontSize: 42),
                                ),
                                onTap: () {
                                  //! Navigate to blogs page
                                  setState(() {
                                    blogsColor =
                                        Color.fromARGB(200, 255, 255, 255);
                                    favoritesColor =
                                        Color.fromARGB(80, 255, 255, 255);
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                child: Text(
                                  "Favorites",
                                  style: TextStyle(
                                      color: favoritesColor, fontSize: 42),
                                ),
                                onTap: () {
                                  //! Navigate to facorites page
                                  setState(() {
                                    blogsColor =
                                        Color.fromARGB(80, 255, 255, 255);
                                    favoritesColor =
                                        Color.fromARGB(200, 255, 255, 255);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostsDetailPage(
                                          imageUrl: successState
                                              .blogs[index - 1].imageUrl,
                                          title: successState
                                              .blogs[index - 1].title,
                                        )));
                          },
                          child: Container(
                            color: Color.fromARGB(255, 54, 54, 54),
                            margin: const EdgeInsets.all(8.0),
                            //padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  successState.blogs[index - 1].imageUrl,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                // NetworkImage(url: successState.blogs[index].imageUrl)
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    successState.blogs[index - 1].title,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    itemCount: successState.blogs.length + 1,
                  ),
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

class NoOverscrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
