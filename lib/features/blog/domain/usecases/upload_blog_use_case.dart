import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUseCase implements Usecase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlogUseCase({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(params) async {
    return await blogRepository.uplaodBlog(
      conetent: params.conetent,
      image: params.image,
      posterId: params.conetent,
      title: params.title,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final File image;
  final String title;
  final String conetent;
  final String posterId;
  final List<String> topics;

  UploadBlogParams({
    required this.image,
    required this.title,
    required this.conetent,
    required this.posterId,
    required this.topics,
  });
}
