import 'package:blog_app/core/theme/color_pallete.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              DottedBorder(
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
                      Text('Select your image', style: TextStyle(fontSize: 15)),
                    ],
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
