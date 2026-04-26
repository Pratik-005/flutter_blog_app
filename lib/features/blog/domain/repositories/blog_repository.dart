import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uplaodBlog({
    required File image,
    required String title,
    required String conetent,
    required String posterId,
    required List<String> topics,
  });

  Future<Either<Failure, List<Blog>>> getBlogs();
}
