import 'dart:io';

import 'package:blog_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/theme/color_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/core/widgets/Loader.dart';
import 'package:blog_app/features/blog/presentation/pages/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  List<String> topics = [];

  File? image;

  final formKey = GlobalKey<FormState>();

  void selectImage() async {
    final pickedImage = await pickFile();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        topics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
        BlogUpload(
          image: image!,
          title: titleController.text.trim(),
          conetent: contentController.text.trim(),
          posterId: posterId,
          topics: topics,
        ),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogFailure) {
          showSnackbar(context, state.message);
        }

        if (state is BlogSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => BlogPage()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is BlogLoading) {
          return Loader();
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => uploadBlog(),
                icon: Icon(Icons.done_all_rounded),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: () => selectImage(),
                            child: SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(image!, fit: BoxFit.cover),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => selectImage(),
                            child: DottedBorder(
                              options: RectDottedBorderOptions(
                                color: AppPallete.borderColor,
                                dashPattern: const [20, 4],
                                strokeCap: StrokeCap.round,
                              ),
                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder_open, size: 40),
                                    SizedBox(height: 20),
                                    Text(
                                      'Select your image',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                                  'Technology',
                                  'Bussiness',
                                  'Programming',
                                  'Entertainment',
                                ]
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      if (topics.contains(e)) {
                                        topics.remove(e);
                                      } else {
                                        topics.add(e);
                                      }

                                      setState(() {});
                                    },
                                    child: Chip(
                                      color: topics.contains(e)
                                          ? const WidgetStatePropertyAll(
                                              AppPallete.gradient1,
                                            )
                                          : null,
                                      label: Text(e),
                                      side: BorderSide(
                                        color: AppPallete.borderColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    BlogEditor(controller: titleController, hintText: 'Title'),
                    SizedBox(height: 20),
                    BlogEditor(
                      controller: contentController,
                      hintText: 'Blog Content',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
