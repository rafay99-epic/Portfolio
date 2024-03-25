// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/admin/backend/article_functionality/article_functionality.dart';
import 'package:rafay_portfolio/admin/backend/model/BlogModel.dart';
import 'package:rafay_portfolio/admin/frontend/pages/article/article_add.dart';
import 'package:rafay_portfolio/admin/frontend/pages/article/article_update.dart';
import 'package:rafay_portfolio/admin/frontend/widgets/admin_drawer.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';

class BlogPostAdmin extends StatefulWidget {
  const BlogPostAdmin({Key? key}) : super(key: key);

  @override
  State<BlogPostAdmin> createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPostAdmin> {
  final ArticleFunctionality articleFunctionality = ArticleFunctionality();
  bool isSearchBarVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Blog Posts'),
            const Spacer(),
            AnimatedContainer(
              width: isSearchBarVisible ? 200 : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isSearchBarVisible
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            articleFunctionality.searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search blog posts...',
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearchBarVisible = !isSearchBarVisible;
                });
              },
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      drawer: const MyDrawerAdmin(),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.background,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddBlogPost(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: articleFunctionality.getBlogPosts(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Lottie.asset('assets/animation/datanotfound.json'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset('assets/animation/loader.json'),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            // Add this condition
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 20.0, bottom: 20.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Lottie.asset('assets/animation/datanotfound.json'),
                    const SizedBox(height: 10),
                    StyledText(
                      text: "Sorry!! No search results found. ",
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      textAlign: TextAlign.center,
                      bold: true,
                    )
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    BlogPosModel blogPost = BlogPosModel.fromMap(data);

                    return Card(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: StyledText(
                            text: "Title: ${blogPost.title}",
                            fontSize: 18,
                            bold: false,
                            boldWords: const ["Title:"],
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: StyledText(
                                text: "Blog Description: ${blogPost.subTitle}",
                                fontSize: 15,
                                bold: false,
                                boldWords: const ["Blog Description:"],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: StyledText(
                                text: "Author: ${blogPost.author}",
                                fontSize: 13,
                                bold: false,
                                boldWords: const ["Author:"],
                              ),
                            ),
                            Wrap(
                              runSpacing: 4.0,
                              spacing: 8.0,
                              children: blogPost.tags.map((tag) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Chip(
                                    label: Text(tag),
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateBlogPost(document.id),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                blogPost.isEnabled
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: blogPost.isEnabled
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              onPressed: () async {
                                if (blogPost.isEnabled) {
                                  await articleFunctionality
                                      .disableBlogPost(document.id);
                                } else {
                                  await articleFunctionality
                                      .enableBlogPost(document.id);
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: StyledText(
                                      text: 'Delete Blog Post',
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    content: StyledText(
                                      text:
                                          'Are you sure you want to delete this blog post?',
                                      fontSize: 18,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: StyledText(
                                          text: 'Cancel',
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const StyledText(
                                          text: 'Delete',
                                          fontSize: 14,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          await articleFunctionality
                                              .deleteBlogPost(document.id);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
