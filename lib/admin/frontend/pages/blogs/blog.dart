import 'package:flutter/material.dart';
import 'package:rafay_portfolio/admin/frontend/pages/blogs/blogAdd.dart';
import 'package:rafay_portfolio/admin/frontend/widgets/admin_drawer.dart';

class BlogPostAdmin extends StatefulWidget {
  const BlogPostAdmin({Key? key}) : super(key: key);

  @override
  State<BlogPostAdmin> createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPostAdmin> {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
