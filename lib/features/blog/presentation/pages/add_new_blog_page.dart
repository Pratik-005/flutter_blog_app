import 'dart:io';

import 'package:blog_app/core/theme/color_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

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

  void selectImage() async {
    final pickedImage = await pickFile();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.done_all_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              image != null
                  ? SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(image!, fit: BoxFit.cover),
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
                                side: BorderSide(color: AppPallete.borderColor),
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
    );
  }
}
