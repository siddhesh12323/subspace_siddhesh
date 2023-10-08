part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

abstract class PostsActionState extends PostsState {}

class PostsFetchingLoadingState extends PostsState {}

class PostsFetchingErrorState extends PostsActionState {}

class PostsLoaded extends PostsState {
  final List<Blog> blogs;

  PostsLoaded(this.blogs);
}
