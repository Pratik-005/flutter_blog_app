import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_use_case.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;
  final GetAllBlogsUseCase _getAllBlogsUseCase;
  BlogBloc({
    required UploadBlogUseCase uploadBlogUseCase,
    required GetAllBlogsUseCase getAllBlogsUseCase,
  }) : _uploadBlogUseCase = uploadBlogUseCase,
       _getAllBlogsUseCase = getAllBlogsUseCase,
       super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_upload);
    on<FetchAllBlogs>(_getBlogs);
  }

  void _upload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlogUseCase(
      UploadBlogParams(
        image: event.image,
        title: event.title,
        conetent: event.conetent,
        posterId: event.posterId,
        topics: event.topics,
      ),
    );

    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _getBlogs(FetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogsUseCase(NoParams());

    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogDisplaySuccess(blogs: r)),
    );
  }
}
