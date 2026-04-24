import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_blog_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase uploadBlogUseCase;
  BlogBloc(this.uploadBlogUseCase) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_upload);
  }

  void _upload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await uploadBlogUseCase(
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
      (r) => emit(BlogSuccess()),
    );
  }
}
