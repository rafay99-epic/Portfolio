import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rafay_portfolio/admin/backend/blog/blogdelete.dart';
import 'package:rafay_portfolio/admin/backend/model/Blog.dart';
import 'package:rafay_portfolio/admin/frontend/pages/blogs/blogAdd.dart';
import 'package:rafay_portfolio/admin/frontend/widgets/admin_drawer.dart';
import 'package:rafay_portfolio/user/frontend/widgets/textstyle.dart';

class BlogPostAdmin extends StatefulWidget {
  const BlogPostAdmin({Key? key}) : super(key: key);

  @override
  State<BlogPostAdmin> createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPostAdmin> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _blogStream =
        FirebaseFirestore.instance.collection('blogPost').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Posts"),
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
        stream: FirebaseFirestore.instance.collection('blogPosts').snapshots(),
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
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await deleteBlogPost(document.id);
                          },
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
