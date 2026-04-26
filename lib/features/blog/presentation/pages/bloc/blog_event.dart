part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final File image;
  final String title;
  final String conetent;
  final String posterId;
  final List<String> topics;

  BlogUpload({
    required this.image,
    required this.title,
    required this.conetent,
    required this.posterId,
    required this.topics,
  });
}

final class FetchAllBlogs extends BlogEvent {}
